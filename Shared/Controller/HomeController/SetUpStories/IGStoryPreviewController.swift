//
//  IGStoryPreviewController.swift
//  InstagramStories
//
//  Created by Boominadha Prakash on 06/09/17.
//  Copyright © 2017 DrawRect. All rights reserved.
//

import UIKit
import SDWebImage
/**Road-Map: Story(CollectionView)->Cell(ScrollView(nImageViews:Snaps))
 If Story.Starts -> Snap.Index(Captured|StartsWith.0)
 While Snap.done->Next.snap(continues)->done
 then Story Completed
 */
 class IGStoryPreviewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Private Vars
    private var _view: IGStoryPreviewView {return view as! IGStoryPreviewView}
    
    private var viewModel: IGStoryPreviewModel?
    
    private(set) var stories: [IGStory]
    /** This index will tell you which Story, user has picked*/
    private(set) var handPickedStoryIndex: Int //starts with(i)
    /** This index will tell you which Snap, user has picked*/
    private(set) var handPickedSnapIndex: Int //starts with(i)
    /** This index will help you simply iterate the story one by one*/
    
    static var nStoryIndex: Int = 0 //iteration(i+1)
    private var story_copy: IGStory?
    private(set) var layoutType: IGLayoutType
    private(set) var executeOnce = false
    
    //check whether device rotation is happening or not
    private(set) var isTransitioning = false
    private(set) var currentIndexPath: IndexPath?
        
    private var currentCell: IGStoryPreviewCell? {
        guard let indexPath = self.currentIndexPath else {
            debugPrint("Current IndexPath is nil")
            return nil
        }
        return self._view.snapsCollectionView.cellForItem(at: indexPath) as? IGStoryPreviewCell
    }
    
    lazy private var actionSheetController: UIAlertController = {
        let alertController = UIAlertController(title: "JMK Stories", message: "You Want to Delete this Stories", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            self?.deleteSnap()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.currentCell?.resumeEntireSnap()
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        return alertController
    }()
    
    //MARK: - Overriden functions
    internal var isDeleteSnapEnabled = true
    override func viewDidLoad() {
        super.viewDidLoad()

        view = IGStoryPreviewView.init(layoutType: self.layoutType)
        viewModel = IGStoryPreviewModel.init(self.stories, self.handPickedStoryIndex)
        _view.snapsCollectionView.decelerationRate = .fast
        
        if(isDeleteSnapEnabled) {
//      showActionSheet()
        }
        
        _view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onDrag)))
    }
    
    public let percentThresholdDismiss: CGFloat = 0.3
    @objc func onDrag(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: _view)
    var movementOnAxis: CGFloat?
    let newY = min(max(_view.frame.minY + translation.y, 0), _view.frame.maxY)
    movementOnAxis = newY / _view.bounds.height
    _view.frame.origin.y = newY
        
    let positiveMovementOnAxis = fmaxf(Float(movementOnAxis ?? 0), 0.0)
    let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
    let progress = CGFloat(positiveMovementOnAxisPercent)
    switch sender.state {
    case .ended where sender.velocity(in: _view).y >= (_view.frame.height / 2) || progress > percentThresholdDismiss:
    UIView.animate(withDuration: 0.2, animations: {
    self._view.frame.origin.y = self._view.bounds.height
    }, completion: { finish in
    self.dismiss(animated: true)
    })
    case .ended:
    UIView.animate(withDuration: 0.2, animations: {
    self._view.frame.origin.y = 0
    })
    default:
    break
    }
    sender.setTranslation(.zero, in: _view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if !executeOnce {
            DispatchQueue.main.async {
                self._view.snapsCollectionView.delegate = self
                self._view.snapsCollectionView.dataSource = self
                let indexPath = IndexPath(item: self.handPickedStoryIndex, section: 0)
                self._view.snapsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                self.handPickedStoryIndex = 0
                self.executeOnce = true
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        isTransitioning = true
        _view.snapsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    init(layout:IGLayoutType = .cubic,stories: [IGStory],handPickedStoryIndex: Int, handPickedSnapIndex: Int = 0) {
        self.layoutType = layout
        self.stories = stories
        self.handPickedStoryIndex = handPickedStoryIndex
        self.handPickedSnapIndex = handPickedSnapIndex
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @objc private func showActionSheet() {
        self.present(actionSheetController, animated: true) { [weak self] in
            self?.currentCell?.pauseEntireSnap()
        }
    }
    
    private func deleteSnap() {
        guard let indexPath = currentIndexPath else {
            debugPrint("Current IndexPath is nil")
            return
        }
        let cell = _view.snapsCollectionView.cellForItem(at: indexPath) as? IGStoryPreviewCell
        cell?.deleteSnap()
    }
    //MARK: - Selectors
}

//MARK:- Extension|UICollectionViewDataSource
extension IGStoryPreviewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = viewModel else {return 0}
        return model.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IGStoryPreviewCell.reuseIdentifier, for: indexPath) as? IGStoryPreviewCell else {
            fatalError()
        }

        let story = viewModel?.cellForItemAtIndexPath(indexPath)
        cell.story = story
    
        cell.delegate = self
        cell.PreviewController = self
        currentIndexPath = indexPath
        IGStoryPreviewController.nStoryIndex = indexPath.item
        
        if story?.snapsCount == 0 {
        self.dismiss(animated: true)
        }
    
        return cell
    }
}

//MARK:- Extension|UICollectionViewDelegate
extension IGStoryPreviewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? IGStoryPreviewCell else {
            return
        }
        
        //Taking Previous(Visible) cell to store previous story
        let visibleCells = collectionView.visibleCells.sortedArrayByPosition()
        let visibleCell = visibleCells.first as? IGStoryPreviewCell
        if let vCell = visibleCell {
            vCell.story?.isCompletelyVisible = false
            vCell.pauseSnapProgressors(with: (vCell.story?.lastPlayedSnapIndex)!)
            story_copy = vCell.story
        }
        //Prepare the setup for first time story launch
        if story_copy == nil {
            cell.willDisplayCellForZerothIndex(with: cell.story?.lastPlayedSnapIndex ?? 0, handpickedSnapIndex: handPickedSnapIndex)
            return
        }
        if indexPath.item == IGStoryPreviewController.nStoryIndex {
            let s = stories[IGStoryPreviewController.nStoryIndex+handPickedStoryIndex]
            cell.willDisplayCell(with: s.lastPlayedSnapIndex)
        }
        /// Setting to 0, otherwise for next story snaps, it will consider the same previous story's handPickedSnapIndex. It will create issue in starting the snap progressors.
        handPickedSnapIndex = 0
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleCells = collectionView.visibleCells.sortedArrayByPosition()
        let visibleCell = visibleCells.first as? IGStoryPreviewCell
        guard let vCell = visibleCell else {return}
        guard let vCellIndexPath = _view.snapsCollectionView.indexPath(for: vCell) else {
            return
        }
        vCell.story?.isCompletelyVisible = true
        
        if vCell.story == story_copy {
            IGStoryPreviewController.nStoryIndex = vCellIndexPath.item
            if vCell.longPressGestureState == nil {
                vCell.resumePreviousSnapProgress(with: (vCell.story?.lastPlayedSnapIndex)!)
            }
            if (vCell.story?.snaps[vCell.story?.lastPlayedSnapIndex ?? 0])?.kind == .video {
                vCell.resumePlayer(with: vCell.story?.lastPlayedSnapIndex ?? 0)
            }
            vCell.longPressGestureState = nil
        }else {
            if let cell = cell as? IGStoryPreviewCell {
                cell.stopPlayer()
            }
            vCell.startProgressors()
        }
        if vCellIndexPath.item == IGStoryPreviewController.nStoryIndex {
            vCell.didEndDisplayingCell()
        }
    }
}

//MARK:- Extension|UICollectionViewDelegateFlowLayout
extension IGStoryPreviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isTransitioning {
            let visibleCells = collectionView.visibleCells.sortedArrayByPosition()
            let visibleCell = visibleCells.first as? IGStoryPreviewCell
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
                guard let strongSelf = self,
                    let vCell = visibleCell,
                    let progressIndicatorView = vCell.getProgressIndicatorView(with: vCell.snapIndex),
                    let pv = vCell.getProgressView(with: vCell.snapIndex) else {
                        fatalError("Visible cell or progressIndicatorView or progressView is nil")
                }
                vCell.scrollview.setContentOffset(CGPoint(x: CGFloat(vCell.snapIndex) * collectionView.frame.width, y: 0), animated: false)
                vCell.adjustPreviousSnapProgressorsWidth(with: vCell.snapIndex)
                
                if pv.state == .running {
                    pv.widthConstraint?.constant = progressIndicatorView.frame.width
                }
                strongSelf.isTransitioning = false
            }
        }
        if #available(iOS 11.0, *) {
            return CGSize(width: _view.snapsCollectionView.safeAreaLayoutGuide.layoutFrame.width, height: _view.snapsCollectionView.safeAreaLayoutGuide.layoutFrame.height)
        } else {
            return CGSize(width: _view.snapsCollectionView.frame.width, height: _view.snapsCollectionView.frame.height)
        }
    }
}

//MARK:- Extension|UIScrollViewDelegate<CollectionView>
extension IGStoryPreviewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let vCell = _view.snapsCollectionView.visibleCells.first as? IGStoryPreviewCell else {return}
        vCell.pauseSnapProgressors(with: (vCell.story?.lastPlayedSnapIndex)!)
        vCell.pausePlayer(with: (vCell.story?.lastPlayedSnapIndex)!)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let sortedVCells = _view.snapsCollectionView.visibleCells.sortedArrayByPosition()
        guard let f_Cell = sortedVCells.first as? IGStoryPreviewCell else {return}
        guard let l_Cell = sortedVCells.last as? IGStoryPreviewCell else {return}
        let f_IndexPath = _view.snapsCollectionView.indexPath(for: f_Cell)
        let l_IndexPath = _view.snapsCollectionView.indexPath(for: l_Cell)
        let numberOfItems = collectionView(_view.snapsCollectionView, numberOfItemsInSection: 0)-1
        if l_IndexPath?.item == 0 {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
        self.currentCell?.resumeEntireSnap()
        }
        }else if f_IndexPath?.item == numberOfItems {
        self.dismiss(animated: true)
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK:- StoryPreview Protocol implementation
extension IGStoryPreviewController: StoryPreviewProtocol {
    func didCompletePreview() {
        let n = handPickedStoryIndex+IGStoryPreviewController.nStoryIndex+1
        if n < stories.count {
            //Move to next story
            story_copy = stories[IGStoryPreviewController.nStoryIndex+handPickedStoryIndex]
            IGStoryPreviewController.nStoryIndex = IGStoryPreviewController.nStoryIndex + 1
            let nIndexPath = IndexPath.init(row: IGStoryPreviewController.nStoryIndex, section: 0)
            //_view.snapsCollectionView.layer.speed = 0;
            _view.snapsCollectionView.scrollToItem(at: nIndexPath, at: .right, animated: true)
            /**@Note:
             Here we are navigating to next snap explictly, So we need to handle the isCompletelyVisible. With help of this Bool variable we are requesting snap. Otherwise cell wont get Image as well as the Progress move :P
             */
        }else {
            self.dismiss(animated: true)
        }
    }
    
    func moveToPreviousStory() {
        //let n = handPickedStoryIndex+nStoryIndex+1
        let n = IGStoryPreviewController.nStoryIndex+1
        if n <= stories.count && n > 1 {
            story_copy = stories[IGStoryPreviewController.nStoryIndex+handPickedStoryIndex]
            IGStoryPreviewController.nStoryIndex = IGStoryPreviewController.nStoryIndex - 1
            let nIndexPath = IndexPath.init(row: IGStoryPreviewController.nStoryIndex, section: 0)
            _view.snapsCollectionView.scrollToItem(at: nIndexPath, at: .left, animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    func didTapCloseButton() {
        self.dismiss(animated: true)
    }
}
