//
//  CartVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 02/08/2021.
//

import UIKit
import FlagPhoneNumber
    
class CartVC: ViewController, UITableViewDelegate, UITableViewDataSource ,CreatedEventDelegate {
             
    private let CartID = "CellCart"
    var CartData : CartDetils?
    override func viewDidLoad() {
    super.viewDidLoad()
        
    SetUp()
    }
        
    func SetUp() {
    view.addSubview(Dismiss)
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
    view.addSubview(TableView)
    TableView.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))

    // FooterView
    TableView.tableFooterView = FooterView
    FooterView.frame = CGRect(x: 0, y: ControlX(5), width: TableView.frame.width, height: ControlWidth(80))
    
    FooterView.addSubview(SketchRequest)
    SketchRequest.frame = CGRect(x: ControlX(15), y: ControlX(10), width: FooterView.frame.width - ControlWidth(30), height: ControlWidth(50))
        
    // HeaderView
    TableView.tableHeaderView = HeaderView
    HeaderView.frame = CGRect(x: 0, y: ControlX(10), width: view.frame.width, height: ControlWidth(110))

    HeaderView.addSubview(ViewBar)
    ViewBar.frame = CGRect(x: 0, y: ControlX(5), width: view.frame.width, height: ControlWidth(50))

    HeaderView.addSubview(StackChange)
    StackChange.frame = CGRect(x: ControlX(15), y: ControlX(55), width: view.frame.width - ControlWidth(30), height: ControlWidth(50))
        
    GetCartData()
    ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetCartData), for: .touchUpInside)
    }

            
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Cart"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    // HeaderView
    lazy var HeaderView : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()
    

    lazy var ViewBar : TopViewBar = {
        let View = TopViewBar()
        View.backgroundColor = #colorLiteral(red: 0.9316878319, green: 0.9145766497, blue: 0.9075786471, alpha: 1)
        View.LabelTotal.text = "Total  :  "
        View.LabelBudget.text = "Budget  :  "
        return View
    }()
    
    lazy var StackChange : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [HeaderChangeLabel,HeaderChangeButton])
        Stack.axis = .horizontal
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var HeaderChangeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .left
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var HeaderChangeButton : UIButton = {
        let Button = UIButton()
        let style2 = NSMutableParagraphStyle()
        style2.alignment = .right
        let underlinedMessage = NSMutableAttributedString(string: "Change", attributes: [
        .font: UIFont(name: "Raleway-Regular" , size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
        .foregroundColor: UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1),
        .underlineStyle: NSUnderlineStyle.single.rawValue ,
        .paragraphStyle:style2
        ])
        Button.setAttributedTitle(underlinedMessage, for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionChange), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionChange() {
    Present(ViewController: self, ToViewController: EventType())
    }
    
    // FooterView
    lazy var FooterView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var SketchRequest : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Request Concept Venue Sketch", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionCheckout), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionCheckout() {
    Present(ViewController: self, ToViewController: VenueSketchVC())
    }
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.register(CreatedEventCell.self, forCellReuseIdentifier: CartID)
        return tv
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartData?.Detils.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreatedEventCell(style: .subtitle, reuseIdentifier: CartID)
        SetUpCell(cell, indexPath)
        return cell
    }
    
    func SetUpCell(_ cell:CreatedEventCell ,_ indexPath:IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.Delegate = self
        cell.Cart = self
        
        cell.CellTrashHidden = false
        cell.TrashButton.isHidden = false
        cell.BackgroundImage.isHidden = true
    
        cell.CartDetils = CartData?.Detils[indexPath.row]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func EditAction(cell: CreatedEventCell) {
        
    }
    
    var SelectIndex = IndexPath(row: 0, section: 0)
    func PackagesDelete(cell: CreatedEventCell) {
    if let index = TableView.indexPath(for: cell) {
    SelectIndex = index
    ShowMessageAlert("𝗶", "DELETE CART", "Are You Sure You Want to\nDelete this item of the Cart", false, self.ActionDelete, "Delete")
    }
    }
        
    @objc func ActionDelete() {
    guard let PackageId = CartData?.Detils[SelectIndex.item].PackageId else{return}
    Delete(PackageId)
    }
    
    func SubPackagesDelete(cell: CreatedEventCell) {
    if let index = TableView.indexPath(for: cell) {
    TableView.reloadRows(at: [index], with: .automatic)
    if CartData?.Detils[index.item].SubPackages.count == 0 {
    guard let PackageId = CartData?.Detils[index.item].PackageId else{return}
    Delete(PackageId)
    ViewNoData.isHidden = self.CartData?.Detils.count != 0 ? true:false
    TableView.isHidden = self.CartData?.Detils.count == 0 ? true:false
    TableView.tableHeaderView?.isHidden = self.CartData?.Detils.count == 0 ? true:false
    self.TableView.tableFooterView?.isHidden = self.CartData?.Detils.count == 0 ? true:false
    }
    }
    }
    
    
    func Delete(_ PackageId:String) {
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + DeletePackages)"
//
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let CartId = LaunchScreen.Cart?.CartId else{return}
//    guard let EvintId = LaunchScreen.Cart?.EvintId else{return}
//        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "Platform": "I",
//                                    "SqlId": SqlId,
//                                    "CartId":CartId,
//                                    "PackagesId": PackageId,
//                                    "EventId":EvintId]

    ProgressHud.beginRefreshing()
        
//    PostAPI(api: api, token: token, parameters: parameters) { String in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            if let index = self.CartData?.Detils.firstIndex(where: {$0.PackageId == PackageId})   {
                self.ProgressHud.endRefreshing() {}
                self.CartData?.Detils.remove(at: index)
                self.TableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .right)
            }
        }
        
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    error != "" ? self.ProgressHud.endRefreshing(error, .error) {}:self.ProgressHud.endRefreshing() {}
//    }
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
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let CartId = LaunchScreen.Cart?.CartId else{return}
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
            self.StackChangeShow(self.CartData?.WeddingPackages?.PackageName == nil ? false:true)
            self.ViewNoData.isHidden = self.CartData?.Detils.count != 0 ? true:false
            self.TableView.isHidden = self.CartData?.Detils.count == 0 ? true:false
            self.TableView.tableHeaderView?.isHidden = self.CartData?.Detils.count == 0 ? true:false
            self.TableView.tableFooterView?.isHidden = self.CartData?.Detils.count == 0 ? true:false
        }
        
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ProgressHud.endRefreshing() {}
//    if error != "" {
//    self.TableView.isHidden = true
//    self.ViewNoData.isHidden = false
//    self.TableView.tableHeaderView?.isHidden = true
//    self.TableView.tableFooterView?.isHidden = true
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetCartData)}
//    }
//    }
    }
    
    func StackChangeShow(_ Show:Bool) {
    UIView.animate(withDuration: 0.4) {
    self.HeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: Show == true ? ControlHeight(110):ControlHeight(70))
    self.StackChange.alpha = Show == true ? 1:0
    }
    self.ViewBar.Show()
    self.ViewBar.Total.text = "\(self.CartData?.Total ?? 0.0)"
    self.ViewBar.Budget.text = "\(self.CartData?.BudgetTo ?? 0.0)"
    self.HeaderChangeLabel.text = self.CartData?.WeddingPackages?.PackageName ?? ""
    }
}

