//
//  PaymentSettingsCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/08/2021.
//

import UIKit

protocol PaymentSettingsDelegate {
    func EditAction(cell:PaymentSettingsCell)
    func TrashAction(cell:PaymentSettingsCell)
    func BackgroundAction(cell:PaymentSettingsCell)
}

class PaymentSettingsCell: UITableViewCell {

    var Delegate : PaymentSettingsDelegate?
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.layer.borderWidth = ControlWidth(1)
        View.layer.borderColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 0.25).cgColor
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    
    lazy var EditButton : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "edit")
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.8)
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionEdit)))
        return image
    }()
    
    @objc func ActionEdit() {
        Delegate?.EditAction(cell: self)
    }
    
    lazy var TrashButton : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.8)
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionTrash)))
        return image
    }()

    
    @objc func ActionTrash() {
        Delegate?.TrashAction(cell: self)
    }
    
    var PaymentSettingsWidth:NSLayoutConstraint?
    lazy var PaymentSettings:UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "group_31491"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        contentView.addSubview(BackgroundView)
        contentView.addSubview(LabelTitle)
        contentView.addSubview(LabelDetails)
        contentView.addSubview(EditButton)
        contentView.addSubview(TrashButton)
        contentView.addSubview(PaymentSettings)
        
        PaymentSettings.centerYAnchor.constraint(equalTo: BackgroundView.centerYAnchor).isActive = true
        PaymentSettings.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor,constant: ControlX(10)).isActive = true
        PaymentSettingsWidth = PaymentSettings.widthAnchor.constraint(equalToConstant: 0)
        PaymentSettingsWidth?.isActive = true
        PaymentSettings.heightAnchor.constraint(equalTo: PaymentSettings.widthAnchor).isActive = true
        
        BackgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: ControlX(15)).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-15)).isActive = true
            
        TrashButton.centerYAnchor.constraint(equalTo: BackgroundView.centerYAnchor).isActive = true
        TrashButton.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor ,constant: ControlX(-10)).isActive = true
        TrashButton.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        TrashButton.heightAnchor.constraint(equalTo: TrashButton.widthAnchor).isActive = true
        
        EditButton.centerYAnchor.constraint(equalTo: BackgroundView.centerYAnchor).isActive = true
        EditButton.trailingAnchor.constraint(equalTo: TrashButton.leadingAnchor ,constant: ControlX(-10)).isActive = true
        EditButton.widthAnchor.constraint(equalTo: TrashButton.widthAnchor).isActive = true
        EditButton.heightAnchor.constraint(equalTo: TrashButton.heightAnchor).isActive = true
        
        LabelTitle.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlX(12)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: PaymentSettings.trailingAnchor).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: EditButton.leadingAnchor , constant: ControlX(-15)).isActive = true
        LabelTitle.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
            
        LabelDetails.topAnchor.constraint(equalTo: LabelTitle.bottomAnchor).isActive = true
        LabelDetails.leadingAnchor.constraint(equalTo: LabelTitle.leadingAnchor).isActive = true
        LabelDetails.widthAnchor.constraint(equalTo: LabelTitle.widthAnchor).isActive = true
        LabelDetails.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor,constant: ControlX(-12)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GestureRecognizer)))
    }
    
    @objc func GestureRecognizer() {
        Delegate?.BackgroundAction(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
