//
//  CalendarController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 11/07/2021.
//

import UIKit
import FSCalendar

class CalendarController: ViewController, FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance,  UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout  {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(CalendarLabel)
        view.addSubview(CollectionView)
    
        SetUp()
        ReloadAdd()
        ActionNext()
    }
    
    func SetUp() {
    
    CalendarLabel.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlWidth(30), height: ControlHeight(20))
        
    CollectionView.frame = CGRect(x: ControlX(15), y: ControlX(80), width: view.frame.width - ControlWidth(30), height: view.frame.height - ControlWidth(150))
        
    NotificationCenter.default.addObserver(self, selector: #selector(ReloadAdd), name: AddCalendarVC.AddCalendar , object: nil)
            
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    CollectionView.refreshControl = refreshControl

    }
                    
    @objc func refresh() {
    ReloadAdd()
    }
        
    
    lazy var CalendarLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Calendar"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    let CalendarID = "CellCalendar"
    var CalendarData = [Calendar]()
    lazy var CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlWidth(20)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsVerticalScrollIndicator = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        vc.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarID)
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ViewHeader")
        return vc
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarFilter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarID, for: indexPath) as! CalendarCell
        cell.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)

        cell.IconImage.image = UIImage(named: "group_26486")
        cell.LabelTitle.text = CalendarFilter[indexPath.item].Title
        cell.LabelDetails.text = CalendarFilter[indexPath.item].Description
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CalendarView.select(CalendarFilter[indexPath.row].Date?.Formatter(), scrollToDate: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: ControlWidth(80))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ViewHeader", for: indexPath)
    headerView.backgroundColor = UIColor.clear
    headerView.addSubview(CalendarView)
    CalendarView.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height - ControlWidth(20))
        
    CalendarView.addSubview(NextMonth)
    CalendarView.addSubview(PreviousMonth)
    NextMonth.frame = CGRect(x: CalendarView.frame.maxX - ControlWidth(30), y: ControlWidth(3), width: ControlWidth(30), height: ControlWidth(30))
    PreviousMonth.frame = CGRect(x: 0, y: ControlWidth(3), width: ControlWidth(30), height: ControlWidth(30))
    return headerView

    case UICollectionView.elementKindSectionFooter:
    let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath)
    footerView.backgroundColor = UIColor.clear
    footerView.addSubview(AddToCalendar)
    AddToCalendar.frame = CGRect(x: 0, y: ControlY(20), width: footerView.frame.width, height: footerView.frame.height - ControlWidth(20))
    return footerView
    default:
    fatalError("Unexpected element kind")
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: ControlWidth(392))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: ControlWidth(70))
    }
    
    lazy var CalendarView : FSCalendar = {
        let Calendar = FSCalendar()
        Calendar.delegate = self
        Calendar.dataSource = self
        Calendar.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        
        Calendar.appearance.headerTitleFont = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Calendar.appearance.headerMinimumDissolvedAlpha = 0
        Calendar.appearance.headerTitleColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        
        Calendar.appearance.todayColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Calendar.appearance.subtitleTodayColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        
        Calendar.appearance.borderRadius = 0
        
        Calendar.appearance.titleFont = UIFont(name: "Raleway-Regular" ,size: ControlWidth(12))
        Calendar.appearance.titleDefaultColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        
        Calendar.appearance.weekdayFont = UIFont(name: "Raleway-Regular" ,size: ControlWidth(12))
        Calendar.appearance.weekdayTextColor = .black
        
        Calendar.scrollDirection = .horizontal

        Calendar.appearance.eventOffset = CGPoint(x: 0, y: ControlY(2))
    
//        Calendar.locale = Locale(identifier: "ar")
        return Calendar
    }()
    
    var CalendarFilter = [Calendar]()
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let TodayRows = CalendarData.filter{($0.Date?.Formatter().Formatter() ==  date.Formatter())}
        
    CalendarFilter = TodayRows
    self.CollectionView.reloadData()
    }
        
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    let TodayRows = CalendarData.filter{($0.Date?.Formatter().Formatter() == date.Formatter())}
    if TodayRows.count < 3 {
    return TodayRows.count
    }else if TodayRows.count >= 3 {
    return 3
    }else{
    return 0
    }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
//    if date < Date() {
//    return [UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)]
//    }else {
//    return [UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)]
//    }
    return [UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)]
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
//    if date < Date() {
//    return [UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)]
//    }else {
//    return [UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)]
//    }
    return [UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)]
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
    if date < Date() {
    return UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)
    }else{
    return UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    }
    }
    
    lazy var NextMonth : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle(">", for: .normal)
        Button.titleLabel?.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(20))
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.backgroundColor = .clear
        Button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionNext()  {
    if let date = dateByAddingMonths(dMonths: 1, currentDate: CalendarView.currentPage) {
    CalendarView.setCurrentPage(date, animated: true)
    }
    }
    
    lazy var PreviousMonth : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("<", for: .normal)
        Button.titleLabel?.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(20))
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.backgroundColor = .clear
        Button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        Button.addTarget(self, action: #selector(ActionPrevious), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionPrevious()  {
    if let date = self.dateBySubtractingMonths(dMonths: 1, currentDate: CalendarView.currentPage) {
    CalendarView.setCurrentPage(date, animated: true)
    }
    }

    func dateBySubtractingMonths(dMonths: Int, currentDate: Date) -> Date? {
    return dateByAddingMonths(dMonths: -dMonths, currentDate: currentDate)
    }
    
    func dateByAddingMonths(dMonths: Int, currentDate: Date) -> Date? {
    var dateComponent = DateComponents()
    dateComponent.month = dMonths
    let newDate = NSCalendar.current.date(byAdding: dateComponent, to: currentDate, wrappingComponents: true)
    return newDate
    }

    
    lazy var AddToCalendar : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Add to Calendar", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddCalendar), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionAddCalendar() {
//    if defaults.string(forKey: "JWT") == nil {
//    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
//    }else{
    Present(ViewController: self, ToViewController: AddCalendarVC())
//    }
    }
    
    @objc func ReloadAdd() {
        
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + GetCalendarEvent)"
//            
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//                        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                             "Platform": "I",
//                                             "SqlId": SqlId]
       
    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in

        let data = [["Id": 1,"Title": "Test Title 1","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-01-08T10:00:00"],
        ["Id": 1,"Title": "Test Title 2","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-02-08T10:00:00"],
        ["Id": 1,"Title": "Test Title 3","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-02-08T10:00:00"],
        ["Id": 1,"Title": "Test Title 2","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-02-07T12:30:00"],
        ["Id": 1,"Title": "Test Title 2","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-02-07T12:30:00"],
        ["Id": 1,"Title": "Test Title 3","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-02-10T09:30:00"],
        
        ["Id": 1,"Title": "Test Title 1","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-03-10T10:00:00"],
        ["Id": 1,"Title": "Test Title 2","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-03-12T12:30:00"],
        ["Id": 1,"Title": "Test Title 3","Description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Date" : "2024-03-9T09:30:00"]]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.CalendarData.removeAll()
            self.CollectionView.reloadData()
            self.CalendarView.reloadData()
            
            for item in data {
                self.CalendarData.append(Calendar(dictionary: item))
                self.CollectionView.reloadData()
                self.CalendarView.reloadData()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let select = self.CalendarFilter.last {
                    self.CalendarView.select(select.Date?.Formatter(), scrollToDate: true)
                }
                
                self.IfTodayIsNotEmpty()
                self.ProgressHud.endRefreshing() {}
                self.CollectionView.refreshControl?.endRefreshing()
            }
        }
        
        
//    } Err: { error in
//    self.ProgressHud.endRefreshing() {}
//    self.CollectionView.refreshControl?.endRefreshing()
//             
//    if error != "" && error != "No Content" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ReloadAdd)}
//    }
//        
//    } 
    }
    
    func IfTodayIsNotEmpty() {
    let TodayRows = CalendarData.filter{($0.Date?.Formatter().Formatter() ==  Date().Formatter())}
    CalendarFilter = TodayRows
    self.CollectionView.reloadData()
    }
    
}


extension NSDate: Comparable {
    static public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs === rhs || lhs.compare(rhs as Date) == .orderedSame
    }

    static public func <(lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.compare(rhs as Date) == .orderedAscending
    }
}
