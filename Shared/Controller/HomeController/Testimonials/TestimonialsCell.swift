//
//  TestimonialsCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/07/2021.
//

import UIKit

class TestimonialsCell: UICollectionViewCell {
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        return ImageView
    }()

    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(17))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 0.75)
        Label.numberOfLines = 0
        Label.textAlignment = .right
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ViewRating : UIRating = {
        let View = UIRating()
        return View
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ImageView)
        addSubview(LabelTitle)
        addSubview(LabelDetails)
        addSubview(LabelDate)
        addSubview(ViewRating)
        
        ImageView.frame = CGRect(x: ControlX(18), y: ControlX(13), width: ControlWidth(54), height: ControlWidth(54))
        ImageView.layer.cornerRadius = ImageView.frame.height / 2
        
        LabelTitle.frame = CGRect(x: ControlX(87), y: ControlX(15), width: ControlWidth(108), height: ControlWidth(25))
        ViewRating.frame = CGRect(x: ControlX(87), y: ControlX(43), width: ControlWidth(108), height: ControlWidth(20))
        LabelDate.frame = CGRect(x: ControlX(220), y: ControlX(15), width: ControlWidth(108), height: ControlWidth(25))
        LabelDetails.frame = CGRect(x: ControlX(20), y: ControlX(72), width: ControlWidth(305), height: ControlWidth(63))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
