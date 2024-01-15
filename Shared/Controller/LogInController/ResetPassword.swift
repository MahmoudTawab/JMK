//
//  ResetPassword.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class ResetPassword: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
    }

    func SetUp() {

        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = view.bounds
        
        ViewScroll.addSubview(LogoImage)
        ViewScroll.addSubview(Dismiss)
        ViewScroll.addSubview(ContentView)
        ContentView.addSubview(ResetPasswordLabel)
        ContentView.addSubview(StackVertical)
        
        LogoImage.frame = CGRect(x: ControlX(125), y: ControlY(55), width: ControlWidth(125), height: ControlWidth(125))
            
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
            
        ContentView.frame = CGRect(x: ControlX(15), y: LogoImage.frame.maxY + ControlX(20), width: ControlWidth(345), height: ControlWidth(300))
           
        ResetPasswordLabel.frame = CGRect(x: ControlX(30), y: ControlY(15), width: ContentView.frame.width - ControlWidth(60), height: ControlWidth(100))
            
        StackVertical.frame =  CGRect(x: ControlX(30), y: ResetPasswordLabel.frame.maxY + ControlY(25), width: ContentView.frame.width - ControlWidth(60), height: ControlWidth(120))
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        return Scroll
    }()

    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 0.4)
        ImageView.image = UIImage(named: "group31203")
        return ImageView
    }()
    
    lazy var LogoImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "logo")
        ImageView.MotionEffect()
        return ImageView
    }()
    
    lazy var ContentView:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = ControlHeight(10)
        return View
    }()

    lazy var ResetPasswordLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributedString = NSMutableAttributedString(string: "Reset Password\n", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ])
        attributedString.append(NSAttributedString(string: "Enter your email in order to send you \na reset password link", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ]))
        Label.numberOfLines = 3
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var StackVertical : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [EmailTextField,ResetLink])
    Stack.axis = .vertical
    Stack.spacing = 25
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()

    
    lazy var EmailTextField : FloatingTF = {
        let tf = FloatingTF()
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var ResetLink : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Reset Link", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionResetLink), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionResetLink() {
    if EmailTextField.NoError() && EmailTextField.NoErrorEmail() {
        
    guard let email = EmailTextField.text else { return }
    ProgressHud.beginRefreshing()
    Auth.auth().sendPasswordReset(withEmail: email) { (err) in
    if let err = err {
    self.ProgressHud.endRefreshing(err.localizedDescription, .error) {}
    return
    }
        
    let Message = PasswordMessage()
    Message.Email = email
    Message.modalPresentationStyle = .overFullScreen
    Message.modalTransitionStyle = .crossDissolve
    self.present(Message, animated: true)
    self.ProgressHud.endRefreshing {self.EmailTextField.text = ""}
    }
    }
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
      self.navigationController?.popViewController(animated: true)
    }

}
