//
//  AddCalendarVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 05/08/2021.
//

import UIKit
import FSCalendar

class AddCalendarVC: ViewController, FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
    }
    
    func SetUp() {
    
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
        
        let StackVertical = UIStackView(arrangedSubviews: [OccasionNameTF,OccasionDateTF,OccasionDescriptionTF,AddOccasion])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlHeight(45)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.clipsToBounds = false
        StackVertical.backgroundColor = .clear
        StackVertical.frame = CGRect(x: ControlX(20), y: ControlY(20), width: ViewScroll.frame.width - ControlWidth(40), height: ControlWidth(350))
        ViewScroll.addSubview(StackVertical)

    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height - ControlHeight(80))
        return Scroll
    }()

    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.alpha = 0.4
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "group31203")
        return ImageView
    }()
    
    lazy var OccasionNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Occasion Name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var OccasionDateTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.IconImage = UIImage(named: "calendar")
        tf.SetUpIcon(LeftOrRight: false, Width: ControlWidth(25), Height: ControlWidth(30))
        tf.clearButtonMode = .never
        tf.attributedPlaceholder = NSAttributedString(string: "Occasion Date", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        
        let screenWidth = UIScreen.main.bounds.width
        let Calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: ControlWidth(216)))
        Calendar.backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 1.0)
        
        Calendar.appearance.headerTitleFont = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Calendar.appearance.headerTitleColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        
        Calendar.appearance.todayColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Calendar.appearance.subtitleTodayColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    
        Calendar.appearance.titleFont = UIFont(name: "Raleway-Regular" ,size: ControlWidth(11))
        Calendar.appearance.titleDefaultColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        
        Calendar.appearance.weekdayFont = UIFont(name: "Raleway-Regular" ,size: ControlWidth(12))
        Calendar.appearance.weekdayTextColor = .black
        
        Calendar.scrollDirection = .horizontal
        
        Calendar.delegate = self
        Calendar.dataSource = self
        Calendar.placeholderType = .fillHeadTail
        
        tf.inputView = Calendar

        tf.Icon.addTarget(self, action: #selector(IconTouchUp), for: .touchUpInside)
        return tf
    }()
    
    @objc func IconTouchUp() {
    OccasionDateTF.becomeFirstResponder()
    }
    
    var date = Date()
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    self.date = date
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    OccasionDateTF.text = formatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
    if date < Date() {
    return UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)
    }else{
    return UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    }
    }

    
    lazy var OccasionDescriptionTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        let attributedString = NSMutableAttributedString(string: "Occasion Description  ", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)
        ])
        attributedString.append(NSAttributedString(string: "(Optional)", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.5)
        ]))
        tf.attributedPlaceholder = attributedString
        return tf
    }()
    
    lazy var AddOccasion : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Add Occasion", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddOccasion), for: .touchUpInside)
        return Button
    }()
    
    
    static let AddCalendar = NSNotification.Name(rawValue: "AddCalendar")
    @objc func ActionAddOccasion() {
    if OccasionNameTF.NoError() && OccasionDateTF.NoError() && OccasionDescriptionTF.NoError() {
    guard let Name = OccasionNameTF.text else { return }
    guard let Date = OccasionDateTF.text else { return }
    guard let Description = OccasionDescriptionTF.text else { return }

    
    guard let url = defaults.string(forKey: "API") else{return}
    guard let token = defaults.string(forKey: "JWT") else{return}
    let api = "\(url + PhoneAddCalendar)"
                    
    guard let SqlId = LaunchScreen.User?.SqlId else{return}

    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                         "Platform": "I",
                                         "SqlId": SqlId,
                                         "OccasionName":Name,
                                         "EvintDate" : Date,
                                         "Description":Description]
        
    ProgressHud.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.ProgressHud.endRefreshing() {}
    NotificationCenter.default.post(name: AddCalendarVC.AddCalendar, object: nil)
    self.self.navigationController?.popViewController(animated: true)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.TryAgainAddCalendar)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }
    }
    }
    }
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Add to Calendar"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func TryAgainAddCalendar() {
    ActionAddOccasion()
    }
}
