//
//  CheckoutVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 03/08/2021.
//

import UIKit

class CheckoutVC: ViewController {
    
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
        ViewScroll.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
        
        ViewScroll.addSubview(BackgroundView)
        BackgroundView.frame = CGRect(x: ControlX(15), y: 0, width: ViewScroll.frame.width - ControlWidth(30), height: ControlWidth(462))
    
        BackgroundView.addSubview(PaymentLabel)
        PaymentLabel.frame = CGRect(x: ControlX(15), y: ControlX(20), width: BackgroundView.frame.width - ControlWidth(30), height: ControlWidth(30))
        
        let StackVertical = UIStackView(arrangedSubviews: [CardNameTF,CardNumberTF,ExpiryDateTF,CVVTF])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(30)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.clipsToBounds = false
        StackVertical.backgroundColor = .clear
        StackVertical.frame = CGRect(x: ControlX(15), y: PaymentLabel.frame.maxY + ControlX(20), width: BackgroundView.frame.width - ControlWidth(30), height: ControlWidth(357))
        BackgroundView.addSubview(StackVertical)
        
        ViewScroll.addSubview(Purchase)
        Purchase.frame = CGRect(x: ControlX(15), y: BackgroundView.frame.maxY + ControlX(30), width:  BackgroundView.frame.width , height: ControlWidth(50))
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

    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        return View
    }()

    lazy var CardNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Card name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var CardNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.attributedPlaceholder = NSAttributedString(string: "Card number", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    var date : String?
    lazy var ExpiryDateTF : FloatingTF = {
        let tf = FloatingTF()
        tf.FieldHeight = ControlWidth(60)
        tf.IconImage = UIImage(named: "calendar_(2)")
        tf.SetUpIcon(LeftOrRight: false, Width: ControlWidth(25), Height: ControlWidth(28))
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionDate)))
        tf.Icon.addTarget(self, action: #selector(ActionDate), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Date", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    let pickerView = UIDatePicker()
    @objc func ActionDate() {
        
    let PopUp = PopUpDownView()
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(260)
    PopUp.radius = 25

    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.text = "Date Picker"
    Label.textAlignment = .center
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(22))
    Label.translatesAutoresizingMaskIntoConstraints = false
    PopUp.View.addSubview(Label)
    Label.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlY(10)).isActive = true
    Label.leftAnchor.constraint(equalTo: PopUp.View.leftAnchor,constant: ControlX(20)).isActive = true
    Label.rightAnchor.constraint(equalTo: PopUp.View.rightAnchor,constant: ControlX(-20)).isActive = true
    Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
            
    PopUp.View.addSubview(pickerView)
    pickerView.backgroundColor = .white
    pickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlY(50)).isActive = true
    pickerView.leftAnchor.constraint(equalTo: PopUp.View.leftAnchor,constant: ControlX(20)).isActive = true
    pickerView.rightAnchor.constraint(equalTo: PopUp.View.rightAnchor,constant: ControlX(-20)).isActive = true
    pickerView.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true

    present(PopUp, animated: true)
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh : mm a , dd/MM/yyyy"
    let selectedDate: String = dateFormatter.string(from: sender.date)
    ExpiryDateTF.text = selectedDate
        
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: sender.date)
        
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    print(dateFormatter2.string(from: calendar.date(from:components) ?? sender.date))
    }
    
    lazy var CVVTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "CVV", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var PaymentLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Payment"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.textAlignment = .center
        return Label
    }()
    
        
    lazy var Purchase : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Purchase", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionPurchase), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionPurchase() {
    if CardNameTF.NoError() && CardNumberTF.NoError() && ExpiryDateTF.NoError() && CVVTF.NoError() {
    let Successfully = ViewSuccessfully()
    Successfully.TextDismiss = ""
    Successfully.GoText = "Done"
    Successfully.ImageIcon = "income"
    Successfully.MessageTitle = "Payment successful"
    Successfully.MessageDetails = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam."
    Successfully.GoToController.addTarget(self, action: #selector(SuccessfullyInvitations), for: .touchUpInside)
    Successfully.modalPresentationStyle = .overFullScreen
    Successfully.modalTransitionStyle = .crossDissolve
    present(Successfully, animated: true)
    }
    }

    static let Profile = NSNotification.Name(rawValue: "Profile")
    @objc func SuccessfullyInvitations() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
    appDelegate.window?.rootViewController?.dismiss(animated: false)
    appDelegate.window?.makeKeyAndVisible()
    appDelegate.window?.rootViewController = TabBarController()
    NotificationCenter.default.post(name: CheckoutVC.Profile, object: nil)
    }
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Checkout"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
}


