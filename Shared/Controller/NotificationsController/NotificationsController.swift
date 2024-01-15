//
//  NotificationsController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 11/07/2021.
//

import UIKit

class NotificationsController: ViewController, UITableViewDelegate, UITableViewDataSource ,NotificationsDelegate ,SwipeTableViewCellDelegate {
    
    var NotificationsID = "CellNotifications"
    var TitleSection = [String]()
    
    var Data = [Notifications]()
    var Filter = [[Notifications]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 0.9724199181, green: 0.9724199181, blue: 0.9724199181, alpha: 1)
    SetUp()
                 
    self.ProgressHud.beginRefreshing()
    }
    
    
    func SetUp() {
    view.addSubview(NotificationsLabel)
    NotificationsLabel.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlWidth(30), height:ControlHeight(20))
        
    view.addSubview(TableView)
    TableView.frame = CGRect(x: 0, y: NotificationsLabel.frame.maxY + ControlX(20), width: view.frame.width , height: view.frame.height - ControlWidth(90))
        
    NotificationCenter.default.addObserver(self, selector: #selector(LodNotifications), name: AppDelegate.PostNotification , object: nil)

    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    TableView.refreshControl = refreshControl

    LodNotifications()
    ViewNoData.RefreshButton.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
    }
    
    
    @objc func refresh() {
    skip = 0
    ProgressHud.beginRefreshing()
    LodNotifications(removeAll: true)
    }
    
    
    lazy var NotificationsLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Notifications"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()

    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.alwaysBounceVertical = false
        tv.backgroundColor = #colorLiteral(red: 0.9724199181, green: 0.9724199181, blue: 0.9724199181, alpha: 1)
        tv.separatorStyle = .none
        tv.indicatorStyle = .black
        tv.register(NotificationsCell.self, forCellReuseIdentifier: NotificationsID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(10), right: 0)
        return tv
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Filter.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Filter[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: ControlHeight(30)))
        view.backgroundColor = .clear
        view.layer.masksToBounds = false
        view.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 5, height: -5)

        let Button = UIButton(frame: CGRect(x:ControlX(15), y: 0, width: tableView.frame.width - ControlWidth(30), height: ControlWidth(30)))
        Button.backgroundColor = .white
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.setTitle(TitleSection[section], for: .normal)
        Button.contentHorizontalAlignment = .left
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlX(15), bottom: 0, right: ControlX(15))
        view.addSubview(Button)
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return ControlWidth(30)
    }

    func tableView(_ tableView: UITableView,  viewForFooterInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: ControlWidth(20)))
    view.backgroundColor = .clear
    return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return ControlWidth(20)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsID, for: indexPath) as! NotificationsCell
        
        tableView.rowHeight = ControlWidth(80)
        cell.selectionStyle = .none
        cell.Delegate = self
        cell.delegate = self
        
        cell.LabelTitle.text = Filter[indexPath.section][indexPath.item].Title
        cell.LabelDate.text = Filter[indexPath.section][indexPath.item].Date?.Formatter().timeAgoDisplay()
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == totalRows - 1 {
        cell.ViewLine.isHidden = true
        }else{
        cell.ViewLine.isHidden = false
        }
        
        return cell
    }
    
    var SelectIndex = IndexPath(item: 0, section: 0)
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }
    let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
        
    self.SelectIndex = indexPath
    ShowMessageAlert("𝗶", "DELETE NOTIFICATIONS", "Are You Sure You Want to\nDelete this Notifications", false, self.NotificationsDelete, "Delete")
    }

    deleteAction.image = UIImage(named: "Group 31872")
    deleteAction.backgroundColor = #colorLiteral(red: 0.4871429205, green: 0.4557067752, blue: 0.4395173192, alpha: 1)
    return [deleteAction]
    }
    
    var defaultOptions = SwipeOptions()
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = orientation == .right ? .selection : .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        options.backgroundColor = .white
        return options
    }

    func ActionView(cell: NotificationsCell) {
    if let indexPath = TableView.indexPath(for: cell) {
    guard let Details = Filter[indexPath.section][indexPath.item].Details else { return }
    let Announcement = AnnouncementVC()
    Announcement.modalPresentationStyle = .overFullScreen
    Announcement.modalTransitionStyle = .crossDissolve
    Announcement.TitleText = "Announcement"
    Announcement.MessageText = Details
    present(Announcement, animated: true)
    }
    }
    
    @objc func NotificationsDelete() {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let token = defaults.string(forKey: "JWT") else{return}
    let api = "\(url + DeleteNotifications)"

    guard let id = Filter[SelectIndex.section][SelectIndex.item].Id else{return}
    guard let SqlId = LaunchScreen.User?.SqlId else{return}

    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                     "Platform": "I",
                                     "SqlId": SqlId,
                                     "NotificationId":"\(id)"]

    ProgressHud.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { String in
        
        if let index = self.Data.firstIndex(where: {$0.Id == self.Filter[self.SelectIndex.section][self.SelectIndex.item].Id})   {
        self.TableView.TableAnimate()
        self.TableView.beginUpdates()
        self.Data.remove(at: index)
        self.FilterData()
        self.TableView.deleteRows(at: [IndexPath(item: self.SelectIndex.item, section: self.SelectIndex.section)], with: .none)
        self.TableView.endUpdates()
        self.ProgressHud.endRefreshing() {}
    }
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    error != "" ? self.ProgressHud.endRefreshing(error, .error) {}:self.ProgressHud.endRefreshing() {}
    }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {        
//    if !fetchingMore && tableView.isDragging {
//    tableView.addLoading(indexPath) {
//    self.SetUpIndicatorView()
//    self.LodNotifications()
//        
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    UIView.animate(withDuration: 0.5) {
//    self.TableView.beginUpdates()
//    self.TableView.tableFooterView = nil
//    self.TableView.endUpdates()
//        
//    self.IfNoData()
//    }
//    }
//        
//    }
//    }
    }
    
    func SetUpIndicatorView() {
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: TableView.frame.width, height: ControlWidth(90)))
    let aiv = UIActivityIndicatorView(style: .whiteLarge)
    aiv.hidesWhenStopped = true
    aiv.isHidden = true
    aiv.color = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
    aiv.startAnimating()
    aiv.translatesAutoresizingMaskIntoConstraints = false

    customView.addSubview(aiv)
    aiv.centerYAnchor.constraint(equalTo: customView.centerYAnchor).isActive = true
    aiv.centerXAnchor.constraint(equalTo: customView.centerXAnchor).isActive = true
    aiv.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    aiv.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true

    TableView.tableFooterView = customView
    }
    
    var skip = 0
    var fetchingMore = false
    @objc func LodNotifications(removeAll:Bool = false) {

        fetchingMore = true
//        guard let url = defaults.string(forKey: "API") else{return}
//        guard let token = defaults.string(forKey: "JWT") else{return}
//        let api = "\(url + GetNotifications)"
//            
//        guard let SqlId = LaunchScreen.User?.SqlId else{return}
//        let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                         "Platform": "I",
//                                         "SqlId": SqlId,
//                                         "Take":"20",
//                                         "Skip":"\(skip)"]
//        
//        PostAPI(api: api, token: token, parameters: parameters) { _ in
//        } DictionaryData: { _ in
//        } ArrayOfDictionary: { data in
    
        let data = [
    ["Id": 1,"Title": "Test Title 1","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-10T03:10:00"],
    ["Id": 1,"Title": "Test Title 2","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-10T02:30:00"],
    ["Id": 1,"Title": "Test Title 3","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-10T01:00:00"],
        
        
    ["Id": 1,"Title": "Test Title 1","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-09T01:00:00"],
    ["Id": 1,"Title": "Test Title 2","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-09T02:10:00"],
    ["Id": 1,"Title": "Test Title 3","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-09T02:30:00"],
    
    ["Id": 1,"Title": "Test Title 1","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-01T10:00:00"],
    ["Id": 1,"Title": "Test Title 2","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-02T12:30:00"],
    ["Id": 1,"Title": "Test Title 3","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-03T09:30:00"],
    
    ["Id": 1,"Title": "Test Title 1","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-04T10:00:00"],
    ["Id": 1,"Title": "Test Title 2","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-05T12:30:00"],
    ["Id": 1,"Title": "Test Title 3","Details": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-06T09:30:00"],
    ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if removeAll {
                self.Data.removeAll()
                self.TableView.TableAnimate()
            }
            
            for item in data {
                self.Data.append(Notifications(dictionary: item))
                
                self.skip += 1
                self.fetchingMore = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.FilterData()
                self.TableView.refreshControl?.endRefreshing()
                self.ProgressHud.endRefreshing() {}
            }
            
            self.IfNoData()
            
        }
//        } Err: { error in
//        if error == "No Content" && self.Data.count != 0 {
//        self.IfNoData()
//        self.ProgressHud.endRefreshing() {}
//        self.TableView.refreshControl?.endRefreshing()
//        return
//        }
//        if error != "" {
//        self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.refresh)}
//        }
//        }
        
    }
    
    func FilterData() {
        self.Filter.removeAll()
        let Today = self.Data.filter{($0.Date?.Formatter().dayDifference() == "Today")}
        let Yesterday = self.Data.filter{($0.Date?.Formatter().dayDifference() == "Yesterday")}
        let Earlier = self.Data.filter{($0.Date?.Formatter().dayDifference() == "Earlier")}
            
        if Today.count != 0 {
        self.Filter.append(Today)
        self.TitleSection.append("Today")
        }
            
        if Yesterday.count != 0 {
        self.Filter.append(Yesterday)
        self.TitleSection.append("Yesterday")
        }
            
        if Earlier.count != 0 {
        self.Filter.append(Earlier)
        self.TitleSection.append("Earlier")
        }

        self.TableView.reloadData()
    }
    
    
    func IfNoData() {
        if self.Data.count == 0 {
        self.ViewNoData.isHidden = false
        }else{
        self.ViewNoData.isHidden = true
        }
    }
}
