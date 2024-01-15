//
//  ColorsCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/08/2021.
//

import UIKit

protocol ColorsCellDelegate {
    func ActionCell(cell:ColorsCell)
}

class ColorsCell: UICollectionViewCell {
    
    var Delegate : ColorsCellDelegate?
    
    lazy var Image:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        return ImageView
    }()
    
    lazy var ImageSelect:UIButton = {
        let image = UIButton()
        image.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        image.tintColor = .white
        image.setImage(UIImage(named: "tick"), for: .normal)
        image.layer.cornerRadius = ControlWidth(12)
        image.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(Image)
        Image.frame = self.bounds
        
        addSubview(ImageSelect)
        ImageSelect.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(6)).isActive = true
        ImageSelect.rightAnchor.constraint(equalTo: rightAnchor,constant: ControlX(-6)).isActive = true
        ImageSelect.heightAnchor.constraint(equalToConstant: ControlWidth(24)).isActive = true
        ImageSelect.widthAnchor.constraint(equalTo: ImageSelect.heightAnchor).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCell)))
    }
    
    @objc func ActionCell() {
        Delegate?.ActionCell(cell: self)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
