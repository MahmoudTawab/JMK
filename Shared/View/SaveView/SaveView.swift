//
//  SaveView.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 05/09/2021.
//

import UIKit

class SaveView: ViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    

    var ItemId : Int?
    var SavedFolderOn = [Saved]()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetSaved()
        SetUpSaved(ShowAddOrFolder: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = view.bounds
        ViewScroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        ViewScroll.addSubview(DismissView)
        DismissView.frame = view.bounds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.7) {
            self.DismissView.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0.25)
        }
        }
        
        ViewScroll.addSubview(View)
        View.frame = CGRect(x: 0, y: view.frame.maxY - endCardHeight, width: view.frame.width, height: endCardHeight)
        
        View.roundCorners(corners: [.topLeft, .topRight], radius: ControlHeight(radius))
        
        // MARK: - Start Save View
        
        View.addSubview(AddFolderToSave)
        AddFolderToSave.frame = CGRect(x: view.frame.width - ControlX(45), y: ControlX(7), width:ControlWidth(40), height: ControlWidth(40))
            
        View.addSubview(SaveToLabel)
        SaveToLabel.frame = CGRect(x: ControlX(50), y: ControlY(15), width: view.frame.width - ControlWidth(100), height: ControlWidth(30))
                
        View.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: SaveToLabel.frame.maxY + ControlX(15), width: view.frame.width - ControlWidth(30), height: ControlWidth(100))
                
        View.addSubview(DismissAdd)
        DismissAdd.frame = CGRect(x: ControlX(15), y: ControlX(10), width: ControlWidth(50), height: ControlWidth(35))
                    
        View.addSubview(AddFolderLabel)
        AddFolderLabel.frame = CGRect(x: view.center.x - ControlX(75), y: ControlX(10), width: ControlWidth(150), height: ControlWidth(40))
                    
        View.addSubview(AddFolderTF)
        AddFolderTF.frame = CGRect(x: view.center.x - ControlX(75), y: AddFolderLabel.frame.maxY + ControlX(5), width: ControlWidth(150), height: ControlWidth(30))
                
        View.addSubview(AddFolder)
        AddFolder.frame = CGRect(x: ControlX(15), y: AddFolderTF.frame.maxY + ControlX(20), width: view.frame.width - ControlWidth(40), height: ControlWidth(50))
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSaved), for: .touchUpInside)
    }
    
    lazy var View: UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = ControlHeight(10)
        View.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:))))
        return View
    }()
    
    lazy var DismissView : UIView = {
        let View = UIView()
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()

    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.bounces = false
        return Scroll
    }()

    var radius:CGFloat = 0
    var startCardHeight:CGFloat = 0
    var endCardHeight:CGFloat = ControlWidth(180)
    var runningAnimations = [UIViewPropertyAnimator]()
    
    var currentState: State = .closed
    private var animationProgress = [CGFloat]()
    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
    switch recognizer.state {
    case .began:
    animateTransitionIfNeeded(state: currentState.opposite, duration:  0.9)
    runningAnimations.forEach { $0.pauseAnimation() }
    animationProgress = runningAnimations.map { $0.fractionComplete }
    case .changed:
    let translation = recognizer.translation(in: View)
    var fraction = -translation.y / endCardHeight
    if currentState == .open { fraction *= -1 }
    if runningAnimations[0].isReversed { fraction *= -1 }

    for (index, animator) in runningAnimations.enumerated() {
    animator.fractionComplete = fraction + animationProgress[index]
    }
    case .ended:
    let translation = recognizer.translation(in: View)
    let Y =  endCardHeight - translation.y

    if Y > (self.endCardHeight / 2) {
    runningAnimations.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
    runningAnimations.forEach { $0.isReversed = !$0.isReversed }
    }else{
    runningAnimations.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
    runningAnimations.forEach { $0.isReversed = $0.isReversed }
    }
    
    default:
    break
    }
    }
    
    func animateTransitionIfNeeded (state:State, duration:TimeInterval) {
    guard runningAnimations.isEmpty else { return }
        
    let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.9) {
    switch state {
    case .open:
    self.View.frame.origin.y = self.view.frame.height - self.endCardHeight
    
    case .closed:
    self.View.frame.origin.y = self.view.frame.height - self.startCardHeight
    }
    }
        
    frameAnimator.addCompletion { position in
    switch position {
    case .start:
    self.currentState = state.opposite
    case .end:
    self.currentState = state
    case .current:
    ()
    default:
    break
    }
        
    switch self.currentState {
    case .open:
    self.View.frame.origin.y = self.view.frame.height - self.endCardHeight
    case .closed:
    self.View.frame.origin.y = self.view.frame.height - self.startCardHeight
    self.dismiss(animated: false)
    }

    self.runningAnimations.removeAll()
    }
    
    frameAnimator.startAnimation()
    runningAnimations.append(frameAnimator)
    let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
    switch state {
    case .open:
    self.View.layer.cornerRadius = ControlHeight(25)
    self.DismissView.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0.25)
    case .closed:
    self.View.layer.cornerRadius = ControlHeight(5)
    self.DismissView.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0)
    }
    }
    cornerRadiusAnimator.startAnimation()
    runningAnimations.append(cornerRadiusAnimator)
    }
    
    @objc func Dismiss() {
    UIView.animate(withDuration: 0.4) {
    self.DismissView.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0)
    self.View.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: self.endCardHeight)
    } completion: { (_) in
    self.SetUpSaved(ShowAddOrFolder: true)
    self.dismiss(animated: false)
    }
    }
    
    
    func SetUpSaved(ShowAddOrFolder:Bool) {
        if ShowAddOrFolder {
        DismissAdd.alpha = 0
        AddFolderLabel.alpha = 0
        AddFolderTF.alpha = 0
        AddFolder.alpha = 0
            
        AddFolderToSave.alpha = 1
        SaveToLabel.alpha = 1
        CollectionView.alpha = 1
        UIView.transition(from: View, to: View, duration: 0.4, options:[.transitionCrossDissolve,.showHideTransitionViews])
        }else{
        DismissAdd.alpha = 1
        AddFolderLabel.alpha = 1
        AddFolderTF.alpha = 1
        AddFolder.alpha = 1
            
        AddFolderToSave.alpha = 0
        SaveToLabel.alpha = 0
        CollectionView.alpha = 0
        UIView.transition(from: View, to: View, duration: 0.4, options:[.transitionCrossDissolve,.showHideTransitionViews])
        }
        
    }
    
    lazy var SaveToLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Save to"
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var AddFolderToSave : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("+", for: .normal)
        Button.backgroundColor = .clear
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(30), weight: .medium)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(5), left: ControlX(5), bottom: ControlY(5), right:  ControlX(5))
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddFolderToSave), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionAddFolderToSave() {
//    if defaults.string(forKey: "JWT") == nil {
//    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
//    }else{
    SetUpSaved(ShowAddOrFolder: false)
//    }
    }
    
    lazy var DismissAdd : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismissAdd)))
        return dismiss
    }()
    
    @objc func ActionDismissAdd() {
    SetUpSaved(ShowAddOrFolder: true)
    }
    
    lazy var AddFolderLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.text = "Add New Folder"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255,green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var AddFolderTF : FloatingTF = {
        let tf = FloatingTF()
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = true
        tf.attributedPlaceholder = NSAttributedString(string: "Tables", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(ScrollTopAddEditFolder), for: .editingDidBegin)
        return tf
    }()
    
    @objc func ScrollTopAddEditFolder() {
    DispatchQueue.main.async {
    self.ViewScroll.setContentOffset(CGPoint(x: 0, y: 75), animated: true)
    }
    }
    
    lazy var AddFolder : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.setTitle("Add Folder", for: .normal)
        Button.addTarget(self, action: #selector(ActionAddFolder), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionAddFolder() {
    guard let text = AddFolderTF.text else {return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + AddNewFolder)"
//            
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "Platform": "I",
//                                    "SqlId": SqlId,
//                                    "FolderName": text]

    self.ProgressHud.beginRefreshing()
            
//    PostAPI(api: api, token: token, parameters: parameters) { String in
//    } DictionaryData: { data in

        
        let data = ["Id" : 1,"Name" : "\(text)","Detalis" : []] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            self.AddFolderTF.text = ""
            self.SetUpSaved(ShowAddOrFolder: true)
            self.SavedFolderOn.append(Saved(dictionary: data))
            self.SavedFolderOn.last?.Name = text
            self.CollectionView.reloadData()
            
            self.ProgressHud.endRefreshing("Success Add New Folder", .success) {}
        }
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionAddFolder)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }
    
    private let CellFolder = "FolderSaveId"
    lazy var CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(19)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(CellFolderSave.self, forCellWithReuseIdentifier: CellFolder)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SavedFolderOn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellFolder, for: indexPath) as! CellFolderSave
        cell.LabelTitle.text = SavedFolderOn[indexPath.item].Name
        
        if SavedFolderOn.count > indexPath.item {
        cell.ImageView.setImage(urlString: "", placeHolderImage: UIImage(named: "group26396")) { _ in}
        }else{
        cell.ImageView.backgroundColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 0.5)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ControlWidth(71.5), height: ControlWidth(100.0))
    }
    
    static let SuccessSaved = NSNotification.Name(rawValue: "SuccessSaved")
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + AddItemSavedFolder)"
//
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let FolderId = SavedFolderOn[indexPath.item].Id else{return}
//    guard let ItemId = ItemId else{return}
//        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "Platform": "I",
//                                    "SqlId": SqlId,
//                                    "FolderId": "\(FolderId)",
//                                    "ItemId": "\(ItemId)"]
        
    self.ProgressHud.beginRefreshing()
        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
      NotificationCenter.default.post(name: SaveView.SuccessSaved, object: nil)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ProgressHud.endRefreshing("Success Saved To Folder", .success) {}
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    error != "" ? self.ProgressHud.endRefreshing(error, .error) {}:self.ProgressHud.endRefreshing() {}
//    }
    }

    
    @objc func GetSaved() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + GetSavedFolder)"
//
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                      "SqlId": SqlId]
//
//    self.ProgressHud.beginRefreshing()
//        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
            
        ["Id" : 1,"Name" : "Folder 1","Detalis" :
        [["Id" : 1,"ProdectId" : 1,"Path" : "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_640.jpg","type" : "Test type"],
        ["Id" : 2,"ProdectId" : 2,"Path" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlohRRu0HkkNOxJId941Dm4ijDlXhRvGjVbcxTNShVeuSfoEBaOl83D3QoW-bkUSGLHsU&usqp=CAU","type" : "Test type"],
        ["Id" : 3,"ProdectId" : 3,"Path" : "https://st.depositphotos.com/20293186/58514/i/450/depositphotos_585149742-stock-photo-chamomile-black-background-close-summer.jpg","type" : "Test type"]]],
        
        
        ["Id" : 2,"Name" : "Folder 2","Detalis" :
        [["Id" : 1,"ProdectId" : 1,"Path" : "https://images.pexels.com/photos/46216/sunflower-flowers-bright-yellow-46216.jpeg","type" : "Test type"],
        ["Id" : 2,"ProdectId" : 2,"Path" : "https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2016/08/girasoles-2.jpg?fit=1024%2C768&quality=50&strip=all&ssl=1","type" : "Test type"],
        ["Id" : 3,"ProdectId" : 3,"Path" : "https://img.freepik.com/foto-gratis/girasoles-generados-ai_23-2150681808.jpg","type" : "Test type"]]],
        
        
        ["Id" : 2,"Name" : "Folder 3","Detalis" :
        [["Id" : 1,"ProdectId" : 1,"Path" : "https://huggingface.co/datasets/huggingfacejs/tasks/resolve/main/image-classification/image-classification-input.jpeg","type" : "Test type"],
        ["Id" : 2,"ProdectId" : 2,"Path" : "https://images.unsplash.com/photo-1580784355694-0d5295dcc007?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE3fHx8ZW58MHx8fHx8&w=1000&q=80","type" : "Test type"],
        ["Id" : 3,"ProdectId" : 3,"Path" : "https://st4.depositphotos.com/26985830/31451/i/450/depositphotos_314511594-stock-photo-surprised-tabby-kitten-village-orange.jpg","type" : "Test type"]]],
        
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            self.SavedFolderOn.removeAll()
            
            for item in data {
                self.SavedFolderOn.append(Saved(dictionary: item))
                self.CollectionView.AnimateCollection()
            }
            
            self.ProgressHud.endRefreshing() {}
            
        }
//    } Err: { error in
//        
//    if error != "" && error != "No Content" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetSaved)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }
}
