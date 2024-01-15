//
//  SignInController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

class SignInController: ViewController {

    var ModelData : Model?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetUp()
        LodBaseUrl()
    }
    
    func SetUp() {
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = view.bounds
        
        LogoImage.frame = CGRect(x: view.center.x - ControlWidth(62.5), y:  ControlY(35), width: ControlWidth(125), height: ControlWidth(125))
        ViewScroll.addSubview(LogoImage)

        ContentView.frame = CGRect(x: ControlX(15), y: LogoImage.frame.maxY + ControlX(20), width: view.frame.width - ControlWidth(30), height: ControlWidth(366))
        ViewScroll.addSubview(ContentView)

        ContinueASGuest.frame = CGRect(x: ControlX(60), y: ContentView.frame.maxY + ControlY(15), width: view.frame.width - ControlWidth(120), height: ControlHeight(30))
        ViewScroll.addSubview(ContinueASGuest)

        ViewLine.frame = CGRect(x: ControlX(30), y: view.frame.maxY - ControlY(60), width: view.frame.width - ControlWidth(60), height:ControlHeight(0.6))
        ViewScroll.addSubview(ViewLine)

        SignUpAssupplier.frame = CGRect(x: ControlX(50), y: view.frame.maxY - ControlY(45), width: view.frame.width - ControlWidth(100), height: ControlHeight(30))
        ViewScroll.addSubview(SignUpAssupplier)

        let StackHorizontal = UIStackView(arrangedSubviews: [UIView(),Twitter,Google,Facebook,Apple,UIView()])
        StackHorizontal.axis = .horizontal
        StackHorizontal.distribution = .fillEqually

        StackHorizontal.alignment = .fill
        StackHorizontal.backgroundColor = .clear

        if #available(iOS 13.0, *) {
            Apple.isHidden = false
            StackHorizontal.spacing = ControlWidth(5)
        }else{
            Apple.isHidden = true
            StackHorizontal.spacing = ControlWidth(15)
        }

        let StackForgotPassword = UIStackView(arrangedSubviews: [ForgotPassword,UIView()])
        StackForgotPassword.axis = .horizontal
        StackForgotPassword.distribution = .equalCentering
        StackForgotPassword.alignment = .fill
        StackForgotPassword.backgroundColor = .clear

        let StackVertical = UIStackView(arrangedSubviews: [SignInLabel,EmailTextField,PasswordTextField,StackForgotPassword,SignIn,OrSignInUsing,StackHorizontal,SignUpNow])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlHeight(3)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.backgroundColor = .clear

        StackVertical.frame = CGRect(x: ControlX(30), y: ControlY(10), width: ContentView.frame.width - ControlWidth(60), height: ControlWidth(345))
        ContentView.addSubview(StackVertical)
        
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

    lazy var SignInLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Sign In"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(20))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var EmailTextField : FloatingTF = {
        let tf = FloatingTF()
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
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
            PasswordTextField.IconImage = UIImage(named: "visibility")
        }else{
            PasswordTextField.isSecureTextEntry = true
            PasswordTextField.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    lazy var ForgotPassword : UIButton = {
        let Button = UIButton(type: .system)
        let underlinedMessage = NSMutableAttributedString(string: "Forgot password?", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(12)) ?? UIFont.systemFont(ofSize: ControlWidth(12)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1),
            NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue
            ])
        
        Button.setAttributedTitle(underlinedMessage, for: .normal)
        Button.contentHorizontalAlignment = .left
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionForgotPasswor), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionForgotPasswor() {
    Present(ViewController: self, ToViewController: ResetPassword())
    }
    
    
    lazy var SignIn : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Sign In", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionSignIn), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignIn() {
    if EmailTextField.NoError() && PasswordTextField.NoError() && PasswordTextField.NoErrorPassword() && EmailTextField.NoErrorEmail() {
                
    guard let url = defaults.string(forKey: "API") else{return}
    let loginApi = "\(url + S_login)"
        
    ProgressHud.beginRefreshing()
    guard let email = EmailTextField.text else {return}
    guard let password = PasswordTextField.text else {return}
    
    Auth.auth().signIn(withEmail: email, password: password) { (user, err) in

    if let err = err {
    self.ProgressHud.endRefreshing(err.localizedDescription, .error) {}
    return
    }
        
    guard let UID = user?.user.uid else{return}

    let parameters:[String:Any] = [
                    "AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                    "Platform": "I",
                    "Email": email,
                    "Uid": UID,
                    "Version":"1"]
    
    PostAPI(api: loginApi, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    
    defaults.set("E", forKey: "SocialLogin")
        
    self.ModelData = Model(dictionary: data)
    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}
        
    self.ProgressHud.endRefreshing() {
    FirstController(TabBarController())
    }
        
    } ArrayOfDictionary: { _ in
    } Err: { (error) in
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.TryAgainSignIn)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }
    }
        
    }
    }
    }
    
    @objc func TryAgainSignIn() {
    ActionSignIn()
    }
    
    lazy var OrSignInUsing: UILabel = {
        let Label = UILabel()
        Label.text = "Or sign in using"
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Light" ,size: ControlWidth(12))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()


    lazy var Twitter : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setImage(UIImage(named: "twitter"), for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionTwitter), for: .touchUpInside)
        return Button
    }()
        
    var provider:OAuthProvider?
    let firebase = Auth.auth()
    @objc func ActionTwitter() {
    SignInTwitter()
    }
    
    
    lazy var Google : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setImage(UIImage(named: "google"), for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionGoogle), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionGoogle() {
    SignInGoogle()
    }
    
    
    lazy var Facebook : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setImage(UIImage(named: "facebook-2"), for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionFacebook), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionFacebook() {
    SignFacebook()
    }
    
    lazy var Apple : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setImage(UIImage(named: "apple"), for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionApple), for: .touchUpInside)
        return Button
    }()
    
    fileprivate var currentNonce: String?
    @objc func ActionApple() {
    #if canImport(CryptoKit)
    if #available(iOS 13.0, *) {
    Action()
    } else {
    print("Fallback on earlier versions")
    }
    #endif
    }
    
    ///
    func LoginSocial(_ uid:String ,_ Social:String ,_ email:String ,_ phone:String ,_ ProfileUrl:URL? ,_ lastName:String ,_ firstName:String) {
        
    if let url = defaults.string(forKey: "API") {
    let loginSocial = "\(url + PhoneloginSocial)"
        
    let parameters:[String:Any] = [
                        "AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                        "Platform": "I",
                        "Uid": uid]

    PostAPI(api: loginSocial, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
        
    self.ModelData = Model(dictionary: data)
    let IsUser = self.ModelData?.IsUser ?? false
        
    self.IfIsUser(IsUser,uid,Social,email,phone,ProfileUrl,lastName,firstName)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    error != "" ? self.ProgressHud.endRefreshing(error, .error) {}:self.ProgressHud.endRefreshing() {}
    }
    }
    }
    
    func IfIsUser(_ IsUser:Bool,_ uid:String ,_ Social:String ,_ email:String ,_ phone:String ,_ ProfileUrl:URL? ,_ lastName:String ,_ firstName:String) {
    if !IsUser {
    let SignUp = SignUpController()
    SignUp.uid = uid
    SignUp.ProfileImageUrl = ProfileUrl
    SignUp.EmailTextField.text = email
    SignUp.LastNameTF.text = lastName
    SignUp.FirstNameTF.text = firstName
    SignUp.PhoneNumberTF.text = phone
        
    defaults.set(Social, forKey: "SocialLogin")
    SignUp.SignUpLabel.text = "Complete Sign Up Information"
    self.Present(ViewController: self, ToViewController: SignUp)

    self.ProgressHud.endRefreshing() {}
    }else{
    self.ProgressHud.endRefreshing() {
    LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}
    FirstController(TabBarController())
    }
    }
    }
    
    
    lazy var SignUpNow : UIButton = {
        let Button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "New member? Sign Up now.", attributes: [
        .font: UIFont(name: "Raleway-Bold", size: ControlWidth(12.0)) ?? UIFont.systemFont(ofSize: ControlWidth(12.0)),
        .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 215.0 / 255.0, green: 177.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0), range: NSRange(location: 12, length: 8))
        Button.setAttributedTitle(attributedString, for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionSignUpNow), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignUpNow() {
    let SignUp = SignUpController()
    SignUp.SignUpLabel.text = "Sign Up"
    Present(ViewController: self, ToViewController: SignUp)
    }
    
    
    lazy var ContinueASGuest : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setImage(UIImage(named: "right-arrow"), for: .normal)
        Button.setTitle("Continue as a guest  ", for: .normal)
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .center
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
        Button.semanticContentAttribute = .forceRightToLeft
        Button.addTarget(self, action: #selector(ActionContinueASGuest), for: .touchUpInside)
        Button.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Button.setTitleColor(UIColor(red:99 / 255, green:87 / 255, blue:82 / 255, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionContinueASGuest() {
    
    guard let url = defaults.string(forKey: "API") else{return}
    let GuestMain = "\(url + GetGuestMainScreen)"
            
    ProgressHud.beginRefreshing()
    let parameters:[String : Any] = ["Token":"]dF1)Ph{UJ?>pK1",
                                     "AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                     "Platform": "I"]
        
    PostAPI(api: GuestMain, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in

    self.ModelData = Model(dictionary: data)
    self.ProgressHud.endRefreshing() {
    FirstController(TabBarController())
    }
        
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GuestMainTryAgain)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }
    }
    }
    
    @objc func GuestMainTryAgain() {
    ActionContinueASGuest()
    }
    
    lazy var ViewLine : UIView = {
    let View = UIView()
    View.backgroundColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.5)
    return View
    }()

    
    lazy var SignUpAssupplier : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        let attributedString = NSMutableAttributedString(string: "Are you a supplier? Sign Up as supplier", attributes: [
        .font: UIFont(name: "Raleway-Bold", size: ControlWidth(12.0)) ?? UIFont.systemFont(ofSize: ControlWidth(12.0)),
        .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 215.0 / 255.0, green: 177.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0), range: NSRange(location: 20, length: 19))
        Button.setAttributedTitle(attributedString, for: .normal)
        Button.addTarget(self, action: #selector(ActionSignUpAssupplier), for: .touchUpInside)
        return Button
    }()
    
     @objc func ActionSignUpAssupplier() {
     Present(ViewController: self, ToViewController: SignUpAsSupplier())
    }
}


// Sign in twitter
extension SignInController {
public func SignInTwitter() {
    provider = OAuthProvider(providerID: "twitter.com")
    provider?.getCredentialWith(nil) { (credential, err) in
    if let err = err {
    self.ProgressHud.endRefreshing(err.localizedDescription, .error) {}
    return
    }
        
    guard let cred  = credential else {return}
    self.ProgressHud.beginRefreshing()
    self.firebase.signIn(with: cred) { (data, err) in
    if let err = err {
    self.ProgressHud.endRefreshing(err.localizedDescription, .error) {}
    return
    }
                
    if let data = data {
    let uid = data.user.uid
    let photoURL = data.user.photoURL ?? URL(string: "")
    let displayName = data.user.displayName ?? ""
    let email = data.user.email ?? ""
    let phone = data.user.phoneNumber ?? ""
//  print(data.user.providerID)
//  print(newCred.accessToken ?? "")
//  print(newCred.secret ?? "")
//  print(data.user.isEmailVerified)
//  print(data.user.metadata.creationDate ?? "")
        
    self.LoginSocial(uid, "T", email , phone ,photoURL , "", displayName)
    }
    }
    }
}
}

// Sign in Google
extension SignInController {
    func SignInGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in

        if error != nil {
        return
        }
            
        guard let accessToken = user?.user.accessToken.tokenString , let idToken = user?.user.idToken?.tokenString
        else {
        return
        }

        guard let User = user?.user.profile else { return }
        let emailAddress = User.email
        let givenName = User.givenName ?? ""
        let familyName = User.familyName ?? ""
        let profilePicUrl = User.imageURL(withDimension: 320)
    //  let fullName = user.name

            
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
        Auth.auth().signIn(with: credential) { authResult, error in
        self.ProgressHud.beginRefreshing()
        if let error = error {
        self.ProgressHud.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        guard let uid = authResult?.user.uid else { return }
        self.LoginSocial(uid, "G", emailAddress ,"" , profilePicUrl , familyName, givenName)

        }
        }
    }
}
// Sign in Facebook
extension SignInController {
    func SignFacebook() {
        LoginManager().logIn(permissions: ["email"], from: self) { (result,err) in
        if let error = err {
        self.ProgressHud.endRefreshing(error.localizedDescription, .error) {}
        return
        }
            
        if result?.isCancelled == true {return}
        guard let accessToken = AccessToken.current else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)

        Auth.auth().signIn(with: credential) { authResult, error in
        if let error = error {
        self.ProgressHud.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        self.ProgressHud.beginRefreshing()
        GraphRequest(graphPath: "/me", parameters: ["fields": "email, first_name, last_name, name, picture.width(480).height(480)"]).start { (connection,result,err) in
        if let Error = err {
        self.ProgressHud.endRefreshing(Error.localizedDescription, .error) {}
        return
        }
        if let data = result as? NSDictionary {

        guard let uid = authResult?.user.uid else { return }
        let firstName  = data.object(forKey: "first_name") as? String ?? ""
        let lastName  = data.object(forKey: "last_name") as? String ?? ""
        let email = data.object(forKey: "email") as? String ?? ""

        let profilePictureObj = data.object(forKey: "picture") as? NSDictionary
        let data = profilePictureObj?.value(forKey: "data") as? NSDictionary
        let pictureUrlString = data?.value(forKey: "url") as? String
        let pictureUrl = URL(string: pictureUrlString ?? "")

        self.LoginSocial(uid, "F", email ,"" ,pictureUrl , lastName, firstName)
      }
      }
      }
      }
    }
}


// Sign in Apple
#if canImport(CryptoKit)
import CryptoKit
@available(iOS 13.0, *)
extension SignInController: ASAuthorizationControllerDelegate {

   func Action() {
       let appleIDProvider = ASAuthorizationAppleIDProvider()
       let request = appleIDProvider.createRequest()
       request.requestedScopes = [.fullName, .email]

       self.currentNonce = randomNonceString()
       request.nonce = sha256(currentNonce!)

       let authorizationController = ASAuthorizationController(authorizationRequests: [request])
       authorizationController.delegate = self
       authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
       authorizationController.performRequests()
   }

   private func sha256(_ input: String) -> String {
       let inputData = Data(input.utf8)
       let hashedData = SHA256.hash(data: inputData)
       let hashString = hashedData.compactMap {
           return String(format: "%02x", $0)
       }.joined()
       
       return hashString
   }
   
   private func randomNonceString(length: Int = 32) -> String {
     precondition(length > 0)
     let charset: [Character] =
       Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
     var result = ""
     var remainingLength = length

     while remainingLength > 0 {
       let randoms: [UInt8] = (0 ..< 16).map { _ in
         var random: UInt8 = 0
         let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
         if errorCode != errSecSuccess {
           fatalError(
             "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
           )
         }
         return random
       }

       randoms.forEach { random in
         if remainingLength == 0 {
           return
         }

         if random < charset.count {
           result.append(charset[Int(random)])
           remainingLength -= 1
         }
       }
     }

     return result
   }
   
 func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
   if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
     guard let nonce = currentNonce else {
       fatalError("Invalid state: A login callback was received, but no login request was sent.")
     }
     guard let appleIDToken = appleIDCredential.identityToken else {
       print("Unable to fetch identity token")
       return
     }
     guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
       print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
       return
     }
       
     self.ProgressHud.beginRefreshing()
     let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                               idToken: idTokenString,
                                               rawNonce: nonce)
       
       Auth.auth().signIn(with: credential) { (authResult, error) in
       if let error = error {
       self.ProgressHud.endRefreshing(error.localizedDescription, .error) {}
       return
       }
         
       if let user = authResult?.user {
       let Name = user.displayName ?? ""
       let email = user.email ?? ""
       let uid = user.uid
       let photo = user.photoURL
       let phone = user.phoneNumber ?? ""
           
       self.LoginSocial(uid, "A", email ,phone, photo, "", Name)
       }
     }
   
   }
 }

 func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
   print("Sign in with Apple errored: \(error)")
 }

}
#endif
