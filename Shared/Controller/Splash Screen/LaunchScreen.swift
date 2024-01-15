//
//  LaunchScreen.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 11/07/2021.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class LaunchScreen: ViewController {

    var ModelData : Model?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        SetUp()
    }
    
    func SetUp() {
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        LogoImage.frame = CGRect(x: ControlX(15), y: view.center.y - ControlY(170), width: view.frame.width - ControlWidth(15), height: ControlHeight(340))
        view.addSubview(LogoImage)
        
        DispatchQueue.main.async {
        self.GetScreen()
        self.ActionLogout()
        }
    }

    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "group31203")
        return ImageView
    }()
    
    lazy var LogoImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.image = UIImage(named: "group26396")
        ImageView.MotionEffect()
        return ImageView
    }()


    func GetScreen() {
    if defaults.string(forKey: "JWT") != nil {
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + GetMainScreen)"
        
        
    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}
    guard let SqlId = LaunchScreen.User?.SqlId else{return}
    guard let Uid = LaunchScreen.User?.Uid else{return}
        
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                     "Platform": "I",
                                     "SqlId": SqlId,
                                     "Uid": Uid]
        
    PostAPI(api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.ModelData = Model(dictionary: data)
    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}
    self.perform(#selector(self.PresentView), with: self, afterDelay: 1)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}
    self.perform(#selector(self.PresentView), with: self, afterDelay: 1)
    }
    }

    }
    }
    
    @objc func PresentView() {
        
    let Controller = defaults.string(forKey: "JWT") == nil ? UINavigationController(rootViewController: SignInController()) : UINavigationController(rootViewController: TabBarController())
    Controller.navigationBar.isHidden = true
    Controller.modalPresentationStyle = .overCurrentContext
    Controller.modalTransitionStyle = .crossDissolve
    present(Controller, animated: true)
    }
    
    @objc func ActionLogout() {
        if defaults.string(forKey: "JWT") == nil {
        do {
        try Auth.auth().signOut()
            
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
        }
            
        if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
           
        self.perform(#selector(self.PresentView), with: self, afterDelay: 3)
        }catch let signOutErr {
        print(signOutErr)
        }
        }
    }
    
    
    static var User : user?
    static var Cart : cart?
    static func LoadingSaveData(UserUpdate:[String : Any]? ,CartUpdate:[String : Any]? , _ selector: @escaping () -> Void) {
    if let UserData = UserUpdate {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: UserData)
    LaunchScreen.User = user(dictionary: UserData)
    defaults.set(encodedData, forKey: "User")
    defaults.synchronize()
    }else{
    if let UserData = defaults.object(forKey: "User") as? Data {
    if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: UserData) as? [String:Any] {
    LaunchScreen.User = user(dictionary: decodedPeople)
    }
    }
    }
        
    if let CartData = CartUpdate {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: CartData)
    LaunchScreen.Cart = cart(dictionary: CartData)
    selector()
    defaults.set(encodedData, forKey: "Cart")
    defaults.synchronize()
    }else{
    if let CartData = defaults.object(forKey: "Cart") as? Data {
    if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: CartData) as? [String:Any] {
    LaunchScreen.Cart = cart(dictionary: decodedPeople)
    selector()
    }
    }
    }
        
        
    }
    
    
}

