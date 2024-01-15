//
//  FooterCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 16/11/2021.
//

import UIKit

protocol CollapsibleCollectionFooterDelegate {
    func toggleSection()
}

class FooterCell: UICollectionReusableView {
 
    var delegate : CollapsibleCollectionFooterDelegate?
    
    lazy var BecomeASupplier : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Become a Supplier", for: .normal)
        Button.backgroundColor = .clear
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.layer.borderWidth = ControlHeight(1.5)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Button.layer.borderColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0).cgColor
        Button.addTarget(self, action: #selector(ActionBecomeASupplier), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionBecomeASupplier() {
        delegate?.toggleSection()        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        
        addSubview(BecomeASupplier)
        BecomeASupplier.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(30)).isActive = true
        BecomeASupplier.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        BecomeASupplier.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        BecomeASupplier.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-20)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
