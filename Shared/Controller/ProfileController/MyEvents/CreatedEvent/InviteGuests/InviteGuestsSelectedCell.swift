//
//  InviteGuestsSelectedCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/08/2021.
//

import UIKit

class InviteGuestsSelectedCell: UITableViewCell {
        
    lazy var NameLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var PhoneLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    let ProfileImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.backgroundColor = .clear
        ImageView.layer.borderWidth = 0.5
        ImageView.layer.masksToBounds = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        return ImageView
    }()
    
    lazy var ViewBottom : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(ViewBottom)
        
        contentView.addSubview(ProfileImage)
        
        contentView.addSubview(NameLabel)
        contentView.addSubview(PhoneLabel)
        
        ViewBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ViewBottom.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        ViewBottom.heightAnchor.constraint(equalToConstant: ControlWidth(0.6)).isActive = true
        
        ProfileImage.leftAnchor.constraint(equalTo: self.leftAnchor , constant:ControlX(15)).isActive = true
        ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.layer.cornerRadius = ControlWidth(30)
        
        NameLabel.leftAnchor.constraint(equalTo: ProfileImage.rightAnchor , constant: ControlX(15)).isActive = true
        NameLabel.topAnchor.constraint(equalTo: ProfileImage.topAnchor,constant: ControlX(4)).isActive = true
        NameLabel.rightAnchor.constraint(equalTo: self.rightAnchor , constant: ControlX(-80)).isActive = true
        NameLabel.heightAnchor.constraint(equalToConstant: ControlX(25)).isActive = true
        
        PhoneLabel.leftAnchor.constraint(equalTo: NameLabel.leftAnchor).isActive = true
        PhoneLabel.bottomAnchor.constraint(equalTo: ProfileImage.bottomAnchor,constant: ControlX(-4)).isActive = true
        PhoneLabel.rightAnchor.constraint(equalTo: NameLabel.rightAnchor).isActive = true
        PhoneLabel.heightAnchor.constraint(equalTo: NameLabel.heightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
