//
//  SettingsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 01/08/2021.
//

import UIKit

class SettingsVC: ViewController, SettingsDelegate {
    
    let CellId = "CellId"
    var SettingsImageArray = ["ChangePassword","Payment","setting","Terms","PrivacyPolicy"]
    var SettingsTitleArray = ["Change Password","Payment Settings","Notification Settings","Terms of Service","Privacy Policy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUp()
        TableView.AnimateTable()
    }
    
    func SetUp() {
        
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: ControlX(15), y: ControlX(90), width: view.frame.width - 30, height: view.frame.height - ControlWidth(90))
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Settings"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
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

    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.alwaysBounceVertical = true
        tv.register(SettingsCell.self, forCellReuseIdentifier: CellId)
        return tv
    }()

}

extension SettingsVC : UITableViewDelegate , UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! SettingsCell
        cell.Delegate = self
        cell.selectionStyle = .none
        cell.ProfileLabel.text = SettingsTitleArray[indexPath.row]
        cell.ProfileImage.image = UIImage(named: SettingsImageArray[indexPath.row])
        
        if indexPath.row == 0 {
        if defaults.string(forKey: "SocialLogin") == "E" {
        tableView.rowHeight = ControlWidth(50)
        }else{
        tableView.rowHeight = 0
        }
        }else{
        tableView.rowHeight = ControlWidth(50)
        }
        return cell
    }

    func ActionView(cell:SettingsCell) {
    if let indexPath = TableView.indexPath(for: cell) {
        switch indexPath.row {
        case 0:
        Present(ViewController: self, ToViewController: ChangePasswordVC())
        case 1:
        Present(ViewController: self,ToViewController: PaymentSettingsVC())
        case 2:
        Present(ViewController: self,ToViewController: NotificationsSettingsVC())
        case 3:
        Present(ViewController: self,ToViewController: TermsOfServiceVC())
        case 4:
        Present(ViewController: self,ToViewController: PrivacyPolicyVC())
        default: break}
    }
    }
    
    
}
