//
//  MyPlacesVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 31/07/2021.
//

import UIKit

class MyPlacesVC: ViewController , UITableViewDelegate, UITableViewDataSource ,MyPlacesDelegate {
           
    private let MyPlacesID = "CellMyPlaces"
    var Places = [MyPlaces]()
    var IfIsSelectHidden = true
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(30), width: view.frame.width  - ControlWidth(90), height: ControlHeight(50))
        
        view.addSubview(AddButton)
        AddButton.frame = CGRect(x: view.frame.maxX - ControlWidth(46), y: ControlY(35), width: ControlWidth(31), height: ControlWidth(31))
        AddButton.layer.cornerRadius = AddButton.frame.height / 2
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width , height: view.frame.height - ControlWidth(90))
        
        
        
        self.ProgressHud.beginRefreshing()
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
        refreshControl.addTarget(self, action: #selector(TryAgainPlaces), for: .valueChanged)
        TableView.refreshControl = refreshControl
        

        NotificationCenter.default.addObserver(self, selector: #selector(TryAgainPlaces), name: AddNewPlaceVC.PostPlace , object: nil)
        LodMyPlaces()
        
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
    
    lazy var AddButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("＋", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255, green: 177 / 255, blue: 157 / 255, alpha: 1)
        Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: ControlWidth(20))
        Button.addTarget(self, action: #selector(ActionAdd), for: .touchUpInside)
        Button.contentHorizontalAlignment = .center
        Button.contentVerticalAlignment = .center
        Button.setTitleColor(.white, for: .normal)
        return Button
    }()
    
    
    @objc func ActionAdd() {
    let AddNewPlace = AddNewPlaceVC()
    AddNewPlace.DismissTitle = "Add New Place"
    AddNewPlace.SubmitOrSaveChanges.setTitle("Submit", for: .normal)
    Present(ViewController: self, ToViewController: AddNewPlace)
    }
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.rowHeight = ControlWidth(90)
        tv.register(MyPlacesCell.self, forCellReuseIdentifier: MyPlacesID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlacesID, for: indexPath) as! MyPlacesCell
        cell.selectionStyle = .none
        cell.Delegate = self
        
        cell.PaymentSettingsWidth1?.isActive = !IfIsSelectHidden
        cell.PaymentSettingsWidth2?.isActive = IfIsSelectHidden
        
        cell.LabelTitle.text = Places[indexPath.row].Name
        cell.LabelDetails.text = Places[indexPath.row].Address
        
        let image = Places[indexPath.row].inCart == true ? UIImage(named: "AddSelect"):UIImage(named: "AddNoSelect")
        cell.PaymentSettings.setImage(image, for: .normal)
        return cell
    }
    
    
    func EditAction(cell: MyPlacesCell) {
        if let index = TableView.indexPath(for: cell) {
        if let Id = Places[index.row].Id {
        let AddNewPlace = AddNewPlaceVC()
        AddNewPlace.DismissTitle = "Edit Place"
        AddNewPlace.PlaceId = "\(Id)"
        AddNewPlace.SubmitOrSaveChanges.setTitle("Save Changes", for: .normal)
        Present(ViewController: self, ToViewController: AddNewPlace)
        }
        }
    }
    
    var SelectIndex = IndexPath()
    func TrashAction(cell: MyPlacesCell) {
        if let index = TableView.indexPath(for: cell) {
        SelectIndex = index
        ShowMessageAlert("𝗶", "DELETE PLACES", "Are You Sure You Want to\nDelete this Places", false, self.ActionDelete, "Delete")
        }
    }
    
    @objc func ActionDelete() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + DeletePlace)"
//
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let Id = Places[SelectIndex.row].Id else{return}
//        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "SqlId": SqlId,
//                                    "Platform": "I",
//                                    "PlaceId" : Id]
    ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ProgressHud.endRefreshing() {}
            self.TableView.beginUpdates()
            
            self.Places.remove(at: self.SelectIndex.item)
            self.TableView.deleteRows(at: [self.SelectIndex], with: .right)
            self.TableView.endUpdates()
            
            self.IfNoData(false)
        }
        
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionDelete)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }
    
 
    func BackgroundAction(cell: MyPlacesCell) {
//    if !IfIsSelectHidden {
//    if LaunchScreen.Cart?.CartId  == 0 {
//    ShowMessageAlert("𝗶", "Error", "It is not possible to add any item to the cart because there is no event", true){}
//    return
//    }
//        
//    if let index = TableView.indexPath(for: cell) {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + AddSelectPlace)"
//                
//    guard let Id = Places[index.item].Id else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let EvintId = LaunchScreen.Cart?.EvintId else{return}
//            
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "SqlId": SqlId,
//                                    "Platform": "I",
//                                    "EventId": EvintId,
//                                    "PlacesId": Id]
//    ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    self.Places.forEach{ $0.inCart = false }
//    self.Places[index.item].inCart = true
//    self.TableView.reloadData()
//    self.ProgressHud.endRefreshing() {}
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }
//    }
//    }
    }
    
    func LodMyPlaces(removeAll:Bool = false) {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetSavedPlaces)"
//            
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let EvintId = LaunchScreen.Cart?.EvintId ?? 0
//        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "SqlId": SqlId,
//                                    "EventId": EvintId,
//                                    "Platform": "I"]
//        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        
        let data = [["Id" : 1,"Name" : "My house 1","Address" : "CAIRO, Street ,9Al Abageyah, El Mokattam 151","inCart" : true],
                          ["Id" : 1,"Name" : "My Work 1","Address" : "Mohandiseen, Giza","inCart" : false],
                          ["Id" : 1,"Name" : "My Work 2","Address" : "Mokattam, Cairo","inCart" : false],
                          ["Id" : 1,"Name" : "My house 2","Address" : "giza pyramids","inCart" : false]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            if removeAll {
                self.Places.removeAll()
                self.TableView.reloadData()
            }
            
            for item in data {
                self.Places.append(MyPlaces(dictionary: item))
                self.TableView.AnimateTable()
            }
            
            self.IfNoData()
            self.ProgressHud.endRefreshing() {}
            self.TableView.refreshControl?.endRefreshing()
        }
        
//    } Err: { error in
//    self.TableView.refreshControl?.endRefreshing()
//       
//    if error != "" && error != "No Content" {
//    self.IfNoData(true)
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.TryAgainPlaces)}
//    }else{
//    self.IfNoData(false)
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }

    @objc func TryAgainPlaces() {
    ProgressHud.beginRefreshing()
    LodMyPlaces(removeAll: true)
    }
    
    func IfNoData(_ isError: Bool = true) {
    if self.Places.count == 0 {
    if isError {
    self.ViewNoData.TextRefresh = "Refresh"
    self.ViewNoData.ImageIcon = "warning-sign"
    self.ViewNoData.MessageTitle = "Something went wrong"
    self.ViewNoData.MessageDetails = "We are sorry no data have been found, please try again"
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(self.TryAgainPlaces), for: .touchUpInside)
    }else{
    self.ViewNoData.ImageIcon = "place"
    self.ViewNoData.TextRefresh =  "Add new place"
    self.ViewNoData.MessageTitle = "No places added"
    self.ViewNoData.MessageDetails =  "You haven’t added any places yet, add new places now"
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(self.ActionAdd), for: .touchUpInside)
    }
    self.ViewNoData.isHidden = false
    }else {
    self.ViewNoData.isHidden = true
    }
    }
}
