//
//  ContactUsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 02/08/2021.
//

import UIKit

class ContactUsVC: ViewController {
    
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
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))

        ViewScroll.addSubview(SubjectTF)
        SubjectTF.leftAnchor.constraint(equalTo: view.leftAnchor , constant: ControlX(20)).isActive = true
        SubjectTF.rightAnchor.constraint(equalTo: view.rightAnchor , constant: ControlX(-20)).isActive = true
        SubjectTF.topAnchor.constraint(equalTo: ViewScroll.topAnchor, constant: ControlX(40)).isActive = true
        SubjectTF.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
       
        ViewScroll.addSubview(MessageTV)
        MessageTV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(20)).isActive = true
        MessageTV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-20)).isActive = true
        MessageTV.topAnchor.constraint(equalTo: SubjectTF.bottomAnchor, constant: ControlX(40)).isActive = true
        MessageTV.heightAnchor.constraint(equalToConstant: ControlWidth(280)).isActive = true
        
        ViewScroll.addSubview(borderTV)
        borderTV.leadingAnchor.constraint(equalTo: MessageTV.leadingAnchor).isActive = true
        borderTV.trailingAnchor.constraint(equalTo: MessageTV.trailingAnchor).isActive = true
        borderTV.bottomAnchor.constraint(equalTo: MessageTV.bottomAnchor, constant: ControlX(5)).isActive = true
        borderTV.heightAnchor.constraint(equalToConstant: ControlWidth(1)).isActive = true
        
        ViewScroll.addSubview(SendMessage)
        SendMessage.leftAnchor.constraint(equalTo: SubjectTF.leftAnchor).isActive = true
        SendMessage.rightAnchor.constraint(equalTo: SubjectTF.rightAnchor).isActive = true
        SendMessage.topAnchor.constraint(equalTo: MessageTV.bottomAnchor, constant: ControlX(70)).isActive = true
        SendMessage.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
                
    }

    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.contentSize = CGSize(width: view.frame.width , height: view.frame.height - ControlHeight(80))
        return Scroll
    }()
    
    lazy var Dismiss : ViewDismiss = {
    let dismiss = ViewDismiss()
    dismiss.TextDismiss = "Contact Us"
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

    
    lazy var SubjectTF : FloatingTF = {
        let tf = FloatingTF()
        tf.attributedPlaceholder = NSAttributedString(string: "Subject", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var MessageTV : GrowingTextView = {
        let TV = GrowingTextView()
        TV.placeholder = "Message"
        TV.minHeight = ControlHeight(70)
        TV.maxHeight = ControlHeight(280)
        TV.placeholderColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)
        TV.backgroundColor = .clear
        TV.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        TV.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        TV.autocorrectionType = .no
        TV.font = UIFont(name: "Raleway-Regular", size: ControlWidth(15))
        TV.translatesAutoresizingMaskIntoConstraints = false
        return TV
    }()
    
    lazy var borderTV : UIView = {
    let border = UIView()
    border.backgroundColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 0.6)
    border.translatesAutoresizingMaskIntoConstraints = false
    return border
    }()
    
    lazy var SendMessage : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Send Message", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionSendMessage), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionSendMessage() {
        if SubjectTF.NoError() && MessageTV.NoError() {
            ContactUs()
        }
    }
    
    @objc func ContactUs() {
        guard let url = defaults.string(forKey: "API") else{return}
        guard let token = defaults.string(forKey: "JWT") else{return}
        let api = "\(url + PhoneAddContactUs)"
            
        guard let Subject = SubjectTF.text else{return}
        guard let Message = MessageTV.text else{return}
      
        let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                         "Platform": "I",
                                         "Token": "kiG9w0BAQEFAASCBKcwggSjAgEAAoI",
                                         "Subject": Subject,
                                         "Message": Message]
        ProgressHud.beginRefreshing()
        PostAPI(api: api, token: token, parameters: parameters) { _ in
        } DictionaryData: { data in
        self.ProgressHud.endRefreshing() {}
        self.SubjectTF.text = ""
        self.MessageTV.text = ""
        self.SetSuccessfully()
        } ArrayOfDictionary: { _ in
        } Err: { error in
        if error != "" {
        self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ContactUs)}
        }
        }
    }
    
    

    func SetSuccessfully() {
    let Successfully = ViewSuccessfully()
    Successfully.TextDismiss = "Contact Us"
    Successfully.GoText = "Go Home"
    Successfully.ImageIcon = "contact"
    Successfully.MessageTitle = "Message Sent Successfully"
    Successfully.MessageDetails = "Thank you so much for taking the time to send this! Your message has been sent successfully. And we will get back to you soon"
    Successfully.GoToController.addTarget(self, action: #selector(SuccessfullyContactUs), for: .touchUpInside)
    Successfully.modalPresentationStyle = .overFullScreen
    Successfully.modalTransitionStyle = .crossDissolve
    present(Successfully, animated: true)
    }
    
    
    @objc func SuccessfullyContactUs() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
    appDelegate.window?.rootViewController?.dismiss(animated: false)
    appDelegate.window?.makeKeyAndVisible()
    appDelegate.window?.rootViewController = TabBarController()
    }
    }
    
}
