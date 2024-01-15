//
//  CellCollectionPackage.swift
//  JMK (iOS)
//
//  Created by Emojiios on 10/01/2022.
//

import UIKit

class CellCollectionPackage: UICollectionViewCell {
        
    lazy var ItemsImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(ItemsImage)
        ItemsImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ItemsImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        ItemsImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        ItemsImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

