//
//  MyEventsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 19/07/2021.
//

import UIKit

class MyEventsVC: ViewController , UITableViewDelegate, UITableViewDataSource ,MyEventsDelegatePast ,MyEventsDelegateUpcoming {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
    
        LodMyEvents()
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.LodMyEvents), for: .touchUpInside)
    }
    
    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.alpha = 0.4
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "group31203")
        return ImageView
    }()
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "My Events"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
      self.navigationController?.popViewController(animated: true)
    }
    
    private let MyEventsPast = "CellPast"
    private let MyEventsUpcoming = "CellUpcoming"
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.register(MyEventsCellPast.self, forCellReuseIdentifier: MyEventsPast)
        tv.register(MyEventsCellUpcoming.self, forCellReuseIdentifier: MyEventsUpcoming)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
        return InProgress.count
        case 1:
        return UpcomingEvent.count
        case 2:
        return PastEvent.count
        default:
        return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    switch indexPath.section {
    case 0:
    let cell = tableView.dequeueReusableCell(withIdentifier: MyEventsUpcoming, for: indexPath) as! MyEventsCellUpcoming
        
    cell.UpcomingAndPastHeight?.constant = indexPath.row == 0 ? ControlWidth(40) : 0


    cell.Delegate = self
    cell.selectionStyle = .none
    cell.TrashButton.isHidden = false
    cell.StackProgress.isHidden = false
        
    cell.UpcomingAndPast.text = "In Progress"
    cell.LabelTitle.text = InProgress[indexPath.row].Title
    cell.SetProgressLabel(Float(InProgress[indexPath.row].CompletedRat ?? 0))
    cell.ProgressView.progress = Float(InProgress[indexPath.row].CompletedRat ?? 0) / 100
    cell.LabelDetails.text = InProgress[indexPath.row].StartDate?.Formatter().Formatter("d MMM,yyyy")

        
    return cell
    case 1:
    let cell = tableView.dequeueReusableCell(withIdentifier: MyEventsUpcoming, for: indexPath) as! MyEventsCellUpcoming
        
    cell.UpcomingAndPastHeight?.constant = indexPath.row == 0 ? ControlWidth(40) : 0

        
    cell.Delegate = self
    cell.selectionStyle = .none
    cell.TrashButton.isHidden = true
    cell.StackProgress.isHidden = true
        
    cell.UpcomingAndPast.text = "Upcoming"
    cell.LabelTitle.text = UpcomingEvent[indexPath.row].Title
    cell.LabelDetails.text = UpcomingEvent[indexPath.row].StartDate?.Formatter().Formatter("d MMM,yyyy")

    return cell
    case 2:
    let cell = tableView.dequeueReusableCell(withIdentifier: MyEventsPast, for: indexPath) as! MyEventsCellPast
      
    cell.UpcomingAndPastHeight?.constant = indexPath.row == 0 ? ControlWidth(40) : 0
        
    if PastEvent[indexPath.row].EventRate == 0 {
    cell.ViewRating.isHidden = true
    cell.AddFeedback.isHidden = false
    }else{
    cell.AddFeedback.isHidden = true
    cell.ViewRating.isHidden = false
    cell.ViewRating.SetRating = PastEvent[indexPath.row].EventRate ?? 0
    }
    
    cell.Delegate = self
    cell.selectionStyle = .none
    cell.LabelTitle.text = PastEvent[indexPath.row].Title
    cell.LabelDetails.text = PastEvent[indexPath.row].StartDate?.Formatter().Formatter("d MMM,yyyy")
    return cell
    default:
    return UITableViewCell()
    }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            
            return indexPath.row == 0 ? ControlWidth(170) : ControlWidth(130)
        case 1:
            
            return indexPath.row == 0 ? ControlWidth(130) : ControlWidth(90)
        case 2:
            
            return indexPath.row == 0 ? ControlWidth(170) : ControlWidth(130)
            
        default:
            return 0
        }
    }
    

    
    // Action MyEvents Cell Past
    func ActionView(cell:MyEventsCellPast) {
    if let indexPath = TableView.indexPath(for: cell) {
    if cell.AddFeedback.isHidden == true {
    let CreatedEvent = CreatedEventVC()
    CreatedEvent.InviteGuests.alpha = 0
    CreatedEvent.ViewRating.alpha = 1
    CreatedEvent.EventsName = PastEvent[indexPath.row].Title ?? ""
    CreatedEvent.ViewRating.SetRating = PastEvent[indexPath.row].EventRate ?? 0
    CreatedEvent.EventsDate = PastEvent[indexPath.row].StartDate?.Formatter().Formatter("d MMM,yyyy") ?? ""
    Present(ViewController: self, ToViewController: CreatedEvent)
    }else{
    let CreatedEvent = CreatedEventVC()
    CreatedEvent.ViewRating.alpha = 0
    CreatedEvent.InviteGuests.alpha = 1
    CreatedEvent.EventId = PastEvent[indexPath.row].Id ?? 0
    CreatedEvent.InviteGuests.setTitle("Add Feedback", for: .normal)
    CreatedEvent.EventsName = PastEvent[indexPath.row].Title ?? ""
    CreatedEvent.EventsDate = PastEvent[indexPath.row].StartDate?.Formatter().Formatter("d MMM,yyyy") ?? ""
    Present(ViewController: self, ToViewController: CreatedEvent)
    }
    }
    }
    
    func ActionAddFeedback(cell: MyEventsCellPast) {
    if let indexPath = TableView.indexPath(for: cell) {
    let Feedback = FeedbackVC()
    Feedback.EvintId = PastEvent[indexPath.row].Id
    Present(ViewController: self, ToViewController: Feedback)
    }
    }
    
    // Action MyEvents Cell Upcoming
    func TrashAction(cell: MyEventsCellUpcoming) {
    if let indexPath = TableView.indexPath(for: cell) {
        
    EventsIndexPath = indexPath
    EventsId = InProgress[indexPath.row].Id
    ShowMessageAlert("𝗶", "DELETE EVENTS", "Are You Sure You Want to\nDelete this Event", false, self.ActionDelete, "Delete")
    }
    }
    
    var EventsId : Int?
    var EventsIndexPath = IndexPath()
    @objc func ActionDelete() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + DeleteEvent)"
//
//    guard let id = EventsId else{return}
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                     "SqlId": SqlId,
//                                     "EventId":"\(id)"]

     ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { String in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.TableView.beginUpdates()
            self.InProgress.remove(at: self.EventsIndexPath.row)
            self.TableView.deleteRows(at: [IndexPath(item: self.EventsIndexPath.row, section: 0)], with: .right)
            self.TableView.endUpdates()
            self.ProgressHud.endRefreshing() {}
        }
    
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    error != "" ? self.ProgressHud.endRefreshing(error, .error) {}:self.ProgressHud.endRefreshing() {}
//    }
    }
    
    func ActionView(cell: MyEventsCellUpcoming) {
    if let indexPath = TableView.indexPath(for: cell) {
    let CreatedEvent = CreatedEventVC()
    CreatedEvent.InviteGuests.alpha = 1
    CreatedEvent.ViewRating.alpha = 0
    CreatedEvent.InviteGuests.setTitle("Invite Guests", for: .normal)
        
    if indexPath.section == 0 {
    CreatedEvent.CartId = InProgress[indexPath.row].CartId ?? 0
    CreatedEvent.EventsName = InProgress[indexPath.row].Title ?? ""
    CreatedEvent.EventsDate = InProgress[indexPath.row].StartDate?.Formatter().Formatter("d MMM,yyyy") ?? ""
    }else{
    CreatedEvent.CartId = InProgress[indexPath.row].CartId ?? 0
    CreatedEvent.EventsName = UpcomingEvent[indexPath.row].Title ?? ""
    CreatedEvent.EventsDate = UpcomingEvent[indexPath.row].StartDate?.Formatter().Formatter("d MMM,yyyy") ?? ""
    }
        
    Present(ViewController: self, ToViewController: CreatedEvent)
    }
    }
    
    var PastEvent = [AllEvent]()
    var InProgress = [AllEvent]()
    var UpcomingEvent = [AllEvent]()
    var ObjectAllEvent:AllEventObject?
    @objc func LodMyEvents() {
        
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + GetMyEvents)"
//        
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                      "SqlId": SqlId]

    self.ProgressHud.beginRefreshing()

//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
    
        let data = [
            "InProgress":[["Id" : 1,"Title" : "Test InProgress 1","EventRate" : 4,"CompletedRat" : 7,"StartDate" : "2024-01-02T10:30:00","CartId" : 1],
                          ["Id" : 2,"Title" : "Test InProgress 2","EventRate" : 3,"CompletedRat" : 8,"StartDate" : "2024-01-03T10:30:00","CartId" : 1],
                          ["Id" : 3,"Title" : "Test InProgress 3","EventRate" : 5,"CompletedRat" : 6,"StartDate" : "2024-01-04T10:30:00","CartId" : 1],
                          ["Id" : 4,"Title" : "Test InProgress 4","EventRate" : 5,"CompletedRat" : 4,"StartDate" : "2024-01-05T10:30:00","CartId" : 1]],
            
            "Upcoming":[["Id" : 1,"Title" : "Test Upcoming 1","EventRate" : 4,"CompletedRat" : 3,"StartDate" : "2024-01-08T06:30:00","CartId" : 1],
                          ["Id" : 2,"Title" : "Test Upcoming 2","EventRate" : 3,"CompletedRat" : 2,"StartDate" : "2024-01-08T09:30:00","CartId" : 1],
                          ["Id" : 3,"Title" : "Test Upcoming 3","EventRate" : 5,"CompletedRat" : 3,"StartDate" : "2024-01-08T12:30:00","CartId" : 1],
                        ["Id" : 4,"Title" : "Test Upcoming 4","EventRate" : 2,"CompletedRat" : 4,"StartDate" : "2024-01-09T11:30:00","CartId" : 1]],
            
            "Past":[["Id" : 1,"Title" : "Test Past 1","EventRate" : 4,"CompletedRat" : 3,"StartDate" : "2023-12-06T12:30:00","CartId" : 1],
                          ["Id" : 2,"Title" : "Test Past 2","EventRate" : 0,"CompletedRat" : 2,"StartDate" : "2023-11-09T12:30:00","CartId" : 1],
                          ["Id" : 3,"Title" : "Test Past 3","EventRate" : 5,"CompletedRat" : 3,"StartDate" : "2023-12-10T12:30:00","CartId" : 1],
                         ["Id" : 4,"Title" : "Test Past 4","EventRate" : 5,"CompletedRat" : 4,"StartDate" : "2023-10-11T12:30:00","CartId" : 1]]
        
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.PastEvent.removeAll()
            self.InProgress.removeAll()
            self.UpcomingEvent.removeAll()
            self.ObjectAllEvent = AllEventObject(dictionary: data)
            
            if let Progress = self.ObjectAllEvent?.InProgress {
                for item in Progress {
                    self.InProgress.append(item)
                }
            }
            
            if let Upcoming = self.ObjectAllEvent?.Upcoming {
                for item in Upcoming {
                    self.UpcomingEvent.append(item)
                }
            }
            
            if let Past = self.ObjectAllEvent?.Past {
                for item in Past {
                    self.PastEvent.append(item)
                }
            }
            
            self.SetUpNoData()
            self.ProgressHud.endRefreshing() {self.TableView.AnimateTable()}
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.SetUpNoData()
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.LodMyEvents)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }

    }
    
    func SetUpNoData() {
        if self.PastEvent.count == 0 && self.InProgress.count == 0 && self.UpcomingEvent.count == 0 {
        self.ViewNoData.isHidden = false
        }else{
        self.ViewNoData.isHidden = true
        }
    }
}
