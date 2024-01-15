//
//  ButtonEventPlanning.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/08/2021.
//

import UIKit
import FlagPhoneNumber

class ButtonEventPlanning: UIButton {
    
    @IBInspectable
    var Select: Bool = false {
        didSet{
            self.setNeedsDisplay()
            SetUpButton()
        }
    }
    
    @IBInspectable var Image:String = "" {
      didSet {
      setImage(UIImage(named: Image), for: .normal)
      }
    }
    
    lazy var image:UIButton = {
        let image = UIButton()
        image.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        image.tintColor = .white
        image.setImage(UIImage(named: "tick"), for: .normal)
        image.layer.cornerRadius = ControlWidth(12)
        image.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        return image
    }()
    
    func SetUpButton() {
    if Select {
    UIView.animate(withDuration: 0.3, animations: {
    self.transform = CGAffineTransform(translationX: 1, y: 1)
    }, completion: { _ in
    UIView.animate(withDuration: 0.3, animations: {
    self.transform = .identity
    })
    })
        
    addSubview(image)
    backgroundColor = .white
    layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
    layer.borderWidth = ControlWidth(2)
    }else{
    image.removeFromSuperview()
    layer.borderWidth = 0
    backgroundColor = UIColor(red: 250/255, green: 247/255, blue: 245/255, alpha: 1)
    }
    
    layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    layer.shadowOpacity = 0.4
    layer.shadowOffset = CGSize(width: 0.8, height: -0.8)
    layer.shadowRadius = 4
    }
    
    override func draw(_ rect: CGRect) {
    image.frame = CGRect(x: rect.maxX - ControlX(30), y: ControlX(6), width: ControlWidth(24), height: ControlWidth(24))
    }

}
