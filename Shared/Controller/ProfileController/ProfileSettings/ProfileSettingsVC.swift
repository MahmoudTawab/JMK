//
//  ProfileSettingsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 18/07/2021.
//

import UIKit
import FlagPhoneNumber

class ProfileSettingsVC: ViewController ,FPNTextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        SetUp()
        
        FirstNameTF.text = LaunchScreen.User?.fName ?? ""
        LastNameTF.text = LaunchScreen.User?.lName ?? ""
        PhoneNumberTF.text = LaunchScreen.User?.phone ?? ""
    }
    
    func SetUp() {
    
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
                
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
        
        let StackVertical = UIStackView(arrangedSubviews: [FirstNameTF,LastNameTF,PhoneNumberTF])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlHeight(33)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.clipsToBounds = false
        StackVertical.backgroundColor = .clear
        StackVertical.frame = CGRect(x: ControlX(20), y: ControlX(30), width: ViewScroll.frame.width - ControlWidth(40), height: ControlWidth(250))
        ViewScroll.addSubview(StackVertical)
                
        ViewScroll.addSubview(SaveChanges)
        SaveChanges.frame = CGRect(x: ControlX(20), y: StackVertical.frame.maxY + ControlX(60), width: ViewScroll.frame.width - ControlWidth(40), height: ControlWidth(50))
        
        SetUpPhoneNumber()
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
        
    lazy var SaveChanges : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Save Changes", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSaveChanges() {
    if FirstNameTF.NoError() && LastNameTF.NoError() && PhoneNumberNoError() {
    ActionSave()
    }
    }
    
    @objc func ActionSave() {
        
    guard let fName = LaunchScreen.User?.fName else{return}
    guard let lName = LaunchScreen.User?.lName else{return}
    guard let phone = LaunchScreen.User?.phone else{return}

    guard let FirstName = FirstNameTF.text else{return}
    guard let LastName = LastNameTF.text else{return}
    guard let PhoneNumber = PhoneNumberTF.text else{return}

    if FirstName == fName && LastName == lName && PhoneNumber == phone {
    self.ProgressHud.endRefreshing("There is no change in the data", .error) {
    return
    }
    }else if FirstName != fName || LastName != lName && PhoneNumber == phone {
    FuncUpdateProfile(FName: FirstName, LName: LastName, Phone: PhoneNumber)
    }else if FirstName == fName && LastName == lName && PhoneNumber != phone {
    let OTPUpdate = OTPUpdateProfile()
    OTPUpdate.ProfileSettings = self
    OTPUpdate.modalPresentationStyle = .overFullScreen
    OTPUpdate.modalTransitionStyle = .crossDissolve
    present(OTPUpdate, animated: true)
    }
    }
    
    static let PostProfileSettings = NSNotification.Name(rawValue: "UpdateProfile")
    func FuncUpdateProfile(FName:String ,LName:String ,Phone:String) {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let token = defaults.string(forKey: "JWT") else{return}
    let api = "\(url + UpdateProfile)"
    
    guard let SqlId = LaunchScreen.User?.SqlId else{return}
  
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                     "Platform": "I",
                                     "SqlId": SqlId,
                                     "Phone": Phone,
                                     "FName": FName,
                                     "LName": LName]
    ProgressHud.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    self.ProgressHud.endRefreshing("Success Update Profile", .success) {
    NotificationCenter.default.post(name: ProfileSettingsVC.PostProfileSettings, object: nil)
    }
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionSaveChanges)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }

    }
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Profile Settings"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
}
