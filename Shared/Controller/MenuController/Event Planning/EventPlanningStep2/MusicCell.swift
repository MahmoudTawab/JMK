//
//  MusicCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/08/2021.
//

import UIKit

protocol MusicCellDelegate {
    func ActionCell(cell:MusicCell)
}

class MusicCell: UICollectionViewCell {
    
    var Delegate : MusicCellDelegate?
    
    lazy var Image : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.contentMode = .scaleAspectFit
        Image.layer.masksToBounds = true
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var image:UIButton = {
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
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.8, height: -0.8)
        layer.shadowRadius = 4
       
        addSubview(Image)
        Image.topAnchor.constraint(equalTo: self.topAnchor , constant: ControlY(20)).isActive = true
        Image.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        Image.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        Image.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-50)).isActive = true
        
        addSubview(Label)
        Label.topAnchor.constraint(equalTo: Image.bottomAnchor ,constant: ControlY(10)).isActive = true
        Label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        Label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-20)).isActive = true
        
        addSubview(image)
        image.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(6)).isActive = true
        image.rightAnchor.constraint(equalTo: rightAnchor,constant: ControlX(-6)).isActive = true
        image.heightAnchor.constraint(equalToConstant: ControlWidth(24)).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCell)))
    }
    
    @objc func ActionCell() {
        Delegate?.ActionCell(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
