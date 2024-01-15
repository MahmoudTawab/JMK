//
//  AddNewPlaceImageCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/08/2021.
//

import UIKit

protocol AddNewPlaceCellDelegate {
    func TopImageSelect(cell:AddNewPlaceImageCell)
}

class AddNewPlaceImageCell: UICollectionViewCell {
    
    var Delegate : AddNewPlaceCellDelegate?
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Add more photos"
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(10))
        Label.textColor = .white
        Label.textAlignment = .center
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ImageView.layer.shadowOpacity = 0.5
        ImageView.layer.shadowOffset = CGSize(width: 1, height: -1)
        ImageView.layer.shadowRadius = 5
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var TopImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.isHidden = true
        image.image = UIImage(named: "check")
        image.layer.cornerRadius = ControlWidth(12.5)
        image.isUserInteractionEnabled = true
        image.backgroundColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TopImageSelect)))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    @objc func TopImageSelect() {
        Delegate?.TopImageSelect(cell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(LabelTitle)
        addSubview(ImageView)
        
        ImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        ImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        ImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        LabelTitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        LabelTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        LabelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: ControlWidth(27)).isActive = true
        LabelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addSubview(TopImage)
        TopImage.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
        TopImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-5)).isActive = true
        TopImage.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        TopImage.heightAnchor.constraint(equalTo: TopImage.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
