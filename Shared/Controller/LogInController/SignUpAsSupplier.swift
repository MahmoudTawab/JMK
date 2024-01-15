//
//  SignUpAsSupplier.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 13/07/2021.
//

import UIKit
import FlagPhoneNumber

class SignUpAsSupplier: ViewController ,FPNTextFieldDelegate {

    var SelectedId:String?
    var SelectedName:String?
    var Industry = [SupplierIndustry]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        GetAllIndestry()
    }
    
    
    func SetUp() {
    
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        ViewScroll.frame = view.bounds
        view.addSubview(ViewScroll)
        
        LogoImage.frame = CGRect(x: ControlX(125),y: ControlY(30),width: ControlWidth(125),height: ControlWidth(125))
        ViewScroll.addSubview(LogoImage)
        
        Dismiss.frame = CGRect(x: ControlX(15),y: ControlY(15),width: view.frame.width - ControlWidth(30),height: ControlHeight(50))
        ViewScroll.addSubview(Dismiss)
        
        ContentView.frame = CGRect(x: ControlX(15),y: LogoImage.frame.maxY + ControlX(20),width: view.frame.width - ControlWidth(30),height: ControlWidth(730))
        ViewScroll.addSubview(ContentView)
  
        StackVertical.frame = CGRect(x: ControlX(30),y: ControlY(10),width: ContentView.frame.width - ControlWidth(60),height: ControlWidth(690))
        ContentView.addSubview(StackVertical)
        
        SetUpPhoneNumber()
        ViewScroll.updateContentViewSize(ControlHeight(30))
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.showsVerticalScrollIndicator = false
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
        ImageView.alpha = 0
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "logo")
        ImageView.MotionEffect()
        return ImageView
    }()
    
    lazy var ContentView:UIView = {
        let View = UIView()
        View.alpha = 0
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = ControlHeight(10)
        return View
    }()

    lazy var SignUpAsSupplier : UILabel = {
        let Label = UILabel()
        Label.text = "Sign Up As Supplier"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(20))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var NameTextField : FloatingTF = {
        let tf = FloatingTF()
        tf.attributedPlaceholder = NSAttributedString(string: "Name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
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
    
    let IndustryPicker = UIPickerView()
    lazy var IndustryTextField : FloatingTF = {
        let tf = FloatingTF()
        IndustryPicker.delegate = self
        tf.inputView = IndustryPicker
        IndustryPicker.backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 1.0)
        tf.IconImage = UIImage(named: "down")
        tf.clearButtonMode = .never
        tf.tintColor = .clear
        tf.keyboardDistanceFromTextField = 0
        tf.SetUpIcon(LeftOrRight: false, Width: ControlWidth(25), Height: ControlWidth(28))
        tf.addTarget(self, action: #selector(textIsChanging), for: .editingChanged)
        tf.attributedPlaceholder = NSAttributedString(string: "Industry", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func textIsChanging() {
    IndustryTextField.text = SelectedName
    }
    
    
    lazy var PortfolioLinkTF : FloatingTF = {
        let tf = FloatingTF()
        tf.keyboardType = .URL
        tf.attributedPlaceholder = NSAttributedString(string: "Portfolio link", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var FacebookLinkTF : FloatingTF = {
        let tf = FloatingTF()
        tf.clearButtonMode = .never
        tf.IconImage = UIImage(named: "Group 31775")
        tf.SetUpIcon(LeftOrRight: false, Width: 32, Height: 36)
        tf.Icon.addTarget(self, action: #selector(ActionFacebookLink), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Facebook link (Optional)", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionFacebookLink() {
        guard let url = URL(string: "https://de-de.facebook.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    lazy var InstagramLinkTF : FloatingTF = {
        let tf = FloatingTF()
        tf.clearButtonMode = .never
        tf.IconImage = UIImage(named: "Group 31792")
        tf.SetUpIcon(LeftOrRight: false, Width: 32, Height: 36)
        tf.Icon.addTarget(self, action: #selector(ActionInstagramLink), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Instagram link (Optional)", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionInstagramLink() {
        guard let url = URL(string: "https://instagram.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    lazy var YoutubeLinkTF : FloatingTF = {
        let tf = FloatingTF()
        tf.clearButtonMode = .never
        tf.IconImage = UIImage(named: "Group 31791")
        tf.SetUpIcon(LeftOrRight: false, Width: 32, Height: 36)
        tf.Icon.addTarget(self, action: #selector(ActionYoutubeLink), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Youtube link (Optional)", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionYoutubeLink() {
        guard let url = URL(string: "https://www.youtube.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    lazy var PinterestLinkTF : FloatingTF = {
        let tf = FloatingTF()
        tf.clearButtonMode = .never
        tf.IconImage = UIImage(named: "Group 31790")
        tf.SetUpIcon(LeftOrRight: false, Width: 32, Height: 36)
        tf.Icon.addTarget(self, action: #selector(ActionPinterestLink), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Pinterest link (Optional)", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionPinterestLink() {
        guard let url = URL(string: "https://www.pinterest.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    lazy var StackVertical : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [SignUpAsSupplier,NameTextField,EmailTextField,PhoneNumberTF,IndustryTextField,PortfolioLinkTF,FacebookLinkTF,InstagramLinkTF,YoutubeLinkTF,PinterestLinkTF,SignUp])
    Stack.axis = .vertical
    Stack.spacing = 25
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()

    lazy var SignUp : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Sign Up", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionSignUp), for: .touchUpInside)
        return Button
    }()
    

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


extension SignUpAsSupplier: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Industry.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Industry[row].Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       SelectedName = Industry[row].Name
        
       SelectedId = Industry[row].Id
       IndustryTextField.text = SelectedName
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label:UILabel
        if let view = view as? UILabel {
            label = view
        }else{
            label = UILabel()
        }
        label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        label.text = Industry[row].Name
        return label
    }
}

extension SignUpAsSupplier {
    
    // lod Api data
    func GetAllIndestry() {
//        guard let url = defaults.string(forKey: "API") else{return}
//        let api = "\(url + AllIndestry)"
//        
//        let parameters:[String : Any] = ["language": Locale.current.languageCode ?? "en"]
//        
        self.ProgressHud.beginRefreshing()
//        PostAPI(api: api, token: nil, parameters: parameters) { _ in
//        } DictionaryData: { _ in
//        } ArrayOfDictionary: { data in
        
        let  data = [["Id":"","Name":"Test1"],["Id":"","Name":"Test2"],["Id":"","Name":"Test3"],["Id":"","Name":"Test4"],["Id":"","Name":"Test5"],["Id":"","Name":"Test6"],["Id":"","Name":"Test7"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            for item in data {
                self.Industry.append(SupplierIndustry(dictionary: item))
                self.IndustryPicker.reloadAllComponents()
            }
            self.NoData(false)
            self.ProgressHud.endRefreshing() {}
        }
        
//        } Err: { (error) in
//            
//        if error != "" {
//        self.NoData(true)
//        self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.TryAgainIndestry)}
//        }
            
//        }
    }
    
    func NoData(_ boll:Bool) {
    self.LogoImage.alpha = boll ? 0:1
    self.ContentView.alpha = boll ? 0:1
    self.ViewNoData.isHidden = boll ? false : true
    self.ViewScroll.isScrollEnabled = boll ? false : true
    }
    
    @objc func TryAgainIndestry() {
    self.Industry.removeAll()
    GetAllIndestry()
    }
    
    
    @objc func ActionSignUp() {
    if NameTextField.NoError() && EmailTextField.NoError() && EmailTextField.NoErrorEmail() && PhoneNumberNoError() && IsValid && IndustryTextField.NoError()
        && PortfolioLinkTF.NoError() {
    
//    guard let Name = NameTextField.text else { return }
//    guard let Email = EmailTextField.text else { return }
//    guard let Phone = PhoneNumberTF.text else { return }
//    guard let IndustryId = SelectedId else { return }
//    guard let PortfolioLink = PortfolioLinkTF.text else { return }
//    let FacebookLink = FacebookLinkTF.text ?? ""
//    let InstagramLink = InstagramLinkTF.text ?? ""
//    let YoutubeLink = YoutubeLinkTF.text ?? ""
//    let PinterestLink = PinterestLinkTF.text ?? ""
//        
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + CreateNewSupplier)"
//        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                         "Platform": "I",
//                                         "Name": Name,
//                                         "Email": Email,
//                                         "Phone": Phone,
//                                         "IndustryId": IndustryId,
//                                         "PortfolioLink": PortfolioLink,
//                                         "FacebookLink": FacebookLink,
//                                         "InstagramLink": InstagramLink,
//                                         "YoutubeLink": YoutubeLink,
//                                         "PinterestLink": PinterestLink]
        
    ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: nil, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ProgressHud.endRefreshing("Supplier Success", .success) {
                for view in self.StackVertical.subviews {
                    if view is FloatingTF {
                        let field: FloatingTF = view as! FloatingTF
                        field.text = ""
                        self.PhoneNumberTF.text = ""
                    }
                }
            }
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { (error) in
//        
//    if error != "" {
//    if error.contains("ERROR MESSAG") {
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }else{
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.TryAgainSignUp)}
//    }
//        
//    }
//    }
//    }else{
//        
//    if PhoneNumberTF.text?.TextNull() == true && !IsValid {
//    PhoneNumberTF.Shake()
//    }
//    ViewScroll.setContentOffset(CGPoint(x: 0, y: ControlY(180)), animated: true)
    }
    }
    
    
    @objc func TryAgainSignUp() {
    ActionSignUp()
    }
    
    
    
}
