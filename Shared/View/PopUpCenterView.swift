//
//  PopUpCenterView.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 28/07/2021.
//

import UIKit

class PopUpCenterView: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    SetUp()
    ViewPop.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
    self.ViewPop.transform = .identity
    })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.5, animations: {
    self.ViewPop.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }) { (End) in
    self.ViewPop.transform = .identity
    }
    }
    
    var Height = CGFloat()
    func SetUp() {
        
        guard let DetailHeight = MessageText.heightWithConstrainedWidth(view.frame.width - ControlWidth(80), font: UIFont.boldSystemFont(ofSize:ControlWidth(16)), Spacing: ControlHeight(6)) else{return}
        
        Height = DetailHeight < (view.frame.height / 2) ? DetailHeight:(view.frame.height / 2)
    
        ViewPop.frame = CGRect(x: ControlX(20), y: view.center.y - ((Height + ControlWidth(180)) / 2), width: view.frame.width - ControlWidth(40), height: Height + ControlWidth(180))
        view.addSubview(ViewPop)
        
        IconImage.frame = CGRect(x: ControlX(20), y: ControlY(20), width: ControlWidth(40), height: ControlWidth(38))
        ViewPop.addSubview(IconImage)
        
        LabelTitle.frame = CGRect(x: IconImage.frame.maxX + ControlX(15), y: ControlY(20), width: ViewPop.frame.width - ControlWidth(100), height: ControlWidth(38))
        ViewPop.addSubview(LabelTitle)
        
        Message.frame = CGRect(x: ControlX(20), y: IconImage.frame.maxY + ControlY(8), width: ViewPop.frame.width - ControlWidth(40), height: Height + ControlWidth(15))
        ViewPop.addSubview(Message)
                
        Stack.frame = CGRect(x: ControlX(20), y: Message.frame.maxY + ControlY(15), width: ViewPop.frame.width - ControlWidth(40), height: ControlWidth(50))
        ViewPop.addSubview(Stack)
    }
    
    lazy var ViewPop : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()
    
    @IBInspectable var IconTitle:String = "𝗶" {
      didSet {
        IconImage.setTitle(IconTitle, for: .normal)
        IconImage.transform = IconTitle == "𝗶" ? CGAffineTransform(rotationAngle: .pi):.identity
      }
    }

    lazy var IconImage:UIButton = {
        let Button = UIButton()
        Button.backgroundColor = UIColor(red: 232/255, green: 199/255, blue: 199/255, alpha: 1)
        Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: ControlWidth(30))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        return Button
    }()
    
    @IBInspectable var TitleText:String = "" {
      didSet {
        LabelTitle.text = TitleText
      }
    }
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    @IBInspectable var MessageText:String = "" {
      didSet {
        Message.text = MessageText
        Message.spasing = ControlHeight(6)
      }
    }
    
    lazy var Message : UITextView = {
        let TV = UITextView()
        TV.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        TV.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        TV.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        TV.backgroundColor = .clear
        TV.isEditable = false
        TV.isSelectable = false
        TV.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        return TV
    }()
    
    @IBInspectable var TextDone:String = "" {
      didSet {
        DoneButton.setTitle(TextDone, for: .normal)
      }
    }
    
    lazy var DoneButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionBack), for: .touchUpInside)
        return Button
    }()
    
    
    lazy var CancelButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .white
        Button.setTitle("Cancel", for: .normal)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.layer.borderColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0).cgColor
        Button.layer.borderWidth = ControlWidth(2)
        Button.addTarget(self, action: #selector(ActionBack), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionBack() {
     dismiss(animated: true)
    }
    
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [CancelButton,DoneButton])
        Stack.axis = .horizontal
        Stack.spacing = 15
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
}

