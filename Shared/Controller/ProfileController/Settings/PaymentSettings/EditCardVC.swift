//
//  EditCardVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 01/08/2021.
//

import UIKit
import FSCalendar

class EditCardVC: ViewController, FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
        
    }
    
    func SetUp() {
    
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
        
        ViewScroll.addSubview(BackgroundView)
        BackgroundView.frame = CGRect(x: ControlX(15), y: 0, width: ViewScroll.frame.width - ControlWidth(30), height: ViewScroll.frame.height - ControlWidth(150))
        
        let StackHorizontal = UIStackView(arrangedSubviews: [DefaultLabel,Switch])
        StackHorizontal.axis = .horizontal
        StackHorizontal.distribution = .fill
        StackHorizontal.alignment = .center
        StackHorizontal.backgroundColor = .clear
        
        let StackVertical = UIStackView(arrangedSubviews: [CardNameTF,CardNumberTF,ExpiryDateTF,CVVTF,StackHorizontal])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(30)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.clipsToBounds = false
        StackVertical.backgroundColor = .clear
        StackVertical.frame = CGRect(x: ControlX(15), y: ControlX(25), width: BackgroundView.frame.width - ControlWidth(30), height: BackgroundView.frame.height - ControlWidth(50))
        BackgroundView.addSubview(StackVertical)
    
        ViewScroll.addSubview(SaveChanges)
        SaveChanges.frame = CGRect(x: ControlX(15), y: BackgroundView.frame.maxY +  ControlWidth(30), width:  BackgroundView.frame.width , height: ControlWidth(50))
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height - ControlWidth(80))
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

    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        return View
    }()
    
    lazy var CardNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Card name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var CardNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.attributedPlaceholder = NSAttributedString(string: "Card number", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var ExpiryDateTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false

        tf.IconImage = UIImage(named: "calendar_(2)")
        tf.SetUpIcon(LeftOrRight: false, Width: ControlWidth(25), Height: ControlWidth(28))
        tf.attributedPlaceholder = NSAttributedString(string: "Expiry date", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        
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
        Calendar.appearance.weekdayTextColor = .white
        
        Calendar.scrollDirection = .horizontal
        
        Calendar.delegate = self
        Calendar.dataSource = self
        Calendar.placeholderType = .fillHeadTail
        
        tf.inputView = Calendar

        tf.Icon.addTarget(self, action: #selector(IconTouchUp), for: .touchUpInside)
        return tf
    }()
    
    @objc func IconTouchUp() {
    ExpiryDateTF.becomeFirstResponder()
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
    return Date()
    }
    
    var date = Date()
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    self.date = date
    let formatter = DateFormatter()
    formatter.dateFormat = "MM / dd"
    ExpiryDateTF.text = formatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
    if date < Date() {
    return UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)
    }else{
    return UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    }
    }
    
    lazy var CVVTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "CVV", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var DefaultLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Default Card"
        Label.font = UIFont(name: "Raleway-Raleway" ,size: ControlWidth(14))
        Label.textColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var Switch : UISwitch = {
        let Switch = UISwitch()
        Switch.isOn = true
        Switch.onTintColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Switch.thumbTintColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        return Switch
    }()
        
    lazy var SaveChanges : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Save Changes", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSaveChanges() {
    if CardNameTF.NoError() && CardNumberTF.NoError() && ExpiryDateTF.NoError() && CVVTF.NoError() {
    self.ProgressHud.beginRefreshing()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    self.ProgressHud.endRefreshing {
    self.navigationController?.popViewController(animated: true)
    }
    }
    }
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Edit Card"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
}


