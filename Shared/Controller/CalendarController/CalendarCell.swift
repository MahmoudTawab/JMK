//
//  CalendarCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/08/2021.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var IconImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        return ImageView
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(IconImage)
        addSubview(LabelTitle)
        addSubview(LabelDetails)
        
        IconImage.frame = CGRect(x: ControlX(15), y: rect.center.y - ControlWidth(20), width: ControlWidth(40), height: ControlWidth(40))
        
        LabelTitle.frame = CGRect(x: ControlX(65), y: IconImage.frame.minY - ControlX(5), width: ControlWidth(260), height: ControlWidth(22))
        
        LabelDetails.frame = CGRect(x: ControlX(65), y: LabelTitle.frame.maxY, width: ControlWidth(260), height: ControlWidth(38))
    }
    
}
