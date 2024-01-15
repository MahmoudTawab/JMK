//
//  MenuCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 09/08/2021.
//

import UIKit

protocol MenuCellDelegate {
    func ActionBackground(Cell:MenuCell)
}

class MenuCell: UICollectionViewCell {

    var Delegate : MenuCellDelegate?
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(ItemsImage)
        contentView.addSubview(ItemsLabel)
        
        ItemsImage.topAnchor.constraint(equalTo: topAnchor, constant: ControlY(15)).isActive = true
        ItemsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ControlX(15)).isActive = true
        ItemsImage.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ItemsImage.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-15)).isActive = true
        
        ItemsLabel.topAnchor.constraint(equalTo: topAnchor, constant: ControlY(10)).isActive = true
        ItemsLabel.leadingAnchor.constraint(equalTo: ItemsImage.trailingAnchor, constant: ControlX(15)).isActive = true
        ItemsLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: ControlX(-15)).isActive = true
        ItemsLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlY(-10)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))
    }
    
    @objc func ActionBackground() {
    Delegate?.ActionBackground(Cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
