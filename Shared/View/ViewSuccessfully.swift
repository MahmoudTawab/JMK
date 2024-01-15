//
//  ViewSuccessfully.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 29/07/2021.
//

import UIKit

class ViewSuccessfully: UIViewController {
    
    @IBInspectable var TextDismiss:String = "" {
      didSet {
          Dismiss.TextDismiss = TextDismiss
      }
    }
    
    @IBInspectable var ImageIcon:String = "" {
      didSet {
        IconImage.image = UIImage(named: ImageIcon)
      }
    }
    
    @IBInspectable var MessageTitle:String = "" {
      didSet {
      TitleLabel.text = MessageTitle
      }
    }
    
    @IBInspectable var MessageDetails:String = "" {
      didSet {
      Details.text = MessageDetails
      }
    }
    
    @IBInspectable var GoText:String = "" {
      didSet {
        GoToController.setTitle(GoText, for: .normal)
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    SetUp()
    Background.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
    self.Background.transform = .identity
    })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.5, animations: {
    self.Background.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }) { (End) in
    self.Background.transform = .identity
    }
    }
    
    func SetUp() {
        view.addSubview(DismissView)
        DismissView.frame = view.bounds
        
        view.addSubview(Background)
        Background.addSubview(Dismiss)
        Background.addSubview(IconImage)
        Background.addSubview(TitleLabel)
        Background.addSubview(Details)
        Background.addSubview(GoToController)
        
        
        guard let DetailHeight = MessageDetails.heightWithConstrainedWidth(view.frame.width - ControlWidth(70), font: UIFont.boldSystemFont(ofSize:ControlWidth(16)), Spacing: ControlHeight(4)) else{return}
    
        let Height = (view.frame.height / 2) + DetailHeight + ControlWidth(20)
        
        let BackgroundHeight = Height < (view.frame.height - ControlWidth(130)) ? Height : (view.frame.height - ControlWidth(130))
        
        Background.frame = CGRect(x: ControlX(15), y: view.center.y - (BackgroundHeight / 2), width: view.frame.width - ControlWidth(30), height: BackgroundHeight)
        
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(12), width: Background.frame.width - ControlWidth(40), height: ControlHeight(50))
            
        IconImage.frame = CGRect(x: ControlWidth(115), y: ControlX(67), width: ControlWidth(115), height: ControlWidth(115))
            
        TitleLabel.frame = CGRect(x: ControlX(20), y: IconImage.frame.maxY + ControlX(25), width: Background.frame.width - ControlWidth(40), height: ControlWidth(30))
        
        Details.leftAnchor.constraint(equalTo: TitleLabel.leftAnchor).isActive = true
        Details.rightAnchor.constraint(equalTo: TitleLabel.rightAnchor).isActive = true
        Details.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: ControlX(5)).isActive = true
        Details.bottomAnchor.constraint(equalTo: Background.bottomAnchor, constant: ControlX(-95)).isActive = true
        
        GoToController.frame = CGRect(x: ControlX(20), y: BackgroundHeight - ControlX(75), width: Background.frame.width - ControlWidth(40), height: ControlWidth(50))
    }
    
    
    lazy var DismissView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return View
    }()

    lazy var Background:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()

    lazy var IconImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        return ImageView
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(18))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var Details : UITextView = {
        let TV = UITextView()
        TV.textAlignment = .center
        TV.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        TV.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        TV.spasing = ControlHeight(4)
        TV.isSelectable = false
        TV.isEditable = false
        TV.backgroundColor = .clear
        TV.keyboardAppearance = .light
        TV.translatesAutoresizingMaskIntoConstraints = false
        return TV
    }()
    
    lazy var GoToController : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        return Button
    }()
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
      dismiss(animated: true)
    }
    
}
