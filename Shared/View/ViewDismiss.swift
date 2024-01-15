//
//  ViewDismiss.swift
//  ViewDismiss
//
//  Created by Emoji Technology on 22/09/2021.
//

import UIKit

class ViewDismiss: UIView {

    @IBInspectable var TextDismiss:String = "" {
      didSet {
          Label.text = TextDismiss
      }
    }
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(20))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var IconImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        let image = UIImage(named: "right-arrow")?.withInset(UIEdgeInsets(top: 7.5, left: 3, bottom: 7.5, right: 7.5))
        ImageView.image = image
        ImageView.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(IconImage)
        addSubview(Label)
        
        IconImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        IconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        IconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        IconImage.widthAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        
        Label.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(5)).isActive = true
        Label.leadingAnchor.constraint(equalTo: IconImage.trailingAnchor).isActive = true
        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlY(-5)).isActive = true
        Label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                
        IconImage.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
