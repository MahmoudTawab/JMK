//
//  HomeStoriesCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 13/07/2021.
//

import UIKit

class HomeStoriesCell: UICollectionViewCell {
    
    public var userDetails: (String,String)? {
        didSet {
            if let details = userDetails {
                self.StoryLabel.text = details.0
                self.ImageView.setImage(url: details.1)
            }
        }
    }
    
    let StoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:115 / 255.0, green: 116 / 255.0, blue: 118 / 255.0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(9))
        return label
    }()
    
    let ImageView: UIImageView = {
        let Image = UIImageView()
        Image.clipsToBounds = true
        Image.contentMode = .scaleAspectFill
        return Image
    }()
    
    let gradient = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ImageView)
        ImageView.frame = CGRect(x: ControlX(10), y: 0, width: frame.width -  ControlHeight(20), height: frame.height - ControlHeight(20))
                
        addSubview(StoryLabel)
        StoryLabel.frame = CGRect(x: ImageView.center.x - (frame.width / 2), y: ImageView.frame.maxY + ControlY(5), width: frame.width, height: ControlHeight(20))
        
        ImageView.layer.cornerRadius = ImageView.frame.height / 2
        
        gradient.frame =  CGRect(origin: CGPoint.zero, size: ImageView.frame.size)
        let shape = CAShapeLayer()
        shape.lineWidth = ControlHeight(4)
        shape.path = UIBezierPath(roundedRect: ImageView.bounds, cornerRadius: ImageView.layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        ImageView.layer.addSublayer(gradient)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
