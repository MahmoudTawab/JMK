//
//  HasSubSingleCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 16/08/2021.
//

import UIKit

protocol HasSubSingleDelegate {
    func ImageSelect(cell:HasSubSingleCell)
}

class HasSubSingleCell: UICollectionViewCell {
    
    var Delegate : HasSubSingleDelegate?
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        return Label
    }()
    
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
    
    lazy var heart : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        image.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        image.layer.shadowOpacity = 0.6
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 6
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageSelect)))
        return image
    }()
    
    @objc func ImageSelect() {
    HeartAnimate()
    Delegate?.ImageSelect(cell: self)
    }
    
    func HeartAnimate() {
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.transform = self.heart.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.transform = .identity
    })
    })
    }
    
    lazy var SelectImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "AddSelect")
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        addSubview(LabelTitle)
        addSubview(ImageView)
        
        ImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - ControlWidth(30))
        
        LabelTitle.frame = CGRect(x: 0, y: ImageView.frame.maxY + ControlY(5), width: self.frame.width, height: ControlWidth(30))
        
        addSubview(heart)
        heart.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
        heart.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-5)).isActive = true
        heart.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        heart.heightAnchor.constraint(equalTo: heart.widthAnchor).isActive = true
        
        addSubview(SelectImage)
        SelectImage.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(7)).isActive = true
        SelectImage.leftAnchor.constraint(equalTo: self.leftAnchor , constant: ControlX(7)).isActive = true
        SelectImage.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        SelectImage.heightAnchor.constraint(equalTo: SelectImage.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
