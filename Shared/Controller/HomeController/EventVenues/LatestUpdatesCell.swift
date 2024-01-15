//
//  LatestUpdatesCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 16/11/2021.
//

import UIKit

class LatestUpdatesCell: UICollectionViewCell {
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1417151988, green: 0.1417151988, blue: 0.1417151988, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        return Label
    }()
    
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1417151988, green: 0.1417151988, blue: 0.1417151988, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        return Label
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.backgroundColor = .clear
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
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3953523951).cgColor,#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7008712466).cgColor,#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8502097225).cgColor,#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        gradientLayer.frame = CGRect(x: 0, y: self.frame.maxY - ControlWidth(80), width: self.frame.width, height: ControlWidth(80))
        self.layer.addSublayer(gradientLayer)
        
        addSubview(LabelTitle)
        LabelTitle.frame = CGRect(x: ControlX(10), y: self.frame.maxY - ControlWidth(80), width: self.frame.width - ControlX(20), height: ControlWidth(60))
        
        addSubview(LabelDate)
        LabelDate.frame = CGRect(x: ControlX(10), y: self.frame.maxY - ControlWidth(20), width: self.frame.width - ControlX(20), height: ControlWidth(20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
