//
//  OTPController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 13/07/2021.
//

import UIKit

class OTPController: ViewController, UITextFieldDelegate {

    var ModelData : Model?
    var SignUp : SignUpController?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Number1TextField.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.ViewScroll.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
    }

    func SetUp() {
        
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        ViewScroll.frame = view.bounds
        view.addSubview(ViewScroll)
    
        
        LogoImage.frame = CGRect(x: ControlX(125), y: ControlY(55),width: ControlWidth(125), height: ControlWidth(125))
        ViewScroll.addSubview(LogoImage)
        
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(30), width: view.frame.width - ControlWidth(30), height: ControlHeight(50))
        ViewScroll.addSubview(Dismiss)
        
        ContentView.frame = CGRect(x: ControlX(15), y: LogoImage.frame.maxY + ControlX(20), width: view.frame.width - ControlWidth(30), height: ControlWidth(250))
        ViewScroll.addSubview(ContentView)

        OTPLabel.frame = CGRect(x: ControlX(20),y: ControlY(15), width: ContentView.frame.width - ControlWidth(40),height: ControlWidth(100))
        ContentView.addSubview(OTPLabel)
        
        let Stackbottom = UIStackView(arrangedSubviews: [Number1TextField,Number2TextField,Number3TextField,Number4TextField])
        Stackbottom.axis = .horizontal
        Stackbottom.spacing = 15
        Stackbottom.distribution = .fillEqually
        Stackbottom.alignment = .fill
        Stackbottom.backgroundColor = .clear
        Stackbottom.frame = CGRect(x: ControlX(20), y: OTPLabel.frame.maxY + ControlX(20), width: ContentView.frame.width - ControlWidth(40), height: ControlWidth(63))
        ContentView.addSubview(Stackbottom)
    
        IsnotCorrect.frame = CGRect(x: ControlX(20), y: Stackbottom.frame.maxY + ControlX(14), width: ContentView.frame.width - ControlWidth(40), height: ControlHeight(20))
        ContentView.addSubview(IsnotCorrect)
        
        Labeltimer.frame = CGRect(x: view.center.x - ControlWidth(130), y: ContentView.frame.maxY + ControlX(20), width: ControlWidth(260), height: ControlHeight(30))
        ViewScroll.addSubview(Labeltimer)
    
        Number1TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Number2TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Number3TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Number4TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
                    
        LabelTimerAction()
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
        View.layer.shadowRadius = 10
        return View
    }()

    lazy var OTPLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlHeight(6)
        
        let attributedString = NSMutableAttributedString(string: "OTP\n", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ])

        attributedString.append(NSAttributedString(string: "One time password was sent on your phone number please enter it:\n", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ]))

        if let PhoneNumber = SignUp?.PhoneNumberTF.text {
        let Phone = String(PhoneNumber.enumerated().map { $0 > 0 && $0 % 3 == 0 ? [" ",$1] : [$1]}.joined())
        attributedString.append(NSAttributedString(string: "\(Phone) -> ", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ]))
        }
        
        attributedString.append(NSAttributedString(string: "Edit Number", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0) ,
            .paragraphStyle:style
        ]))

        Label.numberOfLines = 4
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:))))
        Label.isUserInteractionEnabled = true
        return Label
    }()
    
    @objc func tapLabel(_ gesture: UITapGestureRecognizer) {
    guard let text = OTPLabel.attributedText?.string else {return}

    guard let click_range = text.range(of: "Edit Number") else {return}
    if OTPLabel.didTapAttributedTextInLabel(gesture: gesture, inRange: NSRange(click_range, in: text)) {
    SignUp?.PhoneNumberTF.becomeFirstResponder()
    self.navigationController?.popViewController(animated: true)
    }
    }
    
    lazy var Number1TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0)
        tf.font = UIFont(name: "Raleway-Regular", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    
    lazy var Number2TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0)
        tf.font = UIFont(name: "Raleway-Regular", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    
    lazy var Number3TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0)
        tf.font = UIFont(name: "Raleway-Regular", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    
    lazy var Number4TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0)
        tf.font = UIFont(name: "Raleway-Regular", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    

    @objc func textFieldDidChange(textField: UITextField) {
    let Number = "2310"
//        "\(random)"
    let text = textField.text
        
    if let t: String = textField.text {
    textField.text = String(t.prefix(1))
    }
        
    if let Number1 = Number1TextField.text ,let Number2 = Number2TextField.text ,let Number3 = Number3TextField.text , let Number4 = Number4TextField.text {
        let Text = Number1 + Number2 + Number3 + Number4
        if Text != Number || Text.count != 4 {
        Number1TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
        Number2TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
        Number3TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
        Number4TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
        IsnotCorrect.alpha = 1
        }else{
        Number1TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        Number2TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        Number3TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        Number4TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        IsnotCorrect.alpha = 0
         
        self.CreateAccount()
        }
    }
    
    if  text?.count == 1 {
    switch textField {
    case Number1TextField:
    Number2TextField.becomeFirstResponder()
    case Number2TextField:
        Number3TextField.becomeFirstResponder()
    case Number3TextField:
        Number4TextField.becomeFirstResponder()
    case Number4TextField:
        Number4TextField.resignFirstResponder()
    default:
    break
    }
    }
    if  text?.count == 0 {
    switch textField{
    case Number1TextField:
        Number1TextField.becomeFirstResponder()
    case Number2TextField:
        Number1TextField.becomeFirstResponder()
    case Number3TextField:
        Number2TextField.becomeFirstResponder()
    case Number4TextField:
        Number3TextField.becomeFirstResponder()
    default:
    break
    }
    }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    lazy var IsnotCorrect : UILabel = {
        let Label = UILabel()
        Label.alpha = 0
        Label.text = "OTP is not correct"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(15))
        Label.textColor = UIColor(red: 230 / 255.0, green: 96 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var Labeltimer : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = false
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LabelTimerAction)))
        return Label
    }()
    
    @objc func LabelTimerAction() {
        StartTimer()
//        VerificationSend()
    }

    var timer = Timer()
    var newTimer = 120
    @objc func ActionLabeltimer()  {
    let Timer = "\(timeFormatted(newTimer))"
    newTimer -= 1
    AttributedString(Labeltimer, "The code will be resend in", Timer, "sec")
    Labeltimer.isUserInteractionEnabled = false
    if newTimer < -1 {
    let Text = "Resend Code"
    AttributedString(Labeltimer, Text, "", "")
    Labeltimer.isUserInteractionEnabled = true
    timer.invalidate()
    }
    }
    
    public func AttributedString(_ Label:UILabel,_ Text1:String,_ Text2:String,_ Text3:String) {
    let underlinedMessage = NSMutableAttributedString(string: Text1 + " ", attributes: [
    .font: UIFont(name: "Raleway-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: UIColor(red: 43 / 255, green: 43 / 255, blue: 43 / 255, alpha: 1),
    .underlineStyle: NSUnderlineStyle.single.rawValue
    ])
    underlinedMessage.append(NSAttributedString(string: Text2 + " ", attributes: [
    .font: UIFont(name: "Raleway-SemiBold" , size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: UIColor(red: 43 / 255, green: 43 / 255, blue: 43 / 255, alpha: 1)
    ]))
    
    underlinedMessage.append(NSAttributedString(string: Text3, attributes: [
    .font: UIFont(name: "Raleway-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: UIColor(red: 43 / 255, green: 43 / 255, blue: 43 / 255, alpha: 1),
    .underlineStyle: NSUnderlineStyle.single.rawValue
    ]))
    Label.attributedText = underlinedMessage
    }
    

    
    func StartTimer() {
    newTimer = 120
    timer = Timer.scheduledTimer(timeInterval: 1 , target: self , selector:  #selector(ActionLabeltimer) , userInfo: nil , repeats:  true)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
    
    
    let random = Int.random(in: 1000..<9999)
    func VerificationSend() {
    guard let url = defaults.string(forKey: "API") else{return}
    let Verification = "\(url + SendSms)"
      

    guard let SignUpController = SignUp else{return}
    guard let Phone = SignUpController.PhoneNumberTF.text else{return}
        
    ProgressHud.beginRefreshing()
    let parameters:[String:Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                   "Platform": "I",
                                   "Token":"PNOH0LWNWciBLtorar8QVAjm+",
                                   "PhoneNumber": Phone,
                                   "VerificationMessage": "your vrification code Is: \(random)"]
      

    PostAPI(api: Verification, token: nil, parameters: parameters) { _ in
    self.ProgressHud.endRefreshing() {}
    } DictionaryData: { _ in
    self.ProgressHud.endRefreshing() {}
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ProgressHud.endRefreshing(error, .error) {}
    }
    }
    

    func CreateAccount() {
        
//    guard let url = defaults.string(forKey: "API") else{return}
//    let NewAccount = "\(url + CreateNewAccount)"
//     
//    guard let SignUpController = SignUp else{return}
//    guard let Password = SignUpController.PasswordTextField.text else{return}
//    guard let FirstName = SignUpController.FirstNameTF.text else{return}
//    guard let Phone = SignUpController.PhoneNumberTF.text else{return}
//    guard let Email = SignUpController.EmailTextField.text else{return}
//    let Social = defaults.string(forKey:"SocialLogin") ?? "E"
//    let Uid = SignUpController.uid
//        
//    let Gender = SignUpController.MaleButton.isOn == true ? 1:0
//    let LastName = SignUpController.LastNameTF.text ?? ""
//        
//    ProgressHud.beginRefreshing()
//    let parameters:[String:Any] = [
//                        "AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                        "Platform": "I",
//                        "FName": FirstName,
//                        "LName": LastName,
//                        "Password": Password,
//                        "Phone": Phone,
//                        "Email": Email,
//                        "Gender": Gender,
//                        "Uid": Uid,
//                        "SocialLogin": Social]
//
//    PostAPI(api: NewAccount, token: nil, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
//            self.ModelData = Model(dictionary: data)
//            LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}

            self.ProgressHud.endRefreshing() {

            let Successfully = ViewSuccessfully()
            Successfully.TextDismiss = ""
            Successfully.GoText = "Go Home"
            Successfully.ImageIcon = "success"
            Successfully.MessageTitle = "Successfully registered"
            Successfully.MessageDetails = "Thank you so much for taking the time to send this! Everyone here at JMK loves to know that our customers enjoy what we do"
            Successfully.GoToController.addTarget(self, action: #selector(self.SuccessfullyOTP), for: .touchUpInside)
            Successfully.modalPresentationStyle = .overFullScreen
            Successfully.modalTransitionStyle = .crossDissolve
            self.present(Successfully, animated: true)

            }
        }

//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }
    }
    
    @objc func SuccessfullyOTP() {
    FirstController(TabBarController())
    }
    
}
