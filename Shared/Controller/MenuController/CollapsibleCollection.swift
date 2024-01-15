//
//  CollapsibleCollection.swift
//  CollapsibleCollection
//
//  Created by Yong Su on 7/20/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit

//
// MARK: - CollapsibleCollectionDelegate
//
@objc public protocol CollapsibleCollectionSectionDelegate {
    @objc optional func numberOfSections(_ collectionView: UICollectionView) -> Int
    @objc optional func collapsibleCollectionView(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell
    @objc optional func collapsibleCollectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int
    @objc optional func collapsibleCollectionView(_ collectionView: UICollectionView, titleForHeaderInSection section: Int) -> String?
    @objc optional func collapsibleCollectionView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath)
    @objc optional func shouldCollapseByDefault(_ collectionView: UICollectionView) -> Bool
    @objc optional func shouldCollapseOthers(_ collectionView: UICollectionView) -> Bool
}

//
// MARK: - View Controller
//
class CollapsibleCollection: ViewController, CollapsibleCollectionFooterDelegate {
             
    public var delegate: CollapsibleCollectionSectionDelegate?
    
    let CellMenu = "Menu"
    let CellCustomizeEvent = "Event"
    var CollectionView: UICollectionView!
    fileprivate var _sectionsState = [Int : Bool]()
    
    public func isSectionCollapsed(_ section: Int) -> Bool {
        if _sectionsState.index(forKey: section) == nil {
            _sectionsState[section] = delegate?.shouldCollapseByDefault?(CollectionView) ?? false
        }
        return _sectionsState[section]!
    }
    
    func getSectionsNeedReload(_ section: Int) -> [Int] {
        var sectionsNeedReload = [section]
        
        // Toggle collapse
        let isCollapsed = !isSectionCollapsed(section)
        
        // Update the sections state
        _sectionsState[section] = isCollapsed
        
        let shouldCollapseOthers = delegate?.shouldCollapseOthers?(CollectionView) ?? false
        
        if !isCollapsed && shouldCollapseOthers {
            // Find out which sections need to be collapsed
            let filteredSections = _sectionsState.filter { !$0.value && $0.key != section }
            let sectionsNeedCollapse = filteredSections.map { $0.key }
            
            // Mark those sections as collapsed in the state
            for item in sectionsNeedCollapse { _sectionsState[item] = true }
            
            // Update the sections that need to be redrawn
            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }
        
        return sectionsNeedReload
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        // Create the CollectionView
        CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.backgroundColor = .clear
        CollectionView.showsVerticalScrollIndicator = false
        CollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(10), right: 0)
        CollectionView.register(MenuCell.self, forCellWithReuseIdentifier: CellMenu)
        CollectionView.register(CustomizeEventCell.self, forCellWithReuseIdentifier: CellCustomizeEvent)
        
        CollectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ViewHeader")
        
        CollectionView.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ViewFooter")
                
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds
        
    }


    lazy var BackgroundImage:UIImageView = {
            let ImageView = UIImageView()
            ImageView.contentMode = .scaleToFill
            ImageView.layer.masksToBounds = true
            ImageView.alpha = 0.4
            ImageView.backgroundColor = .white
            ImageView.image = UIImage(named: "group31203")
    return ImageView
    }()
        
}

//
// MARK: - View Controller DataSource and Delegate
//
extension CollapsibleCollection: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
        
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return delegate?.numberOfSections?(collectionView) ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfRows = delegate?.collapsibleCollectionView?(collectionView, numberOfRowsInSection: section) ?? 0
        return isSectionCollapsed(section) ? 0 : numberOfRows
    }
    
    // Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return delegate?.collapsibleCollectionView?(collectionView, cellForRowAt: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collapsibleCollectionView?(collectionView, didSelectRowAt: indexPath)
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ViewHeader", for: indexPath) as! HeaderCell
    let title = delegate?.collapsibleCollectionView?(collectionView, titleForHeaderInSection: indexPath.section) ?? ""
    header.titleLabel.text = title
    header.setCollapsed(isSectionCollapsed(indexPath.section))
    header.section = indexPath.section
    header.delegate = self
    return header
    
    case UICollectionView.elementKindSectionFooter:
    let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ViewFooter", for: indexPath) as! FooterCell
    Footer.delegate = self
    return Footer
    default:
    fatalError("Unexpected element kind")
    }
    }
    
    func toggleSection() {
    Present(ViewController: self, ToViewController: SignUpAsSupplier())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: ControlWidth(60))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    guard let SectionNumber = delegate?.numberOfSections?(collectionView) else {return .zero}
    if section == SectionNumber - 1 {
    return CGSize(width: collectionView.frame.width, height: ControlWidth(100))
    }else{
    return .zero
    }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: ControlWidth(60))
    }

}

//
// MARK: - Section Header Delegate
//
extension CollapsibleCollection: CollapsibleCollectionHeaderDelegate {
    func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        self.CollectionView.reloadSections(IndexSet(sectionsNeedReload))
        
        let lastItem = self.CollectionView.numberOfItems(inSection: section) - 1
        guard lastItem >= 0 else { return }
        let lastItemIndexPath = IndexPath(item: lastItem, section: section)
        self.CollectionView.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}

extension UICollectionView {
  var totalItems: Int {
    (0..<numberOfSections).reduce(0) { res, cur in
      res + numberOfItems(inSection: cur)
    }
  }
}
