//
//  CellTablePackage.swift
//  JMK (iOS)
//
//  Created by Emojiios on 10/01/2022.
//

import UIKit

protocol CellTablePackageDelegate {
    func BackgroundAction(cell:CellTablePackage)
}

class CellTablePackage: UITableViewCell {
    
    var Delegate : CellTablePackageDelegate?
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        return Label
    }()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(TitleLabel)
        TitleLabel.frame = CGRect(x: ControlX(15), y: ControlY(5), width: rect.width - ControlWidth(30), height: ControlWidth(30))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BackgroundAction)))
    }
    
    @objc func BackgroundAction() {
    Delegate?.BackgroundAction(cell: self)
    }
}
