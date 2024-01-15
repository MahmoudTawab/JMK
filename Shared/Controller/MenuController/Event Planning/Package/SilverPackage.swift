//
//  SilverPackage.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/08/2021.
//

import UIKit
import SDWebImage

class SilverPackage: ViewController, UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout , UITableViewDelegate, UITableViewDataSource , MediaBrowserDelegate {
        
    var image = [UIImage]()
    var WeddingPackageId = Int()
    var ObjectMenu : MenuObject?
    private let CreatedEventID = "CellCreatedEvent"
    var PackagesDetils : PackagesWeddingDetils?
    
    private let SilverPackageID = "CellSilverPackage"
    var indexSelect = IndexPath(row: 0, section: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
        
        WeddingPackagesDetils()
    }
    
    func SetUp() {
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
        
        view.addSubview(ShoppingButton)
        ShoppingButton.frame = CGRect(x: view.frame.maxX - ControlX(55), y: ControlY(35), width: ControlWidth(38), height: ControlHeight(38))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(95), width: view.frame.width, height: view.frame.height - ControlWidth(95))
        
        TableView.tableHeaderView = HeaderView
        HeaderView.frame = CGRect(x: 0, y: 0, width: TableView.frame.width, height: ControlWidth(420))
        
        HeaderView.addSubview(LorgeImage)
        LorgeImage.frame = CGRect(x: ControlX(15), y: 0, width: HeaderView.frame.width -  ControlWidth(30), height: ControlWidth(220))
        
        HeaderView.addSubview(CollectionHorizontal)
        CollectionHorizontal.frame = CGRect(x: ControlX(15), y: LorgeImage.frame.maxY + ControlY(8), width: HeaderView.frame.width - ControlWidth(30), height: ControlWidth(100))
        
        HeaderView.addSubview(SilverPackageLabel)
        SilverPackageLabel.frame = CGRect(x: ControlX(15), y: CollectionHorizontal.frame.maxY + ControlX(25), width: HeaderView.frame.width - ControlWidth(30), height: ControlWidth(40))
                
        TableView.tableFooterView = FooterView
        FooterView.frame = CGRect(x: 0, y: 0, width: TableView.frame.width, height: ControlWidth(70))
        
        FooterView.addSubview(AddToCart)
        AddToCart.frame = CGRect(x: ControlX(15), y: ControlY(10), width: HeaderView.frame.width - ControlWidth(30), height: ControlWidth(50))
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(WeddingPackagesDetils), for: .touchUpInside)
    }
    
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Silver Package"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var HeaderView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
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
        image.count
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: image[index] ,caption: "Silver Package Image")
    return photo
    }
    
    lazy var CollectionHorizontal: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(8)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.showsHorizontalScrollIndicator = false
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.register(SilverPackageCell.self, forCellWithReuseIdentifier: SilverPackageID)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SilverPackageID, for: indexPath) as! SilverPackageCell 
        cell.ImageView.image = image[indexPath.item]
        cell.layer.borderColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1).cgColor
        cell.layer.borderWidth = indexSelect == indexPath ? ControlWidth(4):0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width -  ControlWidth(16)) / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
        UIView.animate(withDuration: 0.1, animations: {
        self.indexSelect = indexPath
        self.LorgeImage.image = self.image[indexPath.item]
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
    
    lazy var SilverPackageLabel : UILabel = {
        let Label = UILabel()
        return Label
    }()
    
    func SetSilverPackage(_ From:Int ,_ To:Int ,_ inCart:Bool) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlHeight(18)
        
        let attributedString = NSMutableAttributedString(string: "Silver Package (From \(From) , To \(To))\n", attributes: [
            .font: UIFont(name: "Raleway-Bold" ,size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1) ,
            .paragraphStyle:style
        ])

        attributedString.append(NSAttributedString(string: "The package will include the following:", attributes: [
            .font: UIFont(name: "Raleway-Regular" ,size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
            .foregroundColor: UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        SilverPackageLabel.numberOfLines = 2
        SilverPackageLabel.attributedText = attributedString
        SilverPackageLabel.backgroundColor = .clear
        IfInCart(inCart)
    }
    
    func IfInCart(_ inCart:Bool) {
//        if inCart {
//        AddToCart.alpha = 0
//        BottomView.Show()
//        BottomView.Items = LaunchScreen.Cart?.CartItemCount ?? 0
//        }else{
//        AddToCart.alpha = 1
//        BottomView.animHide()
//        }
    }
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.register(PackageCell.self, forCellReuseIdentifier: CreatedEventID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(15), right: 0)
        return tv
    }()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PackagesDetils?.SubCategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PackageCell(style: .subtitle, reuseIdentifier: CreatedEventID)
        SetUpCell(cell, indexPath)
        return cell
    }
    
    func SetUpCell(_ cell : PackageCell ,_ indexPath:IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.Package = self
      
        cell.LabelName.text = PackagesDetils?.SubCategories[indexPath.row].Name
        if let SubItems = PackagesDetils?.SubCategories[indexPath.row].Items {
        cell.DetilsSubItems = SubItems
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let height = PackagesDetils?.SubCategories[indexPath.row].Items {
    return ControlWidth(CGFloat(height.count * 40) + 75)
    }else{
    return 0
    }
    }
    
    lazy var FooterView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var AddToCart : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Add to Cart", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddToCart), for: .touchUpInside)
        return Button
    }()
        
    @objc func ActionAddToCart() {
        if LaunchScreen.Cart?.CartItemCount == 0 {
        AddInCart()
        }else{
        ShowMessageAlert("𝗶", "Alert From Cart", "An item is already added to your cart\nwould you like to exchange it?", false, self.AddInCart, "Replaced")
        }
    }
    
    
    @objc func AddInCart() {
//    if LaunchScreen.Cart?.CartId  == 0 {
//    ShowMessageAlert("𝗶", "Error", "It is not possible to add any item to the cart because there is no event", true){}
//    return
//    }
//        
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + AddWeddingPackagesToCart)"
//
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let CartId = LaunchScreen.Cart?.CartId else{return}
//    guard let EvintId = LaunchScreen.Cart?.EvintId else{return}
//                
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "SqlId": SqlId,
//                                    "Platform": "I" ,
//                                    "CartId": "\(CartId)",
//                                    "EvintId": "\(EvintId)",
//                                    "WeddingPackageId": "\(WeddingPackageId)"]
              
    self.ProgressHud.beginRefreshing()

//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
//    self.ObjectMenu = MenuObject(dictionary: data)
        
//    let CartData = self.ObjectMenu?.Cart ?? [String:Any]()
//    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: CartData){}
        
        
    self.ProgressHud.endRefreshing("Auccess Add to Cart", .success) {
//    self.IfInCart(true)
//    self.UpDateShoppingHubCount()
        
    FirstController(TabBarController())
    }
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    error != "" ? self.ProgressHud.endRefreshing(error, .error) {}:self.ProgressHud.endRefreshing() {}
//    }
    }

    
    @objc func WeddingPackagesDetils() {
    
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetWeddingPackagesDetils)"
//        
//    let SqlId = LaunchScreen.User?.SqlId as Any
//    guard let EvintId = LaunchScreen.Cart?.EvintId else{return}
//                
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "SqlId": SqlId,
//                                     "Platform": "I" ,
//                                     "WeddingPackageId": "\(WeddingPackageId)",
//                                     "EventId": "\(EvintId)"]
      

    self.ProgressHud.beginRefreshing()
        
//    PostAPI(api: api, token: token, parameters: parameters) { String in
//    } DictionaryData: { data in
        
        
        let data = ["Id" : 1,"Name" : "Packages Wedding","Icon" : "https://cdn-icons-png.flaticon.com/128/4853/4853062.png","BudgetFrom" : 10000,"BudgetTo" : 20000,"inCart" : true,
                    "Gallery" : [
                        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv5Dwa2Pi0SMi6zmv-ifcJZnPXR5vonEiZ0pFfNDbPvFzEte2xsjopVX30gEruxdOon3Y&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]],
                        
                    "SubCategories" :
                    [
                        ["Id" : 0,"Name" : "Sub Categories","HasSub" : false,
                         "Items" :[["Id" : 0,"Name" : " Test Sub Categories 1","Count" : 3,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories 2","Count" : 5,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories 3","Count" : 6,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories 4","Count" : 9,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"]]
                        ],
                        
                        ["Id" : 0,"Name" : "Test Sub Categories 5","HasSub" : false,
                         "Items" :[["Id" : 0,"Name" : "Sub Categories","Count" : 3,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories 6","Count" : 5,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories 7","Count" : 6,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories 8","Count" : 9,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"]]
                        ],
                        
                        ["Id" : 0,"Name" : "Test Sub Categories","HasSub" : false,
                         "Items" :[["Id" : 0,"Name" : "Sub Categories","Count" : 3,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories","Count" : 5,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories","Count" : 6,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories","Count" : 9,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"]]
                        ],
                        
                        ["Id" : 0,"Name" : "Test Sub Categories","HasSub" : false,
                         "Items" :[["Id" : 0,"Name" : "Sub Categories","Count" : 3,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories","Count" : 5,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories","Count" : 6,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
                            ["Id" : 0,"Name" : "Test Sub Categories","Count" : 9,"SubPackagesId" : "","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"]]
                        ]
                    ]
        ] as [String : Any]
    
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.PackagesDetils = PackagesWeddingDetils(dictionary: data)
            if let images = self.PackagesDetils?.Gallery {
                self.TableView.isHidden = false
                self.ViewNoData.isHidden = true
                self.TableView.reloadData()
                
                for item in images {
                    SDWebImageManager.shared.loadImage(with: URL(string: item.PhotoPath ?? ""),
                                                       options: .highPriority,progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                        if let img = image {
                            self.image.append(img)
                            self.LorgeImage.image = self.image.first
                            self.CollectionHorizontal.AnimateCollection()
                        }
                    }
                }
            }
            
            
            if let From = self.PackagesDetils?.BudgetFrom ,let To = self.PackagesDetils?.BudgetTo ,let inCart = self.PackagesDetils?.inCart  {
                self.SetSilverPackage(From,To,inCart)
            }
            
            self.ProgressHud.endRefreshing() {}
        }
        
//    } ArrayOfDictionary: { dictionary in
//    } Err: { error in
//    if error != "" {
//    self.TableView.isHidden = true
//    self.ViewNoData.isHidden = false
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }
//    }
    }

}
