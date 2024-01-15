//
//  ProfileController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 11/07/2021.
//

import UIKit
import Photos
import Firebase
import ImagePicker
import FirebaseAuth
import SDWebImage
import MobileCoreServices

class ProfileController: ViewController, ProfileDelegate , UIImagePickerControllerDelegate & UINavigationControllerDelegate , MediaBrowserDelegate ,ImagePickerDelegate {

    
    var timer = Timer()
    let CellId = "CellId"
    var ObjectProfile : ProfileObject?
    var ProfileImageArray = ["Event10","heart","Shopping","gps","settings","envelope","package","exit"]
    var ProfileTitleArray = ["My Events","Saved","Cart","My Places","Settings","Contact us","Become Supplier","Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetUp()
    }
    
    func SetUp() {
        

        view.addSubview(ViewScroll)
        ViewScroll.frame = view.bounds
     
        ViewScroll.addSubview(BackgroundProfile)
        let height = UIApplication.shared.statusBarFrame.height
        BackgroundProfile.frame = CGRect(x: 0, y: -height, width: view.frame.width, height: ControlWidth(245) + height)
                
        ViewScroll.addSubview(EditProfile)
        ViewScroll.addSubview(ProfileImage)
        
        ProfileImage.frame = CGRect(x: view.center.x - (ControlWidth(110) / 2),y: ControlX(47.5), width: ControlWidth(110), height: ControlWidth(110))
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height / 2
        
        EditProfile.frame = CGRect(x: view.center.x - ControlWidth(100), y: ControlX(165), width: ControlWidth(200), height: ControlWidth(30))
    
        ViewScroll.addSubview(StackCamera)
        StackCamera.frame = CGRect(x: view.center.x - ControlWidth(30), y: ControlX(107), width: ControlWidth(60), height: ControlWidth(45))
        
        ViewScroll.addSubview(PlanningView)
        PlanningView.frame = CGRect(x: ControlX(20), y: ControlX(205), width: ControlWidth(335), height: ControlWidth(195))
        
        PlanningView.addSubview(PlanningLabel)
        PlanningView.addSubview(StackProgress)
        PlanningView.addSubview(PlanningButton)
        
        PlanningView.addSubview(StackHorizontal)
        StackHorizontal.frame = CGRect(x: ControlX(10), y: ControlX(38), width: ControlWidth(315), height: ControlWidth(123))
        
        ViewScroll.addSubview(FemaleImage)
        ViewScroll.addSubview(TableView)
        TableView.frame = CGRect(x: ControlX(20), y: ControlX(407.5), width: ControlWidth(335), height: CGFloat(ProfileImageArray.count) * ControlWidth(50))
        
        FemaleImage.frame =  CGRect(x: ControlX(50), y: ControlX(407.5), width: ControlWidth(325), height: TableView.frame.height + 20)
           
        // MARK: - ViewScroll contentSize height
        self.ViewScroll.updateContentViewSize(ControlWidth(5))
    
        gradient()
        ScheduledTimer()
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(ScheduledTimer), userInfo: nil, repeats: true)
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
        refreshControl.addTarget(self, action: #selector(Refresh), for: .valueChanged)
        refreshControl.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlWidth(80))
        ViewScroll.refreshControl = refreshControl
        
        NotificationCenter.default.addObserver(self, selector: #selector(Refresh), name: ProfileSettingsVC.PostProfileSettings , object: nil)
        
        LodCore()
        LodProfileImage()
        LodProfileName()
    }
    
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .white
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()
    
    lazy var BackgroundProfile:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = false
        return ImageView
    }()

    lazy var ProfileImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .black
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DidSelect)))
        return ImageView
    }()
    
    @objc func DidSelect() {
        let browser = MediaBrowser(delegate: self)
        browser.enableGrid = false
        browser.title = "Profile Image"
        let nc = UINavigationController(rootViewController: browser)
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .coverVertical
        present(nc, animated: true)
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return 1
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: ProfileImage.image ?? UIImage())
    return photo
    }
    
    func gradient() {
        let gradientLayer = CAGradientLayer()
        let colors1 = UIColor(red: 101/255, green: 100/255, blue: 100/255, alpha: 0).cgColor
        let colors2 = UIColor(red: 100/255, green: 98/255, blue: 98/255, alpha: 0.72).cgColor
        let colors3 = UIColor(red: 89/255, green: 88/255, blue: 88/255, alpha: 0.98).cgColor
        let colors4 = UIColor(red: 86/255, green: 85/255, blue: 85/255, alpha: 1).cgColor
        gradientLayer.colors = [colors1,colors2,colors3,colors4]
        gradientLayer.frame = CGRect(x: 0, y: ProfileImage.frame.height / 2, width: ProfileImage.frame.width, height: ProfileImage.frame.height / 2)
        ProfileImage.layer.insertSublayer(gradientLayer, at: 0)
    }

    lazy var StackCamera : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [ImageCamera,CameraChange])
    Stack.axis = .vertical
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.isUserInteractionEnabled = true
    Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCamera)))
    return Stack
    }()
    
    lazy var CameraChange : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Change", for: .normal)
        Button.backgroundColor = .clear
        Button.titleLabel?.font = UIFont(name: "Raleway-Medium", size: ControlWidth(12))
        Button.setTitleColor(#colorLiteral(red: 1, green: 0.978754346, blue: 0.9472923801, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionCamera), for: .touchUpInside)
        return Button
    }()
    
    lazy var ImageCamera:UIImageView = {
        let ImageView = UIImageView()
        let Image = UIImage(named: "camera")?.withInset(UIEdgeInsets(top: ControlY(2), left: ControlX(2), bottom: 0, right: ControlX(2)))
        ImageView.contentMode = .scaleAspectFit
        ImageView.backgroundColor = .clear
        ImageView.image = Image
        ImageView.tintColor = .white
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCamera)))
        return ImageView
    }()

    
    var evenAssets = [PHAsset]()
    @objc func ActionCamera() {
    view.endEditing(false)
    let config = Configuration()
    config.doneButtonTitle = "Finish"
    config.noImagesTitle = "Sorry! Please Wait..."
    config.showsImageCountLabel = true
    config.allowMultiplePhotoSelection = false
    let imagePickerController = ImagePickerController(configuration: config)
    imagePickerController.delegate = self
    imagePickerController.imageLimit = 1
    imagePickerController.stack.assets = evenAssets
    Present(ViewController: self, ToViewController: imagePickerController)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        if !images.isEmpty {
        evenAssets.removeAll()
        ProfileImage.image = images.first
        SetImageProfile(images.first)
            
        evenAssets.append(contentsOf: imagePicker.stack.assets)
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
    self.self.navigationController?.popViewController(animated: true)
    }
    
    func SetImageProfile(_ image:UIImage?) {
//    guard let Uid = LaunchScreen.User?.Uid else{return}
//    guard let Image = image else { return }
        
    self.ProgressHud.beginRefreshing()
//    Storag(child: ["profile_pictures",Uid,"Profile User"], image: Image) { Url in
//        
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + ChangeProfilePicture)"
//        
//        
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                         "SqlId": SqlId,
//                                         "Platform": "I",
//                                         "ProfileImg": Url]
    
//    PostAPI(api: api, token: token, parameters: parameters) { String in
    self.ProgressHud.endRefreshing() {}
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.LodProfileImage()
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }
//    }
//    } Err: { error in
//    if error != "" {
//    self.LodProfileImage()
//    self.ProgressHud.endRefreshing(error, .error) {}
//    }
//    }
        
    }
    
    lazy var EditProfile : UIButton = {
        let Button = UIButton(type: .system)
        Button.setImage(UIImage(named: "edit"), for: .normal)
        Button.backgroundColor = .clear
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Button.imageEdgeInsets = UIEdgeInsets(top: ControlY(3), left: ControlX(3), bottom: ControlY(3), right: 0)
        Button.setTitleColor(UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1), for: .normal)
        Button.tintColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
        Button.semanticContentAttribute = .forceRightToLeft
        Button.addTarget(self, action: #selector(ActionEditProfile), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionEditProfile() {
    Present(ViewController: self, ToViewController: ProfileSettingsVC())
    }
    
    lazy var PlanningView : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = 10
        return View
    }()
    
    lazy var PlanningLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()

    lazy var PlanningButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionPlanning), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionPlanning() {
    if PlanningButton.titleLabel?.text == "Start Planning" {
    Present(ViewController: self, ToViewController: EventPlanningStep1())
    }else{
    NotificationCenter.default.post(name: HomeController.PresentMenu, object: nil)
    }
    }

    lazy var StackProgress : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [NameWeddingLabel,ProgressView])
    Stack.alpha = 0
    Stack.axis = .vertical
    Stack.spacing = 7
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()
    
    var Progress = Float()
    lazy var NameWeddingLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    func SetProgressLabel(_ Progress:Float) {
        let attributedString = NSMutableAttributedString(string: "In Progress  ", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)

        ])
        
        attributedString.append(NSAttributedString(string: "( \(Progress)% )", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.5)
        ]))
        NameWeddingLabel.attributedText = attributedString
    }

    lazy var ProgressView : UIProgressView = {
    let Prog = UIProgressView()
    Prog.tintColor = UIColor(red: 214 / 255, green: 176 / 255, blue: 156 / 255, alpha: 1)
    Prog.trackTintColor = UIColor(red: 102 / 255, green: 90 / 255, blue: 86 / 255, alpha: 1)
    Prog.translatesAutoresizingMaskIntoConstraints = false
    return Prog
    }()

    
    lazy var StackHorizontal : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [ProgressDays,ProgressHours,ProgressMinutes])
    Stack.axis = .horizontal
    Stack.spacing = 5
    Stack.distribution = .fillEqually
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    Stack.alpha = 0
        
    Stack.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
    Stack.arrangedSubviews[0].widthAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
        
    Stack.arrangedSubviews[1].heightAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
    Stack.arrangedSubviews[1].widthAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
        
    Stack.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
    Stack.arrangedSubviews[2].widthAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
    return Stack
    }()
    
    lazy var ProgressDays : CircularProgressBar = {
        let View = CircularProgressBar()
        View.ViewSlider.trackFillColor = UIColor(red: 152/255, green: 93/255, blue: 86/255, alpha: 1)
        View.ViewSlider.minimumValue = 0
        View.ViewSlider.maximumValue = 365
        View.labelNumber.text = "\(0)"
        View.ViewSlider.endPointValue = 0
        View.labelTitel.text = "Days"
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ProgressHours : CircularProgressBar = {
        let View = CircularProgressBar()
        View.ViewSlider.trackFillColor = UIColor(red: 232/255, green: 199/255, blue: 199/255, alpha: 1)
        View.ViewSlider.minimumValue = 0
        View.ViewSlider.maximumValue = 24
        View.labelNumber.text = "\(0)"
        View.ViewSlider.endPointValue = 0
        View.labelTitel.text = "Hours"
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ProgressMinutes : CircularProgressBar = {
        let View = CircularProgressBar()
        View.ViewSlider.trackFillColor = UIColor(red: 237/255, green: 180/255, blue: 174/255, alpha: 1)
        View.ViewSlider.minimumValue = 0
        View.ViewSlider.maximumValue = 60
        View.labelNumber.text = "\(0)"
        View.ViewSlider.endPointValue = 0
        View.labelTitel.text = "Minutes"
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    var EventUpcoming : UpcomingEvent?
    @objc func ScheduledTimer() {
        if let data = defaults.object(forKey: "UpcomingEvent") as? Data {
        if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:Any]  {
        EventUpcoming = UpcomingEvent(dictionary: decodedPeople)
        guard let Date = EventUpcoming?.Date else{return}
        guard let ServerTime = EventUpcoming?.ServerTime else{return}
            
        let currentDate = Date.Formatter().Formatter("yyyy-MM-dd HH:mm")
        let previousDate = ServerTime.Formatter().Formatter("yyyy-MM-dd HH:mm")
        timeGapBetweenDates(previousDate: previousDate, currentDate: currentDate)
        }
        }
    }

    func timeGapBetweenDates(previousDate : String,currentDate : String) {

        let Dateformatter = DateFormatter()
        Dateformatter.dateFormat = "yyyy-MM-dd HH:mm"

        let date1 = Dateformatter.date(from: previousDate)
        let date2 = Dateformatter.date(from: currentDate)
        
        if let distanceBetweenDates: TimeInterval = date2?.timeIntervalSince(date1!) {
        let days = Int(distanceBetweenDates / 86400)
        let Hour = Int(distanceBetweenDates / 3600)-Int(days*24)
        let Min = Int(distanceBetweenDates / 60)-Int(Hour*60)-Int(days*24*60)
            
        updateDays(Days:days)
        updateHours(hours:Hour)
        updateMinute(minute:Min)
        if days == 0 && Hour == 0 && Min == 0{
        timer.invalidate()
        }
        }
    }
    
    func updateMinute(minute:Int) {
        ProgressMinutes.ViewSlider.endPointValue = CGFloat(minute)
        ProgressMinutes.labelNumber.text = "\(minute)"
    }
    
    func updateHours(hours:Int) {
        ProgressHours.ViewSlider.endPointValue = CGFloat(hours)
        ProgressHours.labelNumber.text = "\(hours)"
    }
    
    func updateDays(Days:Int) {
        ProgressDays.ViewSlider.endPointValue = CGFloat(Days)
        ProgressDays.labelNumber.text = "\(Days)"
    }
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = ControlWidth(50)
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.register(ProfileCell.self, forCellReuseIdentifier: CellId)
        return tv
    }()
    
    lazy var FemaleImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "image39")
        return ImageView
    }()

}

extension ProfileController : UITableViewDelegate , UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! ProfileCell
        cell.Delegate = self
        cell.selectionStyle = .none
        cell.ProfileLabel.text = ProfileTitleArray[indexPath.row]
        cell.ProfileImage.image = UIImage(named: ProfileImageArray[indexPath.row])
        return cell
    }

    func ActionView(cell:ProfileCell) {
    if let indexPath = TableView.indexPath(for: cell) {
        switch indexPath.row {
        case 0:
        Present(ViewController: self, ToViewController: MyEventsVC())
        case 1:
        Present(ViewController: self, ToViewController: SavedVC())
        case 2:
        Present(ViewController: self, ToViewController: CartVC())
        case 3:
        let MyPlaces = MyPlacesVC()
        MyPlaces.IfIsSelectHidden = true
        MyPlaces.Dismiss.TextDismiss = "My Places"
        Present(ViewController: self, ToViewController: MyPlaces)
        case 4:
        Present(ViewController: self, ToViewController: SettingsVC())
        case 5:
        Present(ViewController: self, ToViewController: ContactUsVC())
        case 6:
        Present(ViewController: self, ToViewController: SignUpAsSupplier())
        case 7:
        ShowMessageAlert("𝗶", "LOGOUT", "Are You Sure You Want to\nlog out of your account", false, self.ActionLogout, "Logout")
        default: break}
    }
    }

    @objc func ActionLogout() {
        ProgressHud.beginRefreshing()
        do {
        try Auth.auth().signOut()
            
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
        }
            
        if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.ProgressHud.endRefreshing() {
        FirstController(SignInController())
        }
        }
    
        }catch let signOutErr {
        self.ProgressHud.endRefreshing(signOutErr.localizedDescription, .error) {}
        }
    }
    
    @objc func GetProfile() {
        guard let url = defaults.string(forKey: "API") else{return}
        guard let token = defaults.string(forKey: "JWT") else{return}
        let api = "\(url + PhoneGetProfile)"
            
        guard let SqlId = LaunchScreen.User?.SqlId else{return}
        guard let Uid = LaunchScreen.User?.Uid else{return}
      
        let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                         "Platform": "I",
                                         "SqlId": SqlId,
                                         "Uid": Uid]
    
        self.ProgressHud.beginRefreshing()
        PostAPI(api: api, token: token, parameters: parameters) { _ in
        } DictionaryData: { data in
            
        self.ObjectProfile = ProfileObject(dictionary: data)
        let UserData = self.ObjectProfile?.user ?? [String:Any]()
        let CartData = self.ObjectProfile?.Cart ?? [String:Any]()
        LaunchScreen.LoadingSaveData(UserUpdate: UserData, CartUpdate: CartData){}
            
        self.ProgressHud.endRefreshing() {}
        self.ViewScroll.refreshControl?.endRefreshing()
        } ArrayOfDictionary: { _ in
        } Err: { error in
        self.ViewScroll.refreshControl?.endRefreshing()
                        
        if error != "" {
        self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetProfile)}
        }
        }
        
    }
    
    @objc func Refresh() {
    LodCore()
    GetProfile()
    LodProfileImage()
    LodProfileName()
    ScheduledTimer()
    }
    
    func LodProfileImage() {
    guard let Photo = LaunchScreen.User?.Photo else{return}
    ProfileImage.sd_setImage(with: URL(string: Photo), placeholderImage: UIImage(named: "User"))
    }
    
    func LodProfileName() {
    let fName = LaunchScreen.User?.fName ?? ""
    self.EditProfile.setTitle("Hello,\(fName)  ", for: .normal)
    }

    
    func LodCore() {
        
    if LaunchScreen.User?.gender ?? 0 == 1 {
    self.FemaleImage.alpha = 0
    BackgroundProfile.backgroundColor = .white
    BackgroundProfile.image = UIImage(named: "Male")
    }else{
    self.FemaleImage.alpha = 1
    BackgroundProfile.image = UIImage(named: "Female")?.withInset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: ControlWidth(47)))
    BackgroundProfile.backgroundColor = UIColor(red: 245 / 255, green: 240 / 255, blue: 237 / 255, alpha: 1)
    }

    let Progress = Float(LaunchScreen.Cart?.CompletedRat ?? 0)
    ProgressView.setProgress(Progress / 100, animated: true)
    SetProgressLabel(Progress)
          
    if Progress == 0 {
    PlanningLabel.frame = CGRect(x: ControlX(40), y: ControlX(42), width: ControlWidth(255), height: ControlWidth(42))
    PlanningButton.frame = CGRect(x: ControlX(40), y: PlanningLabel.frame.maxY + ControlX(10), width: ControlWidth(255), height: ControlWidth(42))
        
    StackProgress.alpha = 0
    PlanningButton.alpha = 1
    StackHorizontal.alpha = 0
    PlanningLabel.text = "You don’t have any events yet"
    PlanningButton.setTitle("Start Planning", for: .normal)
    
    }else if Progress == 100 {
    StackProgress.alpha = 0
    PlanningButton.alpha = 0
    StackHorizontal.alpha = 1
        
    PlanningLabel.frame = CGRect(x: ControlX(40), y: ControlX(5), width: ControlWidth(255), height: ControlWidth(42))
    PlanningLabel.text = "Happily ever after starts here"
    }else{
    PlanningLabel.frame = CGRect(x: ControlX(40), y: ControlX(10), width: ControlWidth(255), height: ControlWidth(40))
    StackProgress.frame = CGRect(x: ControlX(40), y: PlanningLabel.frame.maxY + ControlY(10), width: ControlWidth(255), height: ControlWidth(30))
    PlanningButton.frame = CGRect(x: ControlX(40), y: StackProgress.frame.maxY + ControlY(30), width: ControlWidth(255), height: ControlWidth(42))
      
    PlanningButton.alpha = 1
    StackProgress.alpha = 1
    StackHorizontal.alpha = 0
    PlanningLabel.text = LaunchScreen.Cart?.Title ?? ""
    PlanningButton.setTitle("Continue Planning", for: .normal)

    }

    }
}
