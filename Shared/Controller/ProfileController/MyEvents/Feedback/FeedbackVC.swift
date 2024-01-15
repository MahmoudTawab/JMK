//
//  FeedbackVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 29/07/2021.
//

import UIKit

class FeedbackVC: ViewController {
    
    var EvintId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
    }
    
    func SetUp() {
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = view.bounds
        
        ViewScroll.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(5), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        ViewScroll.addSubview(ContentView)
        ContentView.frame = CGRect(x: ControlX(15), y: ControlX(80), width: view.frame.width - ControlWidth(30) , height: view.frame.height - ControlWidth(220))
        
        ContentView.addSubview(TitleLabel)
        TitleLabel.frame = CGRect(x: ControlX(20), y: ControlX(20), width: ContentView.frame.width - ControlWidth(40), height: ControlWidth(25))
        
        ContentView.addSubview(ViewStep)
        ViewStep.frame = CGRect(x: ControlX(10), y: TitleLabel.frame.maxY + ControlX(20), width: ContentView.frame.width - ControlWidth(20), height: ControlWidth(120))
        
        ContentView.addSubview(StackRating)
        StackRating.topAnchor.constraint(equalTo: ViewStep.bottomAnchor, constant: ControlX(20)).isActive = true
        StackRating.leftAnchor.constraint(equalTo: ContentView.leftAnchor, constant: ControlX(15)).isActive = true
        StackRating.widthAnchor.constraint(equalTo: ContentView.widthAnchor, multiplier: 1/1.6).isActive = true
        StackRating.bottomAnchor.constraint(equalTo: ContentView.bottomAnchor, constant: ControlX(-10)).isActive = true
        
        ContentView.addSubview(StackTextField)
        StackTextField.topAnchor.constraint(equalTo: ViewStep.bottomAnchor, constant: ControlX(20)).isActive = true
        StackTextField.leftAnchor.constraint(equalTo: ContentView.leftAnchor, constant: ControlX(15)).isActive = true
        StackTextField.rightAnchor.constraint(equalTo: ContentView.rightAnchor, constant: ControlX(-15)).isActive = true
        StackTextField.bottomAnchor.constraint(equalTo: ContentView.bottomAnchor, constant: ControlX(-30)).isActive = true

        ViewScroll.addSubview(NextChanges)
        NextChanges.frame = CGRect(x: ControlX(15), y: ContentView.frame.maxY + ControlX(25), width: view.frame.width - ControlWidth(30), height: ControlWidth(50))

    }
            
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Feedback"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    if ViewStep.ViewNumber == 0 {
    self.navigationController?.popViewController(animated: true)
    }else{
    switch NextChanges.tag {
    case 1:
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: []) {
    self.StackRating.alpha = 1
    self.StackTextField.alpha = 0
    self.ContentView.layer.borderWidth = ControlWidth(0.8)
    self.NextChanges.setTitle("Next", for: .normal)
    self.ContentView.frame = CGRect(x: ControlX(15), y: self.Dismiss.frame.maxY + ControlX(10), width: self.view.frame.width - ControlWidth(30) , height:self.view.frame.height - ControlWidth(220))
    self.NextChanges.frame = CGRect(x: ControlX(15), y: self.ContentView.frame.maxY + ControlX(25), width: self.view.frame.width - ControlWidth(30), height: ControlWidth(50))
    self.ViewStep.ViewNumber = 0
    }
    NextChanges.tag = 0
    default:
    return
    }
    UIView.transition(from: ViewScroll, to: ViewScroll, duration: 0.4, options:[.transitionCrossDissolve,.showHideTransitionViews])
    }
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        return Scroll
    }()
    
    lazy var ContentView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        View.layer.borderWidth = ControlHeight(0.8)
        return View
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Event Feedback"
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ViewStep : StepView = {
        let View = StepView()
        View.Label1.text = "Event\nrate"
        View.Label2.text = "Event\nComments"
        View.ViewNumber = 0
        View.ViewNumberTwo()
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var StackRating : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [ViewRating1,ViewRating2,ViewRating3,ViewRating4])
    Stack.axis = .vertical
    Stack.spacing = 30
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    lazy var ViewRating1 : UIRating = {
        let View = UIRating()
        View.SetRating = 5
        View.SetUpTitleLabel(TitleText: "Rate your event")
        return View
    }()
    
    lazy var ViewRating2 : UIRating = {
        let View = UIRating()
        View.SetRating = 5
        View.SetUpTitleLabel(TitleText: "How organized/easy was the process?")
        return View
    }()
    
    lazy var ViewRating3 : UIRating = {
        let View = UIRating()
        View.SetRating = 5
        View.SetUpTitleLabel(TitleText: "How friendly was the staff?")
        return View
    }()
    
    lazy var ViewRating4 : UIRating = {
        let View = UIRating()
        View.SetRating = 5
        View.SetUpTitleLabel(TitleText: "How helpful/useful was the app?")
        return View
    }()

    
    lazy var StackTextField : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [WhatDidYouLike,likeToShare])
    Stack.axis = .vertical
    Stack.alpha = 0
    Stack.spacing = 25
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    lazy var WhatDidYouLike : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "What did you like most about the event?", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var likeToShare : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Is there anything else you’d like to share?", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var NextChanges : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Next", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionNext(_:)), for: .touchUpInside)
        return Button
    }()
    

    @objc func ActionNext(_ Button:UIButton) {
    switch Button.tag {
    case 0:
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: []) {
    self.StackRating.alpha = 0
    self.StackTextField.alpha = 1
    self.ContentView.layer.borderWidth = 0
    self.ContentView.frame = CGRect(x: ControlX(15), y: self.Dismiss.frame.maxY + ControlX(10), width: self.view.frame.width - ControlWidth(30) , height: self.view.frame.height / 2)
    self.NextChanges.frame = CGRect(x: ControlX(15), y: self.ContentView.frame.maxY + ControlX(25), width: self.view.frame.width - ControlWidth(30), height: ControlWidth(50))
    self.NextChanges.setTitle("Skip", for: .normal)
    self.ViewStep.ViewNumber = 1
    }
    Button.tag = 1
    UIView.transition(from: ViewScroll, to: ViewScroll, duration: 0.4, options:[.transitionCrossDissolve,.showHideTransitionViews])
    case 1:
    self.AddFedback()
    default:return
    }
    }
    
    @objc func AddFedback() {
//    guard let Evint = EvintId else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + AddEventFedback)"
//
//
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "SqlId": SqlId,
//                                     "Platform": "I",
//                                     "EvintId": "\(Evint)",
//                                     "EventRate": "\(ViewRating1.Value)",
//                                     "HowOrganized": "\(ViewRating2.Value)",
//                                     "HowFriendly": "\(ViewRating3.Value)",
//                                     "HowHelpful": "\(ViewRating4.Value)",
//                                     "About": WhatDidYouLike.text ?? "",
//                                     "LikeToShare": likeToShare.text ?? ""]

    ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
    self.SetSuccessfully()
    self.ProgressHud.endRefreshing() {}
    }

        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.AddFedback)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }
    
    func SetSuccessfully() {
    let Successfully = ViewSuccessfully()
    Successfully.TextDismiss = ""
    Successfully.GoText = "Go Home"
    Successfully.ImageIcon = "positive-review"
    Successfully.MessageTitle = "Event Feedback"
    Successfully.MessageDetails = "Thank you so much for taking the time to send this! Everyone here at (business name) loves to know that our customers enjoy what we do"
    Successfully.GoToController.addTarget(self, action: #selector(SuccessfullyFeedback), for: .touchUpInside)
    Successfully.modalPresentationStyle = .overFullScreen
    Successfully.modalTransitionStyle = .crossDissolve
    present(Successfully, animated: true)
    }
    
    
    @objc func SuccessfullyFeedback() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
    appDelegate.window?.rootViewController?.dismiss(animated: false)
    appDelegate.window?.makeKeyAndVisible()
    appDelegate.window?.rootViewController = TabBarController()
    }
    }
    

}
