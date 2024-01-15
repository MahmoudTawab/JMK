//
//  NotificationsSettingsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 01/08/2021.
//

import UIKit

class NotificationsSettingsVC: ViewController {

    var Settings : NotificationsSettings?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
        
        GetSettingsNotifications()
    }
    
    func SetUp() {
    
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(BackgroundView)
        BackgroundView.frame = CGRect(x: ControlX(15), y: ControlX(90), width: view.frame.width - ControlWidth(30), height: ControlWidth(140))
        
        BackgroundView.addSubview(Stack1)
        Stack1.frame = CGRect(x: ControlX(15), y: 0, width: BackgroundView.frame.width - ControlWidth(30), height: ControlWidth(70))
        AddBottomBorder(Stack1)
        
        BackgroundView.addSubview(Stack2)
        Stack2.frame = CGRect(x: ControlX(15), y: Stack1.frame.maxY, width: BackgroundView.frame.width - ControlWidth(30), height: ControlWidth(70))
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSettingsNotifications), for: .touchUpInside)
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
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        return View
    }()
    
    
    lazy var Stack1 : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ReceiveNotifications,ReceiveSwitch])
        Stack.axis = .horizontal
        Stack.distribution = .fill
        Stack.alignment = .center
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var ReceiveNotifications : UILabel = {
        let Label = UILabel()
        Label.text = "Receive notifications from the app"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ReceiveSwitch : UISwitch = {
        let Switch = UISwitch()
        Switch.onTintColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Switch.thumbTintColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Switch.addTarget(self, action: #selector(UpdateSettings), for: .valueChanged)
        return Switch
    }()
    
    
    lazy var Stack2 : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [EnableEmail,EnableEmailSwitch])
        Stack.axis = .horizontal
        Stack.distribution = .fill
        Stack.alignment = .center
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var EnableEmail : UILabel = {
        let Label = UILabel()
        Label.text = "Enable email notifications"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var EnableEmailSwitch : UISwitch = {
        let Switch = UISwitch()
        Switch.onTintColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Switch.thumbTintColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Switch.addTarget(self, action: #selector(UpdateSettings), for: .valueChanged)
        return Switch
    }()
    
    func AddBottomBorder(_ View:UIStackView) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: View.frame.size.height + ControlHeight(1), width: View.frame.size.width , height: ControlHeight(1))
    bottomLine.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.15).cgColor
    View.layer.addSublayer(bottomLine)
    }
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Notifications Settings"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    @objc func GetSettingsNotifications() {
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + GetNotificationsSettings)"

    guard let token = defaults.string(forKey: "JWT") else{return}
    guard let SqlId = LaunchScreen.User?.SqlId else{return}

    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                        "SqlId": SqlId,
                                        "Platform": "I"]
        
    self.ProgressHud.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.NoData(false)
    self.Settings = NotificationsSettings(dictionary: data)
        
    self.ReceiveSwitch.isOn = self.Settings?.NotificationsSta ?? false
    self.EnableEmailSwitch.isOn = self.Settings?.EmailSta ?? false
        
    self.ProgressHud.endRefreshing() {}
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    self.NoData(true)
    self.ProgressHud.endRefreshing(error, .error) {}
    }
    }
    }
    
    @objc func UpdateSettings() {
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + UpdateNotificationsSettings)"

    guard let token = defaults.string(forKey: "JWT") else{return}
    guard let SqlId = LaunchScreen.User?.SqlId else{return}

    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                    "SqlId": SqlId,
                                    "Platform": "I" ,
                                    "NotificationsSta": self.ReceiveSwitch.isOn,
                                    "EmailSta": self.EnableEmailSwitch.isOn]
            
    self.ProgressHud.beginRefreshing()
        
    PostAPI(api: api, token: token, parameters: parameters) { _ in

    self.ProgressHud.endRefreshing() {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    error != "" ? self.ProgressHud.endRefreshing(error, .error) {}:self.ProgressHud.endRefreshing() {}
    }
    }
    
    func NoData(_ boll:Bool) {
    ViewNoData.isHidden = boll ? false : true
    BackgroundView.isHidden = boll ? true : false
    }

}
