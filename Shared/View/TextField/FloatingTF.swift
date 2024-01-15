//
//  File.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit

class FloatingTF: UITextField , UITextFieldDelegate {
        
  var floatingTitleLabelHeight = CGFloat()
  var bottomLineLayer = CALayer()
  let animationDuration = 0.3
  var isFloatingTitleHidden = true
  var title = UILabel()
  var bubbleLayer = CAShapeLayer()

  required init?(coder aDecoder:NSCoder) {
    super.init(coder:aDecoder)
    setup()
  }
  
  override init(frame:CGRect) {
    super.init(frame:frame)
    setup()
  }
    
  fileprivate func setup() {
    borderStyle = UITextField.BorderStyle.none
    self.delegate = self
    self.clipsToBounds = false
    title.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    self.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    self.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    self.font = UIFont(name: "Raleway-Regular", size: ControlWidth(15))
    self.backgroundColor = .clear
    self.autocorrectionType = .no
    self.keyboardAppearance = .light
    self.clearButtonMode = .whileEditing
    self.translatesAutoresizingMaskIntoConstraints = false
      
//    self.text?.changeToEnglish()
    if #available(iOS 12.0, *) {
    self.textContentType = .oneTimeCode
    }
    
    // Set up title label
    title.alpha = 0.0
    title.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
    if let str = placeholder , !str.isEmpty {
    title.text = str.capitalized
    title.sizeToFit()
    }
    self.addSubview(title)
    self.layer.addSublayer(bottomLineLayer)
  }
    
    let Icon = ButtonNotEnabled()
    @IBInspectable var IconImage : UIImage? {
        didSet {
            let Image = IconImage?.withInset(UIEdgeInsets(top: ControlY(1.5), left: ControlX(1.5), bottom: ControlY(1.5), right: 0))
            Icon.setBackgroundImage(Image, for: .normal)
        }
    }
    
    func SetUpIcon(LeftOrRight:Bool , Width:CGFloat = 23 ,Height :CGFloat = 22) {
    Icon.tintColor = .black
    Icon.backgroundColor = .clear
    Icon.translatesAutoresizingMaskIntoConstraints = false
    addSubview(Icon)
        
    if LeftOrRight {
    Icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(2)).isActive = true
    self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(Width), height: self.frame.height))
    self.leftViewMode = .always
    }else{
    Icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-2)).isActive = true
    self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(Width), height: self.frame.height))
    self.rightViewMode = .always
    }
        
    Icon.centerYAnchor.constraint(equalTo: self.centerYAnchor ,constant: ControlY(2)).isActive = true
    Icon.widthAnchor.constraint(equalToConstant: ControlWidth(Width)).isActive = true
    Icon.heightAnchor.constraint(equalToConstant: ControlWidth(Height)).isActive = true

    }
    
  @IBInspectable var TitleHidden : Bool = true
  @IBInspectable var enableFloatingTitle : Bool = true
  @IBInspectable var activeBottomLineColor:UIColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1) {
    didSet {
      if isFirstResponder {
        bottomLineLayer.backgroundColor = activeBottomLineColor.cgColor
      }
    }
  }
    
    @IBInspectable var FieldHeight:CGFloat = ControlWidth(30) {
    didSet {
    self.heightAnchor.constraint(equalToConstant: FieldHeight).isActive = true
    self.floatingTitleLabelHeight = FieldHeight - 10
    }
  }
    
    @IBInspectable var inactiveBottomLineColor:UIColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.7) {
    didSet {
    if !isFirstResponder {
    bottomLineLayer.backgroundColor = inactiveBottomLineColor.cgColor
    }
    }
  }
    
   override func layoutSubviews() {
    super.layoutSubviews()
    
    setBottomLineLayerFrame()
    
    let isActive = isFirstResponder
    if isActive {
    bottomLineLayer.backgroundColor = activeBottomLineColor.cgColor
    bubbleLayer.removeFromSuperlayer()
        
    if self.keyboardType == .emailAddress {
    self.addTarget(self, action: #selector(NoErrorEmail), for: .editingChanged)
    }
    if self.isSecureTextEntry == true {
    self.addTarget(self, action: #selector(NoErrorPassword), for: .editingChanged)
    }
    }
    if !isActive {
    bottomLineLayer.backgroundColor = inactiveBottomLineColor.cgColor
    View.dismiss()
    }
       
    if let txt = text , txt.isEmpty {
    View.dismiss()
    }
    
    if !TitleHidden {
    if let txt = text , txt.isEmpty {
      // Hide
    if !isFloatingTitleHidden {
    hideTitle()
    }
    } else if enableFloatingTitle{
    setTitleFrame()
    // Show
    showTitle()
    }
    }
  }

    /// setBottomLineLayerFrame( - Description:
    private func setBottomLineLayerFrame() {
    bottomLineLayer.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: ControlWidth(1))
    }
  
  fileprivate func showTitle() {
    UIView.animate(withDuration: animationDuration) {
    // Animation
    self.title.text = self.placeholder
    self.title.alpha = 1.0
    var r = self.title.frame
    r.origin.y = -(CGFloat)(self.TitleLabelY)
    self.title.frame = r
    self.isFloatingTitleHidden = false
    } completion: { _ in
    }
  }
  
  fileprivate func hideTitle() {
    self.isFloatingTitleHidden = true
    UIView.animate(withDuration: animationDuration) {
      // Animation
      self.title.alpha = 0.0
      var r = self.title.frame
      r.origin.y = self.title.font.lineHeight + 0
      self.title.frame = r
    } completion: { _ in
    }
  }

    /// setTitleFrame( - Description:
    var TitleLabelY = ControlY(15)
    private func setTitleFrame() {
    self.title.frame = CGRect(x: 0, y: -TitleLabelY, width: self.frame.size.width, height: floatingTitleLabelHeight)
    }
    
    @objc func NoErrorEmail() -> Bool {
    if isValidEmail(emailID: self.text ?? "") == false {
    View.Label.text = "Please enter your\nemail properly"
    if View.alpha == 0 {
    View.show(from: CGRect(x: self.bounds.size.width / 2, y: ControlY(-20), width: ControlWidth(90), height: ControlWidth(28)), inContainerView: self)
    }
    return false
    }else{
    self.View.dismiss()
    return true
    }
    }

    @objc func NoErrorPassword() -> Bool {
    if (self.text?.count) ?? 0 < 6 {
    View.Label.text = "The password must not be\nless than six digits"
    if View.alpha == 0 {
    View.show(from: CGRect(x: self.bounds.size.width / 2, y: ControlY(-20), width: ControlWidth(90), height: ControlWidth(28)), inContainerView: self)
    }
    return false
    }else{
    self.View.dismiss()
    return true
    }
    }
    
    func NoError() -> Bool {
    if self.text?.TextNull() == false {
    if !self.isFirstResponder {
    self.becomeFirstResponder()
    self.Show()
    }
    return false
    }else{
    return true
    }
    }
    
    var timr = Timer()
    func Show() {
    View.Label.text = "Empty data cannot be registered"
    View.show(from: CGRect(x: self.bounds.size.width / 2, y: ControlY(-10), width: ControlWidth(90), height: ControlWidth(28)), inContainerView: self)

    self.Shake()
    timr.invalidate()
    self.timr = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.Time), userInfo: nil, repeats: true)
    }
    
    @objc func Time() {
    self.View.dismiss()
    self.timr.invalidate()
    }
    
    func isValidEmail(emailID:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with:emailID)
    }
    
    lazy var View : SHAutocorrectSuggestionView = {
        let View = SHAutocorrectSuggestionView(frame: CGRect(x: self.bounds.size.width / 2, y: ControlY(-10), width: ControlWidth(90), height: ControlWidth(28)))
        View.backgroundColor = .clear
        View.alpha = 0
        return View
    }()

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.keyboardType == .numberPad {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
        }
        return true
    }


}

