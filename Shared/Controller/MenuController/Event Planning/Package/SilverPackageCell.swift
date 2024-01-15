//
//  SilverPackageCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/08/2021.
//

import UIKit

class SilverPackageCell: UICollectionViewCell {
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.backgroundColor = .white
        ImageView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ImageView.layer.shadowOpacity = 0.5
        ImageView.layer.shadowOffset = CGSize(width: 1, height: -1)
        ImageView.layer.shadowRadius = 5
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        addSubview(ImageView)
        
        ImageView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

