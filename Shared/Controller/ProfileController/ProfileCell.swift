//
//  ProfileCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 15/07/2021.
//

import UIKit

protocol ProfileDelegate {
    func ActionView(cell:ProfileCell)
}

class ProfileCell: UITableViewCell {
        
    var Delegate : ProfileDelegate?
    
     lazy var ProfileLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(15))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
        }()

       lazy var ProfileImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
       }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            backgroundColor = .clear
            contentView.addSubview(ProfileLabel)
            contentView.addSubview(ProfileImage)
            
            ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
            ProfileImage.heightAnchor.constraint(equalToConstant: ControlHeight(25)).isActive = true
            
            ProfileLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            ProfileLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant:  ControlHeight(-20)).isActive = true
            ProfileLabel.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor, constant: ControlX(20)).isActive = true
            ProfileLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-10)).isActive = true
            
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))

        }
        
        @objc func ActionBackground() {
        Delegate?.ActionView(cell: self)
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
