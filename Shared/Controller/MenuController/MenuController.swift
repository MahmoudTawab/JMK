//
//  MenuController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 11/07/2021.
//

import UIKit
import SDWebImage
import FlagPhoneNumber

class MenuController: CollapsibleCollection ,CollapsibleCollectionSectionDelegate ,MenuCellDelegate {

    
    var ObjectMenu : MenuObject?
    var sections = [Menu]()
    var HeaderViewHeight = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.delegate = self
             
        view.addSubview(MenuLabel)
        MenuLabel.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlWidth(30), height: ControlHeight(20))

        view.addSubview(ShoppingButton)
        ShoppingButton.frame = CGRect(x: view.frame.maxX - ControlX(55), y: ControlY(35), width: ControlWidth(38), height: ControlWidth(38))
        
        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: ControlX(80), width: view.frame.width - ControlWidth(30), height: view.frame.height - ControlWidth(160))
           
        GetMyEvent()
        ViewNoData.RefreshButton.addTarget(self, action: #selector(GetMyEvent), for: .touchUpInside)
    }
    
    func SetUp() {
        
        CollectionView.contentInset = UIEdgeInsets(top: HeaderViewHeight, left: 0, bottom: ControlY(10), right: 0)
        
        CollectionView.addSubview(HeaderView)
        HeaderView.frame = CGRect(x: 0, y: -HeaderViewHeight, width: CollectionView.frame.width, height: HeaderViewHeight)

        HeaderView.addSubview(StartPlanning)
        StartPlanning.frame = CGRect(x: 0, y: ControlY(25), width: HeaderView.frame.width, height: ControlWidth(50))

        HeaderView.addSubview(YourPlan)
        YourPlan.frame = CGRect(x: 0, y: ControlY(25), width: HeaderView.frame.width, height: ControlWidth(100))
    }
    
 
    lazy var MenuLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Menu"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var HeaderView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
    }()

    lazy var StartPlanning : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Start Planning", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionStartPlanning), for: .touchUpInside)
        return Button
    }()

    @objc func ActionStartPlanning() {
    if defaults.string(forKey: "JWT") == nil {
    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
    }else{
    Present(ViewController: self, ToViewController: EventPlanningStep1())
    }
    }
    
    lazy var YourPlan : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [YourPlanLabel,YourPlanButton])
    Stack.axis = .vertical
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()

    
    lazy var YourPlanLabel : UIButton = {
        let Button = UIButton(type: .system)
        Button.isEnabled = false
        Button.backgroundColor = #colorLiteral(red: 0.4274282157, green: 0.3787001967, blue: 0.3576200008, alpha: 1)
        Button.contentHorizontalAlignment = .left
        Button.setTitle("Your Plan", for: .normal)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 1, green: 0.971345441, blue: 0.9510625207, alpha: 1), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlHeight(40)).isActive = true
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlX(20), bottom: 0, right: ControlX(20))
        return Button
    }()
    
    lazy var YourPlanButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = #colorLiteral(red: 0.9657987952, green: 0.9488616586, blue: 0.9384700656, alpha: 1)
        Button.contentHorizontalAlignment = .left
        Button.titleLabel?.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.4274282157, green: 0.3787001967, blue: 0.3576200008, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionYourPlan), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlHeight(60)).isActive = true
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlX(20), bottom: 0, right: ControlX(20))
        
        Button.addSubview(YourPlanIcon)
        YourPlanIcon.centerYAnchor.constraint(equalTo: Button.centerYAnchor).isActive = true
        YourPlanIcon.rightAnchor.constraint(equalTo: Button.rightAnchor , constant: ControlHeight(-10)).isActive = true
        return Button
    }()
    
    lazy var YourPlanIcon : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .clear
        dismiss.transform = CGAffineTransform(rotationAngle: .pi)
        dismiss.translatesAutoresizingMaskIntoConstraints = false
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionYourPlan)))
        return dismiss
    }()
    
    @objc func ActionYourPlan() {
    Present(ViewController: self, ToViewController: EventType())
    }
    
    func numberOfSections(_ collectionView: UICollectionView) -> Int {
    return sections.count
    }
    
    func collapsibleCollectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].SubItems.count
    }

    func collapsibleCollectionView(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellMenu, for: indexPath) as! MenuCell
        cell.Delegate = self
        cell.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        
        let Packages = sections[indexPath.section].SubItems
        let data = Packages[indexPath.row]
        cell.ItemsLabel.text = data.Name
        cell.ItemsImage.sd_setImage(with: URL(string: data.Icon ?? ""))

        return cell
    }
    
    func ActionBackground(Cell: MenuCell) {
    if let index = CollectionView.indexPath(for: Cell) {
    let MenuData = sections[index.section]
        
    let MenuItems = sections[index.section].SubItems
    let data = MenuItems[index.row]
    guard let HasSub = data.HasSub else{return}

    switch data.type?.uppercased() {
    case "P":
    self.MyOwnPlace()
    case "I":
    self.Present(ViewController: self, ToViewController: InviteVC())
    default:
    if HasSub {
    let MenuHasSub = MenuHasSubVC()
    MenuHasSub.MenuData = data
//    MenuHasSub.type = MenuData.type?.uppercased()
    MenuHasSub.GetSubPackagesNone()
    self.Present(ViewController: self, ToViewController: MenuHasSub)
    }else{
    if MenuData.type?.uppercased() == "S" {
    let MenuDataTypeS = HasSubSingleVC()
    MenuDataTypeS.MenuData = data
    self.Present(ViewController: self, ToViewController: MenuDataTypeS)
    }else{
    let MenuDataTypeM = HasSubMultipleVC()
    MenuDataTypeM.MenuData = data
    self.Present(ViewController: self, ToViewController: MenuDataTypeM)
    }

    }
    }
    }
    }
    
    @objc func MyOwnPlace() {
//    if defaults.string(forKey: "JWT") == nil {
//    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
//    }else{
    let MyPlaces = MyPlacesVC()
    MyPlaces.IfIsSelectHidden = false
    MyPlaces.Dismiss.TextDismiss = "My Own Place"
    Present(ViewController: self, ToViewController: MyPlaces)
//    }
    }
    
    
    func collapsibleCollectionView(_ collectionView: UICollectionView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].Name
    }

    
    func shouldCollapseByDefault(_ collectionView: UICollectionView) -> Bool {
    return true
    }
    
    func shouldCollapseOthers(_ collectionView: UICollectionView) -> Bool {
        return true
    }
    
    var ShowHeaderView = true
    @objc func GetMyEvent() {
       
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetMenuCategories)"
//
//    let SqlId = LaunchScreen.User?.SqlId as Any
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "Platform": "I",
//                                    "SqlId": SqlId ,
//                                    "Token": "sjpn3ru6nj&ker9cvdw@6we"]
//
//
    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: nil, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = [
            "Categories":[
                
                ["PackageId" : "2","Name" : "My Own Place","Icon" : "","HasSub" : false,"Type" : "P","FatherId" : "1"
                           ,"SubPackages":[["PackageId" : "2","Name" : "My Own Place","Icon" : "https://cdn-icons-png.flaticon.com/128/13898/13898436.png","HasSub" : false,"Type" : "P","FatherId" : "1"]],
                ],
                
                ["PackageId" : "2","Name" : "Test Invite","Icon" : "","HasSub" : false,"Type" : "I","FatherId" : "1"
                           ,"SubPackages":[["PackageId" : "2","Name" : "Test Invite","Icon" : "https://cdn-icons-png.flaticon.com/128/9717/9717623.png","HasSub" : false,"Type" : "I","FatherId" : "1"]]],
                
                ["PackageId" : "1","Name" : "Categorie 1","Icon" : "","HasSub" : true,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "1","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/11380/11380698.png","HasSub" : true,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "1","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/7058/7058356.png","HasSub" : true,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "1","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6598/6598618.png","HasSub" : true,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "1","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/1043/1043298.png","HasSub" : true,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "1","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/8703/8703569.png","HasSub" : true,"Type" : "S","FatherId" : "1"]]
                ],
                
                ["PackageId" : "2","Name" : "Categorie 2","Icon" : "","HasSub" : false,"Type" : "D","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "2","Name" : "Test 2","Icon" : "https://cdn-icons-png.flaticon.com/128/4317/4317725.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "2","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/4317/4317757.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "2","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6037/6037886.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "2","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/4649/4649605.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "2","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/1680/1680945.png","HasSub" : false,"Type" : "S","FatherId" : "1"]]
                ],
                
                ["PackageId" : "3","Name" : "Categorie 3","Icon" : "","HasSub" : false,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "3","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/11380/11380698.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/7058/7058356.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6598/6598618.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/1043/1043298.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/8703/8703569.png","HasSub" : false,"Type" : "S","FatherId" : "1"]]
                ],
                
                ["PackageId" : "4","Name" : "Categorie 4","Icon" : "","HasSub" : false,"Type" : "D","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "4","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/11380/11380698.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "4","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/7058/7058356.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "4","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6598/6598618.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "4","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/1043/1043298.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "4","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/8703/8703569.png","HasSub" : false,"Type" : "S","FatherId" : "1"]]
                ],
                
                ["PackageId" : "5","Name" : "Categorie 5","Icon" : "","HasSub" : false,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "5","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/11380/11380698.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "5","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/7058/7058356.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "5","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6598/6598618.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "5","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/1043/1043298.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "5","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/8703/8703569.png","HasSub" : false,"Type" : "S","FatherId" : "1"]]
                ],
                
                ["PackageId" : "6","Name" : "Categorie 6","Icon" : "","HasSub" : false,"Type" : "D","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "6","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/11380/11380698.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "6","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/7058/7058356.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "6","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6598/6598618.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "6","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/1043/1043298.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "6","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/8703/8703569.png","HasSub" : false,"Type" : "S","FatherId" : "1"]]
                ],
                
                ["PackageId" : "7","Name" : "Categorie 7","Icon" : "","HasSub" : false,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "7","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/11380/11380698.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "7","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/7058/7058356.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "7","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6598/6598618.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "7","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/1043/1043298.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "7","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/8703/8703569.png","HasSub" : false,"Type" : "S","FatherId" : "1"]]
                ],
                
                ["PackageId" : "8","Name" : "Categorie 8","Icon" : "","HasSub" : false,"Type" : "D","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "8","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/11380/11380698.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "8","Name" : "Test 2 ","Icon" : "https://cdn-icons-png.flaticon.com/128/7058/7058356.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "8","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/6598/6598618.png","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "8","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/1043/1043298.png","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "8","Name" : "Test 5","Icon" : "https://cdn-icons-png.flaticon.com/128/8703/8703569.png","HasSub" : false,"Type" : "S","FatherId" : "1"]]
                ]
                         
        ]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.sections.removeAll()
            self.ObjectMenu = MenuObject(dictionary: data)
            
            if let sections = self.ObjectMenu?.Categories {
                for item in sections {
                    self.sections.append(item)
                    self.CollectionView.reloadData()
                }
            }
            
            
            
            self.IfNoData()
            self.LodCart(self.ShowHeaderView)
            self.ProgressHud.endRefreshing() {}
//            LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: self.ObjectMenu?.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData()
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetMyEvent)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }
    
    func LodCart(_ Show:Bool = true) {
    if Show {
    if let Title = LaunchScreen.Cart?.CategoryName {
    YourPlan.alpha = 1
    StartPlanning.alpha = 0
    HeaderViewHeight = ControlWidth(150)
    YourPlanButton.setTitle(Title, for: .normal)
    SetUp()
    }else{
    YourPlan.alpha = 0
    StartPlanning.alpha = 1
    HeaderViewHeight = ControlWidth(100)
    SetUp()
    }
    }else{
    YourPlan.alpha = 0
    HeaderViewHeight = 0
    StartPlanning.alpha = 0
    SetUp()
    }
    }
    
    func IfNoData() {
        if sections.count == 0 {
        self.ViewNoData.isHidden = false
        }else{
        self.ViewNoData.isHidden = true
        }
    }
    
}



