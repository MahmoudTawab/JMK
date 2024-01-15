//
//  HasSubMultipleVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/08/2021.
//

import UIKit

class HasSubMultipleVC: ViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , HasSubMultipleDelegate {
    
    var MenuData : Menu?
    var DataItems : MenuPackagesItemsObject?
    private let TablesAndChairsID = "CellTablesAndChairs"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
        GetSubPackagesItems()
    }
    
    
    func SetUp() {
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
        
        view.addSubview(ShoppingButton)
        ShoppingButton.frame = CGRect(x: view.frame.maxX - ControlX(55), y: ControlY(35), width: ControlWidth(38), height: ControlWidth(38))
        
        view.addSubview(ViewBar)
        ViewBar.frame = CGRect(x: ControlX(15), y: ControlX(90), width: view.frame.width - ControlWidth(30), height: ControlWidth(50))
        
        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: ViewBar.frame.maxY + ControlX(15), width: view.frame.width - ControlWidth(30), height: view.frame.height - ControlWidth(145))
                
        self.ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSubPackagesItems), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(IsFavorite), name: SaveView.SuccessSaved , object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
        refreshControl.addTarget(self, action: #selector(GetSubPackagesItems), for: .valueChanged)
        CollectionView.refreshControl = refreshControl
    }

    @objc func GetSubPackagesItems()  {
        guard let Menudata = MenuData else{return}
        guard let Name = Menudata.Name else{return}
        Dismiss.TextDismiss = Name
//        
//        let CartId = LaunchScreen.Cart?.CartId ?? 0
//        guard let PackageId = data.PackageId else{return}
//        guard let url = defaults.string(forKey: "API") else{return}
//        let api = "\(url + GetCategoryItems)"
//
//        let SqlId = LaunchScreen.User?.SqlId as Any
//        let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                        "Platform": "I",
//                                        "SqlId": SqlId,
//                                        "SubCategoryId":PackageId,
//                                        "CartId": "\(CartId)",
//                                        "Token": "euIA1Ug_jZk6UxKKqbUr8C06-XXxU_MejmIRSva6q6w"]

        self.ProgressHud.beginRefreshing()

//        PostAPI(api: api, token: nil, parameters: parameters) { _ in
//        } DictionaryData: { data in
        
        let data = ["Items":[
                        
            ["Id" : 1,"Name" : "Packages 1","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 70.000,"MainPhoto" : "https://media.istockphoto.com/id/1394071400/photo/hot-air-balloons-soaring-over-the-taj-mahal-in-agra-city.webp?b=1&s=170667a&w=0&k=20&c=LuR4nlP5HEGImg3lM-RoYlbk63qjbPAUga3JJ-0vWys=","InCart" : false,"Count" : 0,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "P",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ],
        
        ["Id" : 1,"Name" : "Packages 2","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 90.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU","InCart" : true,"Count" : 6,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "S",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ],
        
        ["Id" : 1,"Name" : "Packages 3","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 60.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU","InCart" : false,"Count" : 0,"Favorite" : false,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "A",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ],
        
        ["Id" : 1,"Name" : "Packages 4","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 30.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU","InCart" : true,"Count" : 4,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "S",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ],
        
        
        ["Id" : 1,"Name" : "Packages 5","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 10.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU","InCart" : false,"Count" : 0,"Favorite" : false,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "P",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ],
        
        
        ["Id" : 1,"Name" : "Packages 6","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 50.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo1RqMnCLJJoYDezcZlWeQXxCtIA-Uknxeua3ubS-YdHW_lBR5I1CNUD10LHqru2ztbH0&usqp=CAU","InCart" : false,"Count" : 0,"Favorite" : false,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "C",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ]
        
        ]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.DataItems = MenuPackagesItemsObject(dictionary: data)
            self.CollectionView.AnimateCollection()
            
            self.CollectionView.refreshControl?.endRefreshing()
            self.ViewNoData.isHidden = self.DataItems?.MenuItems.count == 0 ? false:true
//            LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: self.DataItems?.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
            self.ProgressHud.endRefreshing() {}
        }
        
//        } ArrayOfDictionary: { _ in
//        } Err: { error in
//        self.CollectionView.refreshControl?.endRefreshing()
//        if  error != "" {
//        self.ViewNoData.isHidden = false
//        self.ProgressHud.endRefreshing(error, .error) {}
//        }
//        }
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
        View.Budget.text = "200.000"
        View.BudgetNum = LaunchScreen.Cart?.BudgetTo ?? 0
        return View
    }()

    
    lazy var CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsVerticalScrollIndicator = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        vc.register(HasSubMultipleCell.self, forCellWithReuseIdentifier: TablesAndChairsID)
        return vc
    }()


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataItems?.MenuItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TablesAndChairsID, for: indexPath) as! HasSubMultipleCell
        cell.delegate = self
        
        if let MenuItems = DataItems?.MenuItems[indexPath.item] {
        cell.LabelTitle.text = MenuItems.Name
        cell.LabelDetails.text = MenuItems.Description
        cell.ClassLabel.text = MenuItems.ClassName
        cell.LabelDetails.spasing = ControlWidth(5)
        cell.ImageView.setImage(urlString: MenuItems.MainPhoto ?? "", placeHolderImage: UIImage(named: "group26396")) { _ in}
       
        cell.heart.image = MenuItems.Favorite == false ? UIImage(named: "heart") : UIImage(named: "heartSelect")
        cell.layer.borderColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1).cgColor
        cell.layer.borderWidth = MenuItems.InCart == true ? 2:0
        cell.SelectImage.alpha = MenuItems.InCart == true ? 1:0
        cell.AddInviteToCart.isHidden = MenuItems.InCart ?? true
            
        cell.CountView.isHidden = !(MenuItems.InCart ?? true)

        cell.CountTF.text = "\(MenuItems.Count ?? 0)"
        }
        
        return cell
    }
    
    func CountTFDidEnd(Cell: HasSubMultipleCell) {
    if let index = CollectionView.indexPath(for: Cell) {
    if let text = Cell.CountTF.text {
    let temp =  (text as NSString).integerValue
    if temp == 0 || Cell.CountTF.text == "" {
    if let Id = DataItems?.MenuItems[index.item].Id {
    CallApiAddToCart(index, Id, 1, 0)
    }
    }else{
    if let Id = DataItems?.MenuItems[index.item].Id {
    CallApiAddToCart(index, Id, temp, 0)
    }
    }
    }
    }
    }
    
    func CountMinus(Cell: HasSubMultipleCell) {
    if let index = CollectionView.indexPath(for: Cell) {
    if var Count = DataItems?.MenuItems[index.item].Count {
    Count -= 1
    if let Id = DataItems?.MenuItems[index.item].Id {
    CallApiAddToCart(index, Id, Count, 2)
    }
    }
    }
    }
    
    func CountPlus(Cell: HasSubMultipleCell) {
    if let index = CollectionView.indexPath(for: Cell) {
    if var Count = DataItems?.MenuItems[index.item].Count {
    Count += 1
    if let Id = DataItems?.MenuItems[index.item].Id {
    CallApiAddToCart(index, Id, Count, 2)
    }
    }
    }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ControlWidth(167), height: ControlWidth(270))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlWidth(15)
    }

    let ViewSave = SaveView()
    var indexSelect : IndexPath?
    func ActionHeart(Cell: HasSubMultipleCell) {
    if let indexPath = CollectionView.indexPath(for: Cell) {
    indexSelect = indexPath
    if Cell.heart.image == UIImage(named: "heart") {
    Favorite = true
    ViewSave.currentState = .open
    ViewSave.ItemId = DataItems?.MenuItems[indexPath.item].Id
    ViewSave.modalPresentationStyle = .overFullScreen
    ViewSave.modalTransitionStyle = .coverVertical
    present(ViewSave, animated: true)
    }else{
    Favorite = false
    ShowMessageAlert("𝗶", "Delete Favorite", "Do you really want to delete this item from your favourites", false, self.ActionDeleteFavorite, "Delete")
    }
    }
    }

    
    @objc func ActionDeleteFavorite() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + DeleteSavedItemFromFolder)"
//     
//    guard let index = indexSelect?.item else{return}
//    guard let Id = DataItems?.MenuItems[index].Id else{return}
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "SqlId": SqlId,
//                                    "Platform": "I",
//                                    "ItemId": "\(Id)"]

    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ProgressHud.endRefreshing("Success Delete To Favorite", .success) {self.IsFavorite()}
        }
        
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionDeleteFavorite)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }

    func AddHasSubMultipleToCart(Cell: HasSubMultipleCell) {
    if let index = CollectionView.indexPath(for: Cell) {
    if let Id = DataItems?.MenuItems[index.item].Id {
    CallApiAddToCart(index, Id, 1, 0)
    }
    }
    }
    
    func CallApiAddToCart(_ index:IndexPath , _ Id:Int,_ count:Int,_ timeInterval:TimeInterval) {
//    if defaults.string(forKey: "JWT") == nil {
//    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
//    }else if LaunchScreen.Cart?.CartId  == 0 {
//    ShowMessageAlert("𝗶", "Error", "It is not possible to add any item to the cart because there is no event", true){}
//    }else{
    timer?.invalidate()
    
    Indexs.append(index)
    DataItems?.MenuItems[index.item].InCart = count != 0 ? true:false
    DataItems?.MenuItems[index.item].Count = count
    CollectionView.reloadItems(at: [index])
  
    for Item in Indexs.uniqued() {
    if let Item = DataItems?.MenuItems[Item.item] {
    ObjectCart.removeAll(where: {$0.Id == Item.Id})
    ObjectCart.append(AddToCart(Id: Item.Id, Count: Item.Count))
    }
    }
        
    timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(AddItemCart), userInfo: nil, repeats: false)
//    }
    }

    var timer:Timer?
    var Indexs = [IndexPath]()
    var ObjectMenu : MenuObject?
    var ObjectCart = [AddToCart]()
    static let NotificationCartCount = NSNotification.Name(rawValue: "CartItemCount")
    static let NotificationCartCountNil = NSNotification.Name(rawValue: "CartItemCountNil")
    @objc func AddItemCart() {
//    let CartId = LaunchScreen.Cart?.CartId ?? 0
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + AddItemToCart)"
//                
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "Platform": "I",
//                                    "SqlId": SqlId,
//                                    "CartId": "\(CartId)",
//                                    "cartItems":jsonToDictionary(ObjectCart)]

//    PostAPI(api: api, token: token, parameters: parameters) { String in
//    } DictionaryData: { data in

    self.Indexs.removeAll()
//    self.ObjectMenu = MenuObject(dictionary: data)
//    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: self.ObjectMenu?.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
//        
//    self.IfInCart(true)
        
//    NotificationCenter.default.post(name: HasSubMultipleVC.NotificationCartCount, object: nil)
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if  error != "" {
//    ShowMessageAlert("𝗶", "Error", error, true){}
//    }
//    }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelect = indexPath
        let Details = HasSubMultipleDetails()
        Details.Title = Dismiss.TextDismiss
        Details.HasSubMultiple = self
        Details.ItemId = DataItems?.MenuItems[indexPath.item].Id
        Present(ViewController: self, ToViewController: Details)
    }
        
    var Favorite = Bool()
    @objc func IsFavorite() {
    if let index = indexSelect {
    DataItems?.MenuItems[index.item].Favorite = Favorite
    CollectionView.reloadItems(at: [index])
    }
    }
    
    func IfInCart(_ inCart:Bool) {
        if inCart {
        BottomView.animShow()
        BottomView.Items = LaunchScreen.Cart?.CartItemCount ?? 0
        }else{
        BottomView.animHide()
        }
    }
}
