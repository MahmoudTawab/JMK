//
//  InviteGuestsCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/07/2021.
//

import UIKit


protocol InviteGuestsDelegate {
    func ActionSelectImage(Cell:InviteGuestsCell)
}

class InviteGuestsCell: UICollectionViewCell {

    var Delegate:InviteGuestsDelegate?
    
    var IdCell : String?
    
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
        ImageView.layer.borderWidth = ControlHeight(0.5)
        ImageView.layer.masksToBounds = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        return ImageView
    }()
    
    lazy var SelectButton:UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "AddNoSelect"), for: .normal)
        Button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        Button.addTarget(self, action: #selector(ActionSelect), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionSelect() {
    Delegate?.ActionSelectImage(Cell: self)
    }
    
    lazy var ViewBottom : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(ViewBottom)
        
        contentView.addSubview(ProfileImage)
        contentView.addSubview(SelectButton)
        
        contentView.addSubview(NameLabel)
        contentView.addSubview(PhoneLabel)
        
        ViewBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ViewBottom.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        ViewBottom.heightAnchor.constraint(equalToConstant: ControlWidth(0.6)).isActive = true
        
        ProfileImage.leftAnchor.constraint(equalTo: self.leftAnchor , constant: ControlX(15)).isActive = true
        ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.layer.cornerRadius = ControlWidth(30)
        
        NameLabel.leftAnchor.constraint(equalTo: ProfileImage.rightAnchor , constant:ControlX(15)).isActive = true
        NameLabel.topAnchor.constraint(equalTo: ProfileImage.topAnchor,constant: ControlX(4)).isActive = true
        NameLabel.rightAnchor.constraint(equalTo: self.rightAnchor , constant: ControlX(-80)).isActive = true
        NameLabel.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        
        PhoneLabel.leftAnchor.constraint(equalTo: NameLabel.leftAnchor).isActive = true
        PhoneLabel.bottomAnchor.constraint(equalTo: ProfileImage.bottomAnchor,constant: ControlX(-4)).isActive = true
        PhoneLabel.rightAnchor.constraint(equalTo: NameLabel.rightAnchor).isActive = true
        PhoneLabel.heightAnchor.constraint(equalTo: NameLabel.heightAnchor).isActive = true
        
        SelectButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: ControlX(-5)).isActive = true
        SelectButton.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        SelectButton.widthAnchor.constraint(equalToConstant: ControlWidth(55)).isActive = true
        SelectButton.heightAnchor.constraint(equalTo: SelectButton.widthAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
