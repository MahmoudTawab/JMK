//
//  SavedCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 27/07/2021.
//

import UIKit

protocol SavedDelegate {
    func AllImageAction(Cell:SavedCell)
    func EditDeleteAction(Cell:SavedCell)
}

class SavedCell: UICollectionViewCell {
    
    var Delegate : SavedDelegate?
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .left
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionEditDelete)))
        return Label
    }()
    
    lazy var Image1:UIImageView = {
        let ImageView = UIImageView()
        AllImage(ImageView)
        return ImageView
    }()
    
    lazy var Image2:UIImageView = {
        let ImageView = UIImageView()
        AllImage(ImageView)
        return ImageView
    }()
    
    lazy var Image3:UIImageView = {
        let ImageView = UIImageView()
        AllImage(ImageView)
        return ImageView
    }()
    
    func AllImage(_ image:UIImageView) {
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .white
        image.layer.cornerRadius = 0
        image.layer.borderWidth = ControlWidth(1.4)
        image.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var AllImageView : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.7143783335, green: 0.7143783335, blue: 0.7143783335, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: 1)
        View.layer.shadowRadius = 6
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionAllImage)))
        return View
    }()
    
    @objc func ActionAllImage() {
    Delegate?.AllImageAction(Cell:self)
    }
    
    lazy var EditAndDelete : UIImageView = {
        let Image = UIImageView()
        Image.image = UIImage(named: "menu")?.withInset(UIEdgeInsets(top: 3, left: 0, bottom:3, right: 0))
        Image.backgroundColor = .clear
        Image.isUserInteractionEnabled = true
        Image.contentMode = .scaleAspectFit
        Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionEditDelete)))
        return Image
    }()
    
    @objc func ActionEditDelete() {
    Delegate?.EditDeleteAction(Cell:self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addSubview(AllImageView)
        AllImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: self.frame.height - ControlWidth(30))
                
        AllImageView.addSubview(Image1)
        AllImageView.addSubview(Image2)
        AllImageView.addSubview(Image3)
        
        Image1.topAnchor.constraint(equalTo: AllImageView.topAnchor).isActive = true
        Image1.leftAnchor.constraint(equalTo: AllImageView.leftAnchor).isActive = true
        Image1.bottomAnchor.constraint(equalTo: AllImageView.bottomAnchor).isActive = true
        Image1.widthAnchor.constraint(equalToConstant: ControlWidth(84)).isActive = true
    
        Image2.topAnchor.constraint(equalTo: AllImageView.topAnchor).isActive = true
        Image2.leftAnchor.constraint(equalTo: Image1.rightAnchor).isActive = true
        Image2.rightAnchor.constraint(equalTo: AllImageView.rightAnchor).isActive = true
        Image2.heightAnchor.constraint(equalTo: AllImageView.heightAnchor, multiplier: 1/2).isActive = true
        
        Image3.topAnchor.constraint(equalTo: Image2.bottomAnchor).isActive = true
        Image3.leftAnchor.constraint(equalTo: Image1.rightAnchor).isActive = true
        Image3.rightAnchor.constraint(equalTo: AllImageView.rightAnchor).isActive = true
        Image3.heightAnchor.constraint(equalTo: AllImageView.heightAnchor, multiplier: 1/2).isActive = true
        
        addSubview(LabelTitle)
        
        addSubview(EditAndDelete)
        
        LabelTitle.frame = CGRect(x: 0, y: AllImageView.frame.maxY + ControlX(7), width: ControlWidth(147.5), height: ControlWidth(30))
        
        EditAndDelete.frame = CGRect(x: ControlX(152), y: AllImageView.frame.maxY + ControlX(7), width: ControlWidth(20), height: ControlWidth(30))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
