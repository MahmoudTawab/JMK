//
//  AnnouncementVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 08/08/2021.
//

import UIKit

class AnnouncementVC: UIViewController {
    
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
    
        guard let DetailHeight = MessageText.heightWithConstrainedWidth(view.frame.width - ControlWidth(80), font: UIFont.boldSystemFont(ofSize:ControlWidth(16)), Spacing: ControlWidth(6)) else{return}
        
        Height = DetailHeight < (view.frame.height / 2) ? DetailHeight:(view.frame.height / 2)
            
        ViewPop.frame = CGRect(x: ControlX(20), y: view.center.y - ((Height + ControlWidth(175)) / 2), width: view.frame.width - ControlWidth(40), height: Height + ControlWidth(175))
        view.addSubview(ViewPop)
        
        IconImage.frame = CGRect(x: ControlX(20), y: ControlY(20), width: ControlWidth(40), height: ControlWidth(40))
        ViewPop.addSubview(IconImage)
        
        LabelTitle.frame = CGRect(x: IconImage.frame.maxX + ControlX(15), y: IconImage.center.y - (ControlWidth(38) / 2), width: ViewPop.frame.width - ControlWidth(100), height: ControlWidth(38))
        ViewPop.addSubview(LabelTitle)
        
        Message.frame = CGRect(x: ControlX(20), y: IconImage.frame.maxY + ControlY(10), width: ViewPop.frame.width - ControlWidth(40), height: Height + ControlWidth(15))
        ViewPop.addSubview(Message)
        
            
        CloseButton.frame = CGRect(x: ControlX(20), y: Message.frame.maxY + ControlY(12), width: ViewPop.frame.width - ControlWidth(40), height: ControlWidth(50))
        ViewPop.addSubview(CloseButton)

    }
    
    lazy var ViewPop : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()

    lazy var IconImage : UIImageView = {
        let Image = UIImageView()
        let image = UIImage(named: "ringing1")?.withInset(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        Image.image = image
        Image.contentMode = .scaleAspectFit
        Image.backgroundColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        return Image
    }()
    
    @IBInspectable var TitleText:String = "" {
      didSet {
        LabelTitle.text = TitleText
      }
    }
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
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
        TV.keyboardAppearance = .light
        TV.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        return TV
    }()
    
    lazy var CloseButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.setTitle("Close", for: .normal)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionClose), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionClose() {
     self.dismiss(animated: true)
    }
    
    
}
