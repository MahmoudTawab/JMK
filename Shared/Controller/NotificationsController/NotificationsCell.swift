//
//  NotificationsCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 07/08/2021.
//

import UIKit
protocol NotificationsDelegate {
    func ActionView(cell:NotificationsCell)
}

class NotificationsCell: SwipeTableViewCell {
    

    var Delegate : NotificationsDelegate?
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var IconImage:UIImageView = {
        let Image = UIImageView()
        let image = UIImage(named: "ringing1")?.withInset(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        Image.image = image
        Image.contentMode = .scaleAspectFit
        Image.backgroundColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    @objc func ActionBackground() {
    Delegate?.ActionView(cell: self)
    }
   
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(11))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.50)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.3011728312, green: 0.3260864058, blue: 0.3622796413, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
 
        backgroundColor = #colorLiteral(red: 0.9724199181, green: 0.9724199181, blue: 0.9724199181, alpha: 1)
        
        contentView.addSubview(BackgroundView)
        contentView.addSubview(LabelTitle)
        contentView.addSubview(LabelDate)
        contentView.addSubview(IconImage)
        contentView.addSubview(ViewLine)
        
        BackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        BackgroundView.leftAnchor.constraint(equalTo: leftAnchor,constant: ControlX(15)).isActive = true
        BackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        ViewLine.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor).isActive = true
        ViewLine.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor).isActive = true
        ViewLine.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor).isActive = true
        ViewLine.heightAnchor.constraint(equalToConstant: ControlWidth(0.4)).isActive = true
            
        IconImage.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlX(16)).isActive = true
        IconImage.leftAnchor.constraint(equalTo: BackgroundView.leftAnchor,constant: ControlX(16)).isActive = true
        IconImage.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        IconImage.heightAnchor.constraint(equalTo: IconImage.widthAnchor).isActive = true
            
        LabelTitle.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlY(12)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: IconImage.trailingAnchor,constant: ControlX(10)).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor , constant: ControlX(-35)).isActive = true
        LabelTitle.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true

        LabelDate.topAnchor.constraint(equalTo: LabelTitle.bottomAnchor).isActive = true
        LabelDate.leadingAnchor.constraint(equalTo: LabelTitle.leadingAnchor).isActive = true
        LabelDate.widthAnchor.constraint(equalTo: LabelTitle.widthAnchor).isActive = true
        LabelDate.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
