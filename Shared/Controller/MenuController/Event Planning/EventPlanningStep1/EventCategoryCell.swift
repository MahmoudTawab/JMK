//
//  EventCategoryCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 10/08/2021.
//

import UIKit

protocol EventCategoryDelegate {
    func ActionDackground(Cell:EventCategoryCell)
}

class EventCategoryCell: UITableViewCell {
    
    var Delegate:EventCategoryDelegate?
    
    lazy var ItemsLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var ItemsImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var SelectImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.alpha = 0
        ImageView.image = UIImage(named: "group_31491")
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(ItemsImage)
        contentView.addSubview(ItemsLabel)
        contentView.addSubview(SelectImage)
        
        ItemsImage.topAnchor.constraint(equalTo: topAnchor, constant: ControlY(15)).isActive = true
        ItemsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ControlX(20)).isActive = true
        ItemsImage.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ItemsImage.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-15)).isActive = true
        
        ItemsLabel.topAnchor.constraint(equalTo: topAnchor, constant: ControlY(10)).isActive = true
        ItemsLabel.leadingAnchor.constraint(equalTo: ItemsImage.trailingAnchor, constant: ControlX(15)).isActive = true
        ItemsLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: ControlX(-15)).isActive = true
        ItemsLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlY(-10)).isActive = true
    
        SelectImage.topAnchor.constraint(equalTo: topAnchor, constant: ControlY(15)).isActive = true
        SelectImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)).isActive = true
        SelectImage.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        SelectImage.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-15)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDackground)))
    }
    
    @objc func ActionDackground() {
    Delegate?.ActionDackground(Cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
