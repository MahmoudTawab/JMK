//
//  HasSubMultipleDetails.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/08/2021.
//

import UIKit
import SDWebImage

class HasSubMultipleDetails: ViewController {
            
    var ItemId : Int?
    var Title = String()
    var SavedDetalis:ViewImageSaved?
    var HasSubMultiple : HasSubMultipleVC?
    var ItemsDetails : MenuPackagesItemsDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        SetUp()
        GetDetailsItem()
        
        self.ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetDetailsItem), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(IsFavorite), name: SaveView.SuccessSaved , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowCartCount), name: HasSubMultipleVC.NotificationCartCount , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowCartCountNil), name: HasSubMultipleVC.NotificationCartCountNil , object: nil)
    }
    
    func SetUp() {
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
        
        view.addSubview(ShoppingButton)
        ShoppingButton.frame = CGRect(x: view.frame.maxX - ControlX(55), y: ControlY(35), width: ControlWidth(38), height: ControlWidth(38))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
                
        ViewScroll.addSubview(ViewBar)
        ViewBar.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlWidth(30), height: ControlWidth(50))
        
        ViewScroll.addSubview(RectangleView)
        RectangleView.frame = CGRect(x: ControlX(15), y: ViewBar.frame.maxY +  ControlX(15), width: view.frame.width - ControlWidth(30), height: ControlWidth(340))
        
        ViewScroll.addSubview(CollectionViewImage)
        CollectionViewImage.frame = CGRect(x: ControlX(15), y: ViewBar.frame.maxY +  ControlX(15), width: ViewScroll.frame.width - ControlWidth(30), height: ControlWidth(300))
        
        ViewScroll.addSubview(pageControl)
        pageControl.frame = CGRect(x: ControlX(15), y: CollectionViewImage.frame.maxY + ControlX(5), width: view.frame.width - ControlWidth(30), height: ControlWidth(10))

        ViewScroll.addSubview(heart)
        heart.frame = CGRect(x: ViewScroll.frame.maxX - ControlX(40), y:CollectionViewImage.frame.minY + ControlX(5), width: ControlWidth(25), height: ControlWidth(25))
        
        ViewScroll.addSubview(LabelTitle)
        LabelTitle.frame = CGRect(x: ControlX(15), y: RectangleView.frame.maxY + ControlX(20), width: ViewScroll.frame.width - ControlWidth(30) , height: ControlWidth(30))
        
        ViewScroll.addSubview(ClassLabel)
        ClassLabel.frame = CGRect(x: ControlX(15), y: LabelTitle.frame.maxY + ControlX(20), width: ControlWidth(80), height: ControlWidth(30))
        
        
        ViewScroll.addSubview(LabelDetails)
        ViewScroll.addSubview(ViewCount)
        ViewCount.addSubview(MinusButton)
        ViewCount.addSubview(CountTF)
        ViewCount.addSubview(PlusButton)
        ViewScroll.addSubview(AddToCart)
        
    }
    
    func UpdateContent() {
    guard let DetailHeight = LabelDetails.text?.heightWithConstrainedWidth(LabelTitle.frame.width, font: UIFont.boldSystemFont(ofSize:ControlWidth(16)), Spacing: ControlHeight(5)) else{return}
        
    LabelDetails.frame = CGRect(x: ControlX(15), y: ClassLabel.frame.maxY + ControlX(10), width: LabelTitle.frame.width, height: DetailHeight)
        
    ViewCount.frame = CGRect(x: ControlX(15), y: LabelDetails.frame.maxY + ControlX(30), width: ControlWidth(200), height: ControlWidth(30))
        
    MinusButton.frame = CGRect(x: 0, y: 0, width: ControlWidth(30), height: ControlWidth(30))
    MinusButton.contentEdgeInsets.bottom = ControlY(2)
       
    CountTF.frame = CGRect(x: MinusButton.frame.maxX + ControlX(8), y: 0, width: ControlWidth(120), height: ControlWidth(30))
        
    PlusButton.frame = CGRect(x: CountTF.frame.maxX + ControlX(8), y: 0, width: ControlWidth(30), height: ControlWidth(30))
    PlusButton.contentEdgeInsets.bottom = ControlY(2)
        
    AddToCart.frame = CGRect(x: LabelTitle.frame.minX, y: LabelDetails.frame.maxY + ControlX(20), width: LabelTitle.frame.width, height: ControlWidth(50))
        
    // MARK: - ViewScroll contentSize height
    self.ViewScroll.updateContentViewSize(ControlWidth(30))
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "\(Title)"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var ViewBar : TopViewBar = {
        let View = TopViewBar()
        View.Show()
        View.backgroundColor = #colorLiteral(red: 0.9316878319, green: 0.9145766497, blue: 0.9075786471, alpha: 1)
        View.StackTotal.isHidden = true
        View.LabelBudget.text = "Budget "
        View.Budget.text = "300.000"
        View.BudgetNum = LaunchScreen.Cart?.BudgetTo ?? 0
        return View
    }()
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .white
        Scroll.bounces = true
        return Scroll
    }()
    
    lazy var heart : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        image.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        image.layer.shadowOpacity = 0.6
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 6
        image.backgroundColor = .clear
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(heartAction)))
        return image
    }()
    
    let ViewSave = SaveView()
    @objc func heartAction() {
    if heart.image == UIImage(named: "heart") {
    ViewSave.currentState = .open
    ViewSave.ItemId = ItemsDetails?.Details?.Id
    ViewSave.modalPresentationStyle = .overFullScreen
    ViewSave.modalTransitionStyle = .coverVertical
    present(ViewSave, animated: true)
    }else{
    ShowMessageAlert("𝗶", "Delete Favorite", "Do you really want to delete this item from your favourites", false, self.ActionDeleteFavorite, "Delete")
    }
    }
    
   @objc func ActionDeleteFavorite() {
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + DeleteSavedItemFromFolder)"
        
    guard let token = defaults.string(forKey: "JWT") else{return}
    guard let Id = ItemsDetails?.Details?.Id else{return}
    guard let SqlId = LaunchScreen.User?.SqlId else{return}
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                    "SqlId": SqlId,
                                    "Platform": "I",
                                    "ItemId": "\(Id)"]

    self.ProgressHud.beginRefreshing()

    self.SavedDetalis?.Delete(Id)
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ProgressHud.endRefreshing("Success Delete To Favorite",.success) {
    self.heart.image = UIImage(named: "heart")
    self.HasSubMultiple?.Favorite = false
    self.HasSubMultiple?.IsFavorite()
    }
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionDeleteFavorite)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }
    }
    }
    
    @objc func IsFavorite() {
    self.heart.image = UIImage(named: "heartSelect")
    self.HasSubMultiple?.Favorite = true
    self.HasSubMultiple?.IsFavorite()
    }
    
    var ImageID = "ImageID"
    var CollectionImage = [UIImage]()
    lazy var CollectionViewImage : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.isPagingEnabled = true
        vc.showsHorizontalScrollIndicator = false
        vc.register(CellCollectionPackage.self, forCellWithReuseIdentifier: ImageID)
        return vc
    }()

    lazy var pageControl:CHIPageControlPuya = {
        let pc = CHIPageControlPuya(frame: CGRect(x: 0, y:0, width: 100, height: 10))
        pc.delegate = self
        pc.tintColor = .black
        pc.enableTouchEvents = true
        pc.backgroundColor = .white
        pc.radius = ControlWidth(5)
        pc.padding = ControlWidth(10)
        pc.currentPageTintColor = #colorLiteral(red: 0.8610321879, green: 0.7267792821, blue: 0.6523330212, alpha: 1)
        pc.transform = CGAffineTransform(scaleX: ControlWidth(1), y: ControlWidth(1))
        return pc
    }()
    
    lazy var RectangleView : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.8601452708, green: 0.8602899909, blue: 0.8601261973, alpha: 1)
        View.layer.shadowOpacity = 0.4
        View.layer.shadowOffset =  CGSize(width: -1, height: 1)
        View.layer.shadowRadius = 4
        View.backgroundColor = .white
        return View
    }()

    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.text = Title
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(16))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.spasing = ControlHeight(5)
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ClassLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(14))
        Label.backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 1.0)
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    
    lazy var ViewCount:UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var MinusButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("-", for: .normal)
        Button.backgroundColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(28), weight: .medium)
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionMinus), for: .touchUpInside)
        return Button
    }()
    
    var SelectIndexCart = [IndexPath]()
    @objc func ActionMinus() {
    if let text = CountTF.text {
    var temp =  (text as NSString).integerValue
    temp -= 1
    CountTF.text = "\(temp)"
    if let Id = ItemsDetails?.Details?.Id , let index = HasSubMultiple?.indexSelect {
    HasSubMultiple?.CallApiAddToCart(index, Id, temp, 2)
    }
    }
    }
    
    lazy var CountTF : FloatingTF = {
        let tf = FloatingTF()
        tf.textAlignment = .center
        tf.clearButtonMode = .never
        tf.keyboardType = .numberPad
        tf.font = UIFont(name: "Raleway-Regular", size: ControlWidth(22))
        tf.addTarget(self, action: #selector(TextDef), for: .editingDidEnd)
        tf.translatesAutoresizingMaskIntoConstraints = true
        return tf
    }()
    
    @objc func TextDef() {
    if let text = CountTF.text {
    let temp =  (text as NSString).integerValue
    if temp == 0 || CountTF.text == "" {
    if let Id = ItemsDetails?.Details?.Id , let index = HasSubMultiple?.indexSelect {
    HasSubMultiple?.CallApiAddToCart(index, Id, 1, 0)
    }
    }else{
    if let Id = ItemsDetails?.Details?.Id , let index = HasSubMultiple?.indexSelect {
    HasSubMultiple?.CallApiAddToCart(index, Id, temp, 0)
    }
    }
    }
    }
    
    lazy var PlusButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("+", for: .normal)
        Button.backgroundColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(24), weight: .medium)
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionPlus), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionPlus() {
    if let text = CountTF.text {
    var temp =  (text as NSString).integerValue
    temp += 1
    CountTF.text = "\(temp)"
    if let Id = ItemsDetails?.Details?.Id , let index = HasSubMultiple?.indexSelect {
    HasSubMultiple?.CallApiAddToCart(index, Id, temp, 2)
    }
    }
    }
    
    lazy var AddToCart : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Add to Cart", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddToCart), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionAddToCart() {
    if let Id = ItemsDetails?.Details?.Id, let index = HasSubMultiple?.indexSelect {
    HasSubMultiple?.CallApiAddToCart(index, Id, 1, 0)
    }
    }
    
    @objc func ShowCartCount() {
    self.BottomView.animShow()
    self.BottomView.Items = LaunchScreen.Cart?.CartItemCount ?? 0
    CountTF.text = "\(self.ItemsDetails?.Details?.Count ?? 0)"
    }
    
    @objc func ShowCartCountNil() {
    self.BottomView.animHide()
    self.AddToCart.isHidden = false
    }
    
    @objc func GetDetailsItem() {
//    guard let Id = ItemId else{return}
//    let CartId = LaunchScreen.Cart?.CartId ?? 0
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetItemDetils)"
//        
//    let SqlId = LaunchScreen.User?.SqlId as Any
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "Platform": "I",
//                                    "SqlId": SqlId,
//                                    "CartId": "\(CartId)",
//                                    "ItemId": "\(Id)",
//                                    "Token": "8_Py5oXPKhS6fUmbMz_1AQPuSX9jJLDBq-Zb2Zqv3DY"]

    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: nil, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        
        let data = ["Details":["Id" : 1,"Name" : "Packages 2","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 90.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU","InCart" : true,"Count" : 6,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "S",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ]
        ]
        
    self.ItemsDetails = MenuPackagesItemsDetails(dictionary: data)
     
    self.CollectionImage.removeAll()
    if let Details = self.ItemsDetails?.Details {
        
    self.BottomView.Items = LaunchScreen.Cart?.CartItemCount ?? 0
    self.CountTF.text = "\(Details.Count ?? 0)"
    self.AddToCart.isHidden = Details.InCart ?? true
    self.ViewCount.isHidden = !(Details.InCart ?? true)
        
    self.LabelTitle.text = Details.Name ?? ""
    self.LabelDetails.text = Details.Description ?? ""
    self.ClassLabel.text = Details.ClassName ?? ""
    self.UpdateContent()
    
    if Details.Gallery.count == 0 {
    self.CollectionImage.append(UIImage(named: "group26396") ?? UIImage())
    self.pageControl.numberOfPages = self.CollectionImage.count
    self.CollectionViewImage.AnimateCollection()
    }else{
                        
    for Photo in Details.Gallery {
    if let images = Photo.PhotoPath {
    SDWebImageManager.shared.loadImage(with: URL(string: images),
    options: .highPriority ,progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
    if let img = image {
    self.CollectionImage.append(img)
    
    self.CollectionViewImage.AnimateCollection()
    self.pageControl.numberOfPages = self.CollectionImage.count
    }}}}}
    }
        
    self.ViewScroll.isHidden = false
    self.ViewNoData.isHidden = true
    self.ProgressHud.endRefreshing() {}
//    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: self.ItemsDetails?.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
    self.heart.image = self.ItemsDetails?.Details?.Favorite ?? false ? UIImage(named: "heartSelect"):UIImage(named: "heart")
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if  error != "" {
//    self.ViewScroll.isHidden = true
//    self.ViewNoData.isHidden = false
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }
//    }
    }
    
}

///... Set Up Collection
extension HasSubMultipleDetails: UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout ,CHIBasePageControlDelegate ,MediaBrowserDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageID, for: indexPath) as! CellCollectionPackage
        cell.ItemsImage.image = CollectionImage[indexPath.item]
        return cell
    }
    
    func didTouch(pager: CHIBasePageControl, index: Int) {
    pageControl.set(progress: index, animated: true)
    CollectionViewImage.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let browser = MediaBrowser(delegate: self)
    browser.enableGrid = false
    browser.title = "Package Details"
    browser.setCurrentIndex(at: indexPath.item)
    browser.displayMediaNavigationArrows = true
    let nc = UINavigationController(rootViewController: browser)
    nc.modalPresentationStyle = .fullScreen
    nc.modalTransitionStyle = .coverVertical
    present(nc, animated: true)
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
    CollectionImage.count
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(CollectionViewImage.frame.width)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(CollectionViewImage.contentSize.width)
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
     
        self.pageControl.set(progress: Int(newPage), animated: true)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: CollectionImage[index] ,caption: "Green Wedding Table")
    return photo
    }
    
}

