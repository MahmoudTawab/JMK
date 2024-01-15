//
//  HowItWorksCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/07/2021.
//

import UIKit

class HowItWorksCell: UITableViewCell {
  
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var IconImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var ViewBackground : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(ViewBackground)
        ViewBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ViewBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: ControlX(15)).isActive = true
        ViewBackground.rightAnchor.constraint(equalTo: rightAnchor , constant: ControlX(-15)).isActive = true
        ViewBackground.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-20)).isActive = true
        
        ViewBackground.addSubview(IconImage)
        IconImage.centerYAnchor.constraint(equalTo: ViewBackground.centerYAnchor).isActive = true
        IconImage.leftAnchor.constraint(equalTo: ViewBackground.leftAnchor, constant: ControlX(15)).isActive = true
        IconImage.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        IconImage.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        
        let StackVertical = UIStackView(arrangedSubviews: [LabelTitle,LabelDetails])
        StackVertical.axis = .vertical
        StackVertical.distribution = .fill
        StackVertical.spacing = ControlHeight(5)
        StackVertical.alignment = .fill
        StackVertical.backgroundColor = .clear
        StackVertical.translatesAutoresizingMaskIntoConstraints = false
        
        ViewBackground.addSubview(StackVertical)
        StackVertical.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlHeight(20)).isActive = true
        StackVertical.leadingAnchor.constraint(equalTo: IconImage.trailingAnchor ,constant: ControlX(20)).isActive = true
        StackVertical.topAnchor.constraint(equalTo: ViewBackground.topAnchor,constant: ControlY(15)).isActive = true
        StackVertical.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor ,constant: ControlX(-15)).isActive = true
        StackVertical.bottomAnchor.constraint(equalTo: ViewBackground.bottomAnchor ,constant: ControlY(-15)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
