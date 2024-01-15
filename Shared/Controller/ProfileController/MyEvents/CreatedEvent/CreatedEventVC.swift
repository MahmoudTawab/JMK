//
//  CreatedEventVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 19/07/2021.
//

import UIKit

class CreatedEventVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var CartId : Int?
    var EventId = Int()
    var EventsName = String()
    var EventsDate = String()
    var CartData : CartDetils?
    private let CreatedEventID = "CellCreatedEvent"
    let Image = ["group31331","group31332","group31333","group31334","group31335","group31336","group31337","group31338","group31339"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
        
        TableView.tableHeaderView = HeaderView
        HeaderView.frame = CGRect(x: 0, y: 0, width: TableView.frame.width, height: ControlWidth(120))
        
        GetCartData()
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetCartData), for: .touchUpInside)
    }
    
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "\(EventsName)"
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
        
        View.addSubview(InviteGuestsView)
        NSLayoutConstraint.activate([
        InviteGuestsView.topAnchor.constraint(equalTo: View.topAnchor),
        InviteGuestsView.bottomAnchor.constraint(equalTo: View.bottomAnchor),
        InviteGuestsView.leftAnchor.constraint(equalTo: View.leftAnchor, constant: ControlY(15)),
        InviteGuestsView.rightAnchor.constraint(equalTo: View.rightAnchor, constant: ControlY(-15)),
        ])
        
        return View
    }()
    
    lazy var InviteGuestsView : UIView = {
    let View = UIView()
    View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
    View.translatesAutoresizingMaskIntoConstraints = false
        
    View.addSubview(LabelTitle)
    View.addSubview(InviteGuests)
    View.addSubview(ViewRating)
    View.addSubview(EventPurchases)
        
    NSLayoutConstraint.activate([
    LabelTitle.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlX(15)),
    LabelTitle.leadingAnchor.constraint(equalTo: View.leadingAnchor,constant: ControlX(15)),
    LabelTitle.widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: 1/2.3),
    LabelTitle.heightAnchor.constraint(equalToConstant: ControlWidth(42)),
            
    InviteGuests.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlX(15)),
    InviteGuests.trailingAnchor.constraint(equalTo: View.trailingAnchor,constant: ControlX(-15)),
    InviteGuests.widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: 1/2.5),
    InviteGuests.heightAnchor.constraint(equalTo: LabelTitle.heightAnchor),
                                    
    ViewRating.centerYAnchor.constraint(equalTo: LabelTitle.centerYAnchor),
    ViewRating.trailingAnchor.constraint(equalTo: View.trailingAnchor,constant: ControlX(-15)),
    ViewRating.widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: 1/2.5),
    ViewRating.heightAnchor.constraint(equalToConstant: ControlWidth(25)),
        
    EventPurchases.topAnchor.constraint(equalTo: LabelTitle.bottomAnchor ,constant: ControlX(15)),
    EventPurchases.trailingAnchor.constraint(equalTo: View.trailingAnchor),
    EventPurchases.leadingAnchor.constraint(equalTo: View.leadingAnchor),
    EventPurchases.bottomAnchor.constraint(equalTo: View.bottomAnchor)])
    return View
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.text = EventsDate
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var InviteGuests : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSaveChanges() {
    if InviteGuests.titleLabel?.text == "Invite Guests" {
    Present(ViewController: self, ToViewController: InviteGuestsVC())
    }else{
    let Feedback = FeedbackVC()
    Feedback.EvintId = self.EventId
    Present(ViewController: self, ToViewController: Feedback)
    }
    }
    
   
    lazy var ViewRating : UIRating = {
        let View = UIRating()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var EventPurchases : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(17))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.text = "Event Purchases"
        Label.backgroundColor = .white
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.register(CreatedEventCell.self, forCellReuseIdentifier: CreatedEventID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(15), right: 0)
        return tv
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartData?.Detils.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreatedEventCell(style: .subtitle, reuseIdentifier: CreatedEventID)
        SetUpCell(cell, indexPath)
        return cell
    }
    
    func SetUpCell(_ cell:CreatedEventCell ,_ indexPath:IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
//        cell.BackgroundImage.image = UIImage(named: Image[indexPath.row])
        
        cell.CellTrashHidden = true
        cell.CreatedEvent = self
        cell.CartDetils = CartData?.Detils[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let height = CartData?.Detils[indexPath.row].SubPackages.count {
    let height = (CGFloat(height) * ControlWidth(40)) + ControlWidth(105)
    return height
    }
    return 0
    }
    
    
    @objc func GetCartData() {
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetCartDetils)"
//           
//    guard let CartId = CartId else{return}
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = [ "AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "Platform": "I",
//                                    "SqlId": SqlId,
//                                    "CartId":CartId]
//            
    self.ProgressHud.beginRefreshing()
//            
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = [
            "WeddingPackages" : ["Id" : 1,"PackageName" : "Package Name"],
            "AttendeesTo" : 300.000,
            "BudgetTo" : 200.000,
            "Total" : 500.000,
            
            "CartDetils" : [
                ["PackageId" : "","PackagName" : "Packag Name 1","PackageTotal" : 20.000,
                 "SubPackages" : [["PackageId" : "","Name" : "Test Name 1","Count" : 5,"TotalPrice" : 3000],
                                  ["PackageId" : "","Name" : "Test Name 2","Count" : 2,"TotalPrice" : 1000],
                                  ["PackageId" : "","Name" : "Test Name 3","Count" : 7,"TotalPrice" : 4000],
                                  ["PackageId" : "","Name" : "Test Name 4","Count" : 1,"TotalPrice" : 2000],
                                  ["PackageId" : "","Name" : "Test Name 5","Count" : 8,"TotalPrice" : 7000],
                                  ["PackageId" : "","Name" : "Test Name 6","Count" : 4,"TotalPrice" : 3000]]],
                 
                 ["PackageId" : "","PackagName" : "Packag Name 2","PackageTotal" : 100.000,
                  "SubPackages" : [["PackageId" : "","Name" : "Test Name 1","Count" : 5,"TotalPrice" : 20.000],
                                   ["PackageId" : "","Name" : "Test Name 2","Count" : 2,"TotalPrice" : 10.000],
                                   ["PackageId" : "","Name" : "Test Name 3","Count" : 7,"TotalPrice" : 20.000],
                                   ["PackageId" : "","Name" : "Test Name 4","Count" : 1,"TotalPrice" : 30.000],
                                   ["PackageId" : "","Name" : "Test Name 5","Count" : 8,"TotalPrice" : 10.000],
                                   ["PackageId" : "","Name" : "Test Name 6","Count" : 4,"TotalPrice" : 10.000]]],
                  
                  ["PackageId" : "","PackagName" : "Packag Name 3","PackageTotal" : 80.000,
                   "SubPackages" : [["PackageId" : "","Name" : "Test Name 1","Count" : 5,"TotalPrice" : 30.000],
                                    ["PackageId" : "","Name" : "Test Name 2","Count" : 2,"TotalPrice" : 10.000],
                                    ["PackageId" : "","Name" : "Test Name 3","Count" : 7,"TotalPrice" : 5000],
                                    ["PackageId" : "","Name" : "Test Name 4","Count" : 1,"TotalPrice" : 15.000],
                                    ["PackageId" : "","Name" : "Test Name 5","Count" : 8,"TotalPrice" : 5000],
                                    ["PackageId" : "","Name" : "Test Name 6","Count" : 4,"TotalPrice" : 15.000]]],
                   
                   ["PackageId" : "","PackagName" : "Packag Name 4","PackageTotal" : 250.000,
                    "SubPackages" : [["PackageId" : "","Name" : "Test Name 1","Count" : 5,"TotalPrice" : 30.000],
                                     ["PackageId" : "","Name" : "Test Name 2","Count" : 2,"TotalPrice" : 10.000],
                                     ["PackageId" : "","Name" : "Test Name 3","Count" : 7,"TotalPrice" : 40.000],
                                     ["PackageId" : "","Name" : "Test Name 4","Count" : 1,"TotalPrice" : 60.000],
                                     ["PackageId" : "","Name" : "Test Name 5","Count" : 8,"TotalPrice" : 70.000],
                                     ["PackageId" : "","Name" : "Test Name 6","Count" : 4,"TotalPrice" : 90.000]]]
                
                ]
            
            ]
         as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            self.CartData = CartDetils(dictionary: data)
            self.TableView.AnimateTable()
            
            
            self.ProgressHud.endRefreshing() {}
            self.ViewNoData.isHidden = self.CartData?.Detils.count != 0 ? true:false
            self.TableView.isHidden = self.CartData?.Detils.count == 0 ? true:false
            self.TableView.tableHeaderView?.isHidden = self.CartData?.Detils.count == 0 ? true:false
            
        }
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ProgressHud.endRefreshing() {}
//    if error != "" {
//    self.TableView.isHidden = true
//    self.ViewNoData.isHidden = false
//    self.TableView.tableHeaderView?.isHidden = true
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetCartData)}
//    }
//    }
    }
}
