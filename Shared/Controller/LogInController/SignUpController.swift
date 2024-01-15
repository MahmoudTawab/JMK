//
//  SignUpController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit
import FlagPhoneNumber

class SignUpController: ViewController ,FPNTextFieldDelegate {

    var uid = String()
    var ProfileImageUrl : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        
    }
    
    func SetUp() {
        
        var HeightSignUp = CGFloat()
        if SignUpLabel.text == "Sign Up" {
        PasswordTextField.isHidden = false
        PasswordConfirmTF.isHidden = false
        HeightSignUp = ControlWidth(415)
        }else{
        Successfully = true
        PasswordTextField.text = "123456"
        PasswordConfirmTF.text = "123456"
        PasswordTextField.isHidden = true
        PasswordConfirmTF.isHidden = true
        HeightSignUp = ControlWidth(370)
        }

        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        ViewScroll.frame = view.bounds
        view.addSubview(ViewScroll)
        
        LogoImage.frame = CGRect(x: ControlX(125), y: ControlY(30), width: ControlWidth(125), height: ControlWidth(125))
        ViewScroll.addSubview(LogoImage)
        
        ContentView.frame =  CGRect(x: ControlX(15), y: LogoImage.frame.maxY + ControlX(20), width: view.frame.width - ControlWidth(30), height: HeightSignUp)
        ViewScroll.addSubview(ContentView)
        
        ViewLine.frame = CGRect(x: ControlX(30), y: view.frame.maxY - ControlY(60), width: view.frame.width - ControlWidth(60), height:ControlHeight(0.6))
        ViewScroll.addSubview(ViewLine)
                
        SignInBack.frame = CGRect(x: ControlX(50), y: view.frame.maxY - ControlY(45), width: view.frame.width - ControlWidth(100), height: ControlHeight(30))
        ViewScroll.addSubview(SignInBack)
                
        let StackMaleFemale = UIStackView(arrangedSubviews: [MaleButton,FemaleButton])
        StackMaleFemale.axis = .horizontal
        StackMaleFemale.spacing = ControlHeight(5)
        StackMaleFemale.distribution = .fillEqually
        StackMaleFemale.alignment = .fill
        StackMaleFemale.backgroundColor = .clear
        
        let StackName = UIStackView(arrangedSubviews: [FirstNameTF,LastNameTF])
        StackName.axis = .horizontal
        StackName.spacing = ControlHeight(15)
        StackName.distribution = .fillEqually
        StackName.alignment = .fill
        StackName.backgroundColor = .clear
        
        let StackVertical = UIStackView(arrangedSubviews: [SignUpLabel,StackName,EmailTextField,PhoneNumberTF,PasswordTextField,PasswordConfirmTF,StackMaleFemale,SignUp])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlHeight(8)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.backgroundColor = .clear
        StackVertical.frame = CGRect(x: ControlX(30), y: ControlY(10), width: ContentView.frame.width - ControlWidth(60), height: HeightSignUp - 35)
        ContentView.addSubview(StackVertical)
                
        SetUpPhoneNumber()
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.showsVerticalScrollIndicator = false
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        return Scroll
    }()

    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
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

    lazy var SignUpLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var FirstNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.attributedPlaceholder = NSAttributedString(string: "First Name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var LastNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    
    lazy var EmailTextField : FloatingTF = {
        let tf = FloatingTF()
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(PhoneNumberDidEnd), for: .editingDidEnd)
        return tf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    func SetUpPhoneNumber() {
    listController.setup(repository: PhoneNumberTF.countryRepository)
    listController.didSelect = { [weak self] country in
    self?.PhoneNumberTF.setFlag(countryCode: country.code)
    }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        textField.placeholder = "Phone Number"
        IsValid = isValid
        
        if !isValid {
        View.Label.text = "Please enter your\nPhone Number properly"
        if View.alpha == 0 {
        View.show(from: CGRect(x: PhoneNumberTF.bounds.size.width / 2, y: ControlY(-20), width: ControlWidth(90), height: ControlWidth(28)), inContainerView: PhoneNumberTF)
        }
        }else{
        self.View.dismiss()
        }
    }
    
    @objc func PhoneNumberDidEnd() {
    self.View.dismiss()
    }
    
    var IsValid = false
    lazy var View : SHAutocorrectSuggestionView = {
        let View = SHAutocorrectSuggestionView(frame: CGRect(x: PhoneNumberTF.bounds.size.width / 2, y: ControlY(-10), width: ControlWidth(100), height: ControlHeight(25)))
        View.backgroundColor = .clear
        View.alpha = 0
        return View
    }()
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Select your country"
        listController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCountries))
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCountries))
    
        navigationViewController.modalPresentationStyle = .fullScreen
        navigationViewController.modalTransitionStyle = .coverVertical
        present(navigationViewController, animated: true)
    }
    
    @objc func refreshCountries() {
    listController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func dismissCountries() {
    listController.dismiss(animated: true)
    }
    
    func PhoneNumberNoError() -> Bool {
    if PhoneNumberTF.text?.TextNull() == false {
    self.Show()
    return false
    }else{
    return true
    }
    }
    
    var timr = Timer()
    func Show() {
    View.Label.text = "Empty data cannot be registered"
    View.show(from: CGRect(x: PhoneNumberTF.bounds.size.width / 2, y: ControlY(-10), width: ControlWidth(90), height: ControlWidth(28)), inContainerView: PhoneNumberTF)

    PhoneNumberTF.Shake()
    timr.invalidate()
    self.timr = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.Time), userInfo: nil, repeats: true)
    }
    
    @objc func Time() {
    self.View.dismiss()
    self.timr.invalidate()
    }
    
    lazy var PasswordTextField : FloatingTF = {
        let tf = FloatingTF()
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.SetUpIcon(LeftOrRight: false)
        tf.IconImage = UIImage(named: "visibility-1")
        tf.Icon.addTarget(self, action: #selector(ActionPassword), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionPassword() {
        if PasswordTextField.IconImage == UIImage(named: "visibility-1") {
            PasswordTextField.isSecureTextEntry = false
            PasswordConfirmTF.isSecureTextEntry = false
            PasswordTextField.IconImage = UIImage(named: "visibility")
        }else{
            PasswordTextField.isSecureTextEntry = true
            PasswordConfirmTF.isSecureTextEntry = true
            PasswordTextField.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    lazy var PasswordConfirmTF : FloatingTF = {
        let tf = FloatingTF()
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(PasswordConfirm), for: .editingChanged)
        return tf
    }()
    
    
    var Successfully = false
    let image1 = UIImage(named: "tick")?.withInset(UIEdgeInsets(top: ControlY(2), left: ControlX(4), bottom: ControlY(2), right: ControlX(4)))
    let image2 = UIImage(named: "ic_close")?.withInset(UIEdgeInsets(top: ControlY(2), left: ControlX(4), bottom: ControlY(2), right: ControlX(4)))
    @objc func PasswordConfirm() {
    if (PasswordConfirmTF.text?.count)! > 0 {
    PasswordConfirmTF.SetUpIcon(LeftOrRight: false)
    if PasswordConfirmTF.text == PasswordTextField.text {
    PasswordConfirmTF.Icon.setBackgroundImage(image1, for: .normal)
    Successfully = true
    }else{
    PasswordConfirmTF.Icon.setBackgroundImage(image2, for: .normal)
    Successfully = false
    }
    PasswordConfirmTF.Icon.transform = .identity
    }else{
    PasswordConfirmTF.Icon.removeFromSuperview()
    }
    }
    
    
    lazy var MaleButton : SPRadioButton = {
        let Button = SPRadioButton()
        Button.text = "Male"
        Button.isOn = true
        Button.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Button.addTarget(self, action: #selector(ActionYes), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(4), left: 0, bottom: 0, right: 0)
        return Button
    }()
    
    @objc func ActionYes() {
    MaleButton.isOn = true
    FemaleButton.isOn = false
    }

    lazy var FemaleButton : SPRadioButton = {
        let Button = SPRadioButton()
        Button.text = "Female"
        Button.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Button.addTarget(self, action: #selector(ActionNo), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(4), left: 0, bottom: 0, right: 0)
        return Button
    }()
    
    @objc func ActionNo() {
    FemaleButton.isOn = true
    MaleButton.isOn = false
    }
    
    lazy var SignUp : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Sign Up", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionSignUp), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignUp() {
    if FirstNameTF.NoError() && EmailTextField.NoError() && EmailTextField.NoErrorEmail() && PhoneNumberNoError() && IsValid && PasswordTextField.NoError() && PasswordTextField.NoErrorPassword() && Successfully {
    let OTP = OTPController()
    OTP.SignUp = self
    self.Present(ViewController: self, ToViewController: OTP)
    }
    }
    
    lazy var ViewLine : UIView = {
    let View = UIView()
    View.backgroundColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.5)
    return View
    }()

    
    lazy var SignInBack : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        let attributedString = NSMutableAttributedString(string: "Already a member? Sign In now.", attributes: [
        .font: UIFont(name: "Raleway-Bold", size: ControlWidth(12)) ?? UIFont.systemFont(ofSize: ControlWidth(12)),
        .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 215.0 / 255.0, green: 177.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0), range: NSRange(location: 18, length: 8))
        Button.setAttributedTitle(attributedString, for: .normal)
        Button.addTarget(self, action: #selector(ActionSignInBack), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignInBack() {
    self.navigationController?.popViewController(animated: true)
    }

}
