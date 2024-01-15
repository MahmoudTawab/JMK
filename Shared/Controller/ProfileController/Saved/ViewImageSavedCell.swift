//
//  ViewImageSavedCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 16/08/2021.
//

import UIKit

protocol ViewImageSavedDelegate {
    func ImageSelect(cell:ViewImageSavedCell)
}

class ViewImageSavedCell: UICollectionViewCell {
    
    var Delegate : ViewImageSavedDelegate?
        
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
    
    lazy var TopImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.image = UIImage(named: "heartSelect")
        image.tintColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        image.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        image.layer.shadowOpacity = 0.8
        image.layer.shadowOffset = CGSize(width: 5, height: 5)
        image.layer.shadowRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageSelect)))
        return image
    }()
    
    @objc func ImageSelect() {
        Delegate?.ImageSelect(cell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        addSubview(ImageView)
        
        ImageView.frame = self.bounds
        
        addSubview(TopImage)
        TopImage.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(5)).isActive = true
        TopImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-5)).isActive = true
        TopImage.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        TopImage.heightAnchor.constraint(equalTo: TopImage.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
