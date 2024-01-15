//
//  HasSubSingleDetails.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 16/08/2021.
//

import UIKit
import SDWebImage

class HasSubSingleDetails: ViewController , MediaBrowserDelegate {
        
    
    var ItemId : Int?
    var CollectionImage = [UIImage]()
    var SavedDetalis:ViewImageSaved?
    var HasSubSingle : HasSubSingleVC?
    var ItemsDetails : MenuPackagesItemsDetails?
    var indexSelect = IndexPath(row: 0, section: 0)
    private let OutdoorDetailsID = "CellOutdoorDetails"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        SetUp()
        GetDetailsItem()
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetDetailsItem), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(IsFavorite), name: SaveView.SuccessSaved , object: nil)
    }

    func SetUp() {
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
        
        view.addSubview(ShoppingButton)
        ShoppingButton.frame = CGRect(x: view.frame.maxX - ControlX(55), y: ControlY(35), width: ControlWidth(38), height: ControlWidth(38))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
        
        ViewScroll.addSubview(ViewBar)
        ViewBar.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlWidth(30), height: ControlWidth(50))
        
        ViewScroll.addSubview(LorgeImage)
        LorgeImage.frame = CGRect(x: ControlX(15), y: ViewBar.frame.maxY +  ControlX(15), width: view.frame.width - ControlWidth(30), height: ControlWidth(250))
        
        ViewScroll.addSubview(heart)
        heart.frame = CGRect(x: LorgeImage.frame.maxX - ControlX(30), y: LorgeImage.frame.minY + ControlY(5), width: ControlWidth(25), height: ControlWidth(25))
        
        ViewScroll.addSubview(CollectionViewImage)
        CollectionViewImage.frame = CGRect(x: ControlX(15), y: LorgeImage.frame.maxY + ControlX(8), width: view.frame.width - ControlWidth(30), height: ControlWidth(100))
        
        ViewScroll.addSubview(ClassLabel)
        ClassLabel.frame = CGRect(x: ControlX(15), y: CollectionViewImage.frame.maxY + ControlX(15), width:  ControlWidth(80), height: ControlWidth(30))
        
        ViewScroll.addSubview(DetailsLabel)
        
        ViewScroll.addSubview(AddCartAndRemove)
    }

    func UpdateContent() {
    guard let DetailHeight = DetailsLabel.text?.heightWithConstrainedWidth(view.frame.width - ControlWidth(30), font: UIFont.boldSystemFont(ofSize:ControlWidth(16)), Spacing: ControlHeight(5)) else{return}

    DetailsLabel.frame = CGRect(x: ControlX(15), y: ClassLabel.frame.maxY + ControlX(15), width: view.frame.width - ControlWidth(30), height: DetailHeight)
        

    AddCartAndRemove.frame = CGRect(x: ControlX(15), y: DetailsLabel.frame.maxY + ControlX(20), width: view.frame.width - ControlWidth(30), height: ControlWidth(50))
        
    // MARK: - ViewScroll contentSize height
    self.ViewScroll.updateContentViewSize(ControlWidth(30))
    }
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
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
        View.Budget.text = "100.000"
        View.BudgetNum = LaunchScreen.Cart?.BudgetTo ?? 0
        return View
    }()
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        return Scroll
    }()
    
    lazy var LorgeImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DidSelect)))
        return ImageView
    }()
    
    @objc func DidSelect() {
    let browser = MediaBrowser(delegate: self)
    browser.setCurrentIndex(at: indexSelect.row)
    browser.displayMediaNavigationArrows = true
    browser.enableGrid = false
    let nc = UINavigationController(rootViewController: browser)
    nc.modalPresentationStyle = .fullScreen
    nc.modalTransitionStyle = .coverVertical
    present(nc, animated: true)
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        CollectionImage.count
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: CollectionImage[index] ,caption: Dismiss.TextDismiss)
    return photo
    }
    
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
    self.ProgressHud.endRefreshing("Success Delete To Favorite", .success) {
    self.heart.image = UIImage(named: "heart")
    self.HasSubSingle?.Favorite = false
    self.HasSubSingle?.IsFavorite()
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
    self.HasSubSingle?.Favorite = true
    self.HasSubSingle?.IsFavorite()
    }
    
    lazy var CollectionViewImage: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(8)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.showsHorizontalScrollIndicator = false
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.register(HasSubSingleDetailsCell.self, forCellWithReuseIdentifier: OutdoorDetailsID)
        return vc
    }()

    lazy var ClassLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(11))
        Label.backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 1.0)
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    lazy var DetailsLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.numberOfLines = 0
        Label.spasing = ControlHeight(5)
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var AddCartAndRemove : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Add to Cart", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddToCart), for: .touchUpInside)
        return Button
    }()
    

    var ObjectCart = [AddToCart]()
    @objc func ActionAddToCart() {
    if defaults.string(forKey: "JWT") == nil {
    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
    }else if LaunchScreen.Cart?.CartId  == 0 {
    ShowMessageAlert("𝗶", "Error", "It is not possible to add any item to the cart because there is no event", true){}
    }else if AddCartAndRemove.titleLabel?.text == "Add to Cart" {
    AddCart(1)
    }else{
    AddCart(0)
    }
    }
    
    func AddCart(_ Count:Int) {
    guard let Id = ItemId else{return}
    let CartId = LaunchScreen.Cart?.CartId ?? 0
    guard let token = defaults.string(forKey: "JWT") else{return}
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + AddItemToCart)"
                
    guard let SqlId = LaunchScreen.User?.SqlId else{return}
    ObjectCart.append(AddToCart(Id: Id, Count: Count))
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                    "Platform": "I",
                                    "SqlId": SqlId,
                                    "CartId": "\(CartId)",
                                    "cartItems":jsonToDictionary(ObjectCart)]

    self.ProgressHud.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { String in
    } DictionaryData: { data in

    self.ObjectCart.removeAll()
    let DataItems = MenuPackagesItemsObject(dictionary: data)
    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: DataItems.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
        
    if Count != 0 {
    self.IfInCart(true)
    self.ProgressHud.endRefreshing("Success Add To Cart", .success) {}
    if let index = self.HasSubSingle?.DataItems?.MenuItems.firstIndex(where: {$0.Id == Id})  {
    self.HasSubSingle?.DataItems?.MenuItems.forEach{ $0.InCart = false }
    self.HasSubSingle?.DataItems?.MenuItems[index].InCart = true
    self.HasSubSingle?.CollectionView.reloadData()
    }
    }else{
    self.HasSubSingle?.DataItems?.MenuItems.forEach{ $0.InCart = false }
    self.HasSubSingle?.CollectionView.reloadData()
            
    self.IfInCart(false)
    self.ProgressHud.endRefreshing("Success Delete From Cart", .success) {}
    }
        
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if  error != "" {
    self.ProgressHud.endRefreshing(error, .error) {}
    }
    }
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
        
        let data = ["Details": ["Id" : 1,"Name" : "Packages 1","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 70.000,"MainPhoto" : "https://www.gettyimages.com/gi-resources/images/500px/983794168.jpg","InCart" : false,"Count" : 0,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "P",
         "Gallery":[
        ["PhotoPath":"https://www.gettyimages.com/gi-resources/images/500px/983794168.jpg"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]]
        ]
        ]
        
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ItemsDetails = MenuPackagesItemsDetails(dictionary: data)
            
            self.CollectionImage.removeAll()
            if let Details = self.ItemsDetails?.Details {
                
                self.DetailsLabel.text = Details.Description ?? ""
                self.ClassLabel.text = Details.ClassName ?? ""
                self.UpdateContent()
                
                if Details.Gallery.count == 0 {
                    self.CollectionImage.append(UIImage(named: "group26396") ?? UIImage())
                    self.LorgeImage.image = self.CollectionImage.first
                    self.CollectionViewImage.AnimateCollection()
                }else{
                    
                    for Photo in Details.Gallery {
                        if let images = Photo.PhotoPath {
                            SDWebImageManager.shared.loadImage(with: URL(string: images),
                                                               options: .highPriority ,progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                                if let img = image {
                                    self.CollectionImage.append(img)
                                    self.CollectionViewImage.AnimateCollection()
                                    self.LorgeImage.image = self.CollectionImage.first
                                }}}}}
            }
            
            self.ViewScroll.isHidden = false
            self.ViewNoData.isHidden = true
            self.ProgressHud.endRefreshing() {}
            self.IfInCart(self.ItemsDetails?.Details?.InCart ?? false)
//            let DataItems = MenuPackagesItemsObject(dictionary: data)
//            LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: DataItems.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
            self.heart.image = self.ItemsDetails?.Details?.Favorite ?? false ? UIImage(named: "heartSelect"):UIImage(named: "heart")
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if  error != "" {
//    self.ViewScroll.isHidden = true
//    self.ViewNoData.isHidden = false
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }
//    }
    }

    func IfInCart(_ inCart:Bool) {
        if inCart {
        BottomView.Show()
        BottomView.Items = LaunchScreen.Cart?.CartItemCount ?? 0
        AddCartAndRemove.setTitle("Remove from Cart", for: .normal)
        }else{
        BottomView.animHide()
        AddCartAndRemove.setTitle("Add to Cart", for: .normal)
        }
    }
    
}

///... Set Up Collection
extension HasSubSingleDetails : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OutdoorDetailsID, for: indexPath) as! HasSubSingleDetailsCell
        cell.ImageView.image = CollectionImage[indexPath.item]
        cell.layer.borderColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1).cgColor
        cell.layer.borderWidth = indexSelect == indexPath ? ControlHeight(3):0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - ControlWidth(16)) / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
        UIView.animate(withDuration: 0.1, animations: {
        self.indexSelect = indexPath
        self.LorgeImage.image = self.CollectionImage[indexPath.item]
        cell.transform = cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
        cell.transform = .identity
        }, completion: { _ in
        collectionView.reloadData()
        })
        })
        }
    }
}
