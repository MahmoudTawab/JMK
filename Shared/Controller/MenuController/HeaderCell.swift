//
//  HeaderCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 09/08/2021.
//

import UIKit

protocol CollapsibleCollectionHeaderDelegate {
    func toggleSection(_ section: Int)
}

class HeaderCell: UICollectionReusableView {

    var delegate: CollapsibleCollectionHeaderDelegate?
    var section: Int = 0
    
    lazy var titleLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var toggleButton : UIImageView = {
        let Image = UIImageView()
        Image.image = UIImage(named: "down")
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        addSubview(BackgroundView)
        BackgroundView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(10)).isActive = true
        BackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        BackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // Arrow label
        BackgroundView.addSubview(toggleButton)
        toggleButton.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        toggleButton.topAnchor.constraint(equalTo: BackgroundView.topAnchor).isActive = true
        toggleButton.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor ,constant: ControlX(-10)).isActive = true
        toggleButton.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor).isActive = true

        // Title label
        BackgroundView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: BackgroundView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor ,constant: ControlX(15)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeaderCell.tapHeader(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
    guard let cell = gestureRecognizer.view as? HeaderCell else {
    return
    }
    delegate?.toggleSection(cell.section)
    }
    
    func setCollapsed(_ Collapsed:Bool) {
    toggleButton.transform = CGAffineTransform(rotationAngle: !Collapsed ? 0:-.pi / 2)
    BackgroundView.backgroundColor = !Collapsed ? UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1):
    UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
    }
}

