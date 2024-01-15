//
//  PasswordMessage.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit

class PasswordMessage: UIViewController {

    var Email = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8039083053)
        
        ViewPop.frame = CGRect(x: ControlX(15), y: view.center.y - ControlWidth(200),width: ControlWidth(345),height: ControlWidth(400))
        view.addSubview(ViewPop)
        
        MailImage.frame = CGRect(x: ControlX(110), y: ControlX(30), width: ControlWidth(155), height: ControlWidth(125))
        ViewPop.addSubview(MailImage)
        
        Message.frame = CGRect(x: ControlX(20), y: MailImage.frame.maxY + ControlX(35), width: ControlWidth(305), height: ControlWidth(90))
        ViewPop.addSubview(Message)
        
        let StackHorizontal = UIStackView(arrangedSubviews: [ButtonBack,OpenEmail])
        StackHorizontal.axis = .horizontal
        StackHorizontal.spacing = ControlHeight(10)
        StackHorizontal.distribution = .fillEqually
        StackHorizontal.alignment = .fill
        StackHorizontal.backgroundColor = .clear
        ViewPop.addSubview(StackHorizontal)
        StackHorizontal.frame = CGRect(x: ControlX(20), y: Message.frame.maxY + ControlX(35), width: ControlWidth(305), height: ControlWidth(50))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ViewPop.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
        self.ViewPop.transform = .identity
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.5, animations: {
    self.ViewPop.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }) { (End) in
    self.ViewPop.transform = .identity
    }
    }
    
    
    lazy var ViewPop : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()
    
    lazy var MailImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "mail")
        return ImageView
    }()

    lazy var Message : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlHeight(15)
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        let attributedString = NSMutableAttributedString(string: "Reset Link Sent Successfully \n", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(19)) ?? UIFont.systemFont(ofSize: ControlWidth(19)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ])
        attributedString.append(NSAttributedString(string: "You can now open your email to reset \npassword, or login again", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ]))
        Label.numberOfLines = 3
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ButtonBack : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Back", for: .normal)
        Button.backgroundColor = .white
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.layer.borderColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0).cgColor
        Button.layer.borderWidth = ControlHeight(2)
        Button.addTarget(self, action: #selector(ActionBack), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionBack() {
     dismiss(animated: true)
    }
    
    lazy var OpenEmail : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Open Email", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionOpenEmail), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionOpenEmail() {
    if let url = URL(string: "mailto:\(Email)") {
    if #available(iOS 10.0, *) {
    UIApplication.shared.open(url)
    } else {
    UIApplication.shared.openURL(url)
    }
    }
    }
}
