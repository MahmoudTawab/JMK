//
//  Checkbox.swift
//  Bnkit
//
//  Created by Mahmoud Tawab on 9/10/20.
//  Copyright © 2020 Mahmoud Tawab. All rights reserved.
//

import UIKit

class Checkbox: UIButton {

    lazy var Button : UIButton = {
     let Button = UIButton(type: .system)
     Button.backgroundColor = .clear
     Button.layer.borderWidth = ControlHeight(2)
     Button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
     Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: ControlWidth(17))
     Button.addTarget(self, action: #selector(Targe), for: .touchUpInside)
     return Button
    }()
    
    
    lazy var Label : UILabel = {
     let Label = UILabel()
     Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(17))
     Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
     Label.backgroundColor = .clear
     return Label
    }()

   override func draw(_ rect: CGRect) {
    addSubview(Button)
    Button.frame = CGRect(x: 0, y: ControlY(8.5), width: ControlHeight(30), height: ControlHeight(30))
    
    addSubview(Label)
    Label.frame = CGRect(x: Button.frame.maxX + ControlX(15), y: ControlY(8.5), width: rect.width - ControlHeight(60), height: ControlHeight(30))
     
    addTarget(self, action: #selector(Targe), for: .touchUpInside)
   }
    
   @objc func Targe() {
    Button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
    self.Button.transform = .identity
    })
    
    UIView.animate(withDuration: 0.2) {
    if self.Button.tag == 0 {
    self.Button.setTitle("✓", for: .normal)
    self.Button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
    self.Button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
    self.Button.tag = 1
    }else{
    self.Button.setTitle("", for: .normal)
    self.Button.layer.borderColor = #colorLiteral(red: 0.6240856554, green: 0.6240856554, blue: 0.6240856554, alpha: 1)
    self.Button.tag = 0
    }
    }
    
}


}
