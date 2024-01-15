//
//  ChangePasswordVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 01/08/2021.
//

import UIKit
import FirebaseAuth

class ChangePasswordVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
        
    }
    
    func SetUp() {
    
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        let StackVertical = UIStackView(arrangedSubviews: [CurrentPasswordTF,NewPasswordTF,UpdatePassword])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(50)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.clipsToBounds = false
        StackVertical.backgroundColor = .clear
        StackVertical.frame = CGRect(x: ControlX(15), y: ControlX(95), width: view.frame.width - 30, height: ControlWidth(250))
        view.addSubview(StackVertical)
        
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

    
    lazy var CurrentPasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.SetUpIcon(LeftOrRight: false)
        tf.IconImage = UIImage(named: "visibility-1")
        tf.attributedPlaceholder = NSAttributedString(string: "Current Password", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.Icon.addTarget(self, action: #selector(ActionPassword), for: .touchUpInside)
        return tf
    }()
    
    @objc func ActionPassword() {
        if CurrentPasswordTF.IconImage == UIImage(named: "visibility-1") {
            CurrentPasswordTF.isSecureTextEntry = false
            CurrentPasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            CurrentPasswordTF.isSecureTextEntry = true
            CurrentPasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    lazy var NewPasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.SetUpIcon(LeftOrRight: false)
        tf.IconImage = UIImage(named: "visibility-1")
        tf.Icon.addTarget(self, action: #selector(ActionNewPassword), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "New Password", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionNewPassword() {
        if NewPasswordTF.IconImage == UIImage(named: "visibility-1") {
            NewPasswordTF.isSecureTextEntry = false
            NewPasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            NewPasswordTF.isSecureTextEntry = true
            NewPasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
            
    lazy var UpdatePassword : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Update Password", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionUpdatePassword), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionUpdatePassword() {
    if CurrentPasswordTF.NoError() && NewPasswordTF.NoError() && NewPasswordTF.NoErrorPassword() {
    ActionReset()
    }
    }
    
    
    @objc func ActionReset() {
    guard let OldPassword = self.CurrentPasswordTF.text else {return}
    guard let NewPassword = self.NewPasswordTF.text else {return}
    guard let email = Auth.auth().currentUser?.email else {return}
    let user = Auth.auth().currentUser
    
    ProgressHud.beginRefreshing()
    let credential = EmailAuthProvider.credential(withEmail: email, password: OldPassword)
    user?.reauthenticate(with: credential, completion: { (Auth, err) in
    if let err = err {
    self.ProgressHud.endRefreshing(err.localizedDescription, .error) {}
    return
    }
        
    user?.updatePassword(to: NewPassword, completion: { (err) in
    if let err = err {
    self.ProgressHud.endRefreshing(err.localizedDescription, .error) {}
    return
    }
        
    self.CurrentPasswordTF.text = ""
    self.NewPasswordTF.text = ""
    self.ProgressHud.endRefreshing("Success Update Password", .success) {}
    })
    })
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Change Password"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
}
