//
//  EventTypeswift
//  JMK (iOS)
//
//  Created by Emoji Technology on 15/08/2021.
//

import UIKit

protocol EventTypeCellDelegate {
    func ActionBackground(Cell:EventTypeCell)
}

class EventTypeCell: UITableViewCell {

    var Delegate : EventTypeCellDelegate?
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.7454141974, green: 0.7455408573, blue: 0.7453975677, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: -1, height: 1.4)
        View.layer.shadowRadius = 4
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ORLabel : UILabel = {
        let Label = UILabel()
        Label.text = "OR"
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Medium" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .white
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var ORView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
   lazy var DetailsLabel : UIButton = {
       let Button = UIButton()
       Button.backgroundColor = .clear
       Button.titleLabel?.numberOfLines = 0
       Button.contentVerticalAlignment = .top
       Button.contentHorizontalAlignment = .left
       Button.titleLabel?.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(13))
       Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
       Button.addTarget(self, action: #selector(ActionBackground), for: .touchUpInside)
       Button.translatesAutoresizingMaskIntoConstraints = false
       return Button
   }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(BackgroundView)
        contentView.addSubview(ORView)
        contentView.addSubview(ORLabel)
        
        BackgroundView.addSubview(ImageView)
        BackgroundView.addSubview(TitleLabel)
        BackgroundView.addSubview(DetailsLabel)
        
        BackgroundView.layer.masksToBounds = true
        BackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        BackgroundView.leftAnchor.constraint(equalTo: leftAnchor ,constant: ControlX(15)).isActive = true
        BackgroundView.rightAnchor.constraint(equalTo: rightAnchor , constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-70)).isActive = true
        
        TitleLabel.topAnchor.constraint(equalTo: topAnchor , constant: ControlX(35)).isActive = true
        TitleLabel.leftAnchor.constraint(equalTo: BackgroundView.leftAnchor ,constant: ControlX(15)).isActive = true
        TitleLabel.widthAnchor.constraint(equalToConstant: ControlWidth(191.5)).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        DetailsLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor , constant: ControlX(5)).isActive = true
        DetailsLabel.leftAnchor.constraint(equalTo: TitleLabel.leftAnchor ).isActive = true
        DetailsLabel.rightAnchor.constraint(equalTo: TitleLabel.rightAnchor).isActive = true
        DetailsLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor).isActive = true
        DetailsLabel.titleLabel?.spasing = ControlHeight(5)

        ImageView.topAnchor.constraint(equalTo: topAnchor , constant: ControlY(20)).isActive = true
        ImageView.leftAnchor.constraint(equalTo: DetailsLabel.rightAnchor ,constant: ControlX(15)).isActive = true
        ImageView.rightAnchor.constraint(equalTo: BackgroundView.rightAnchor , constant: ControlX(-15)).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor , constant: ControlX(-20)).isActive = true
    
        ORLabel.topAnchor.constraint(equalTo: BackgroundView.bottomAnchor , constant: ControlX(10)).isActive = true
        ORLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ORLabel.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        ORLabel.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        ORView.centerYAnchor.constraint(equalTo: ORLabel.centerYAnchor).isActive = true
        ORView.leftAnchor.constraint(equalTo: leftAnchor ,constant: ControlX(15)).isActive = true
        ORView.rightAnchor.constraint(equalTo: rightAnchor , constant: ControlX(-15)).isActive = true
        ORView.heightAnchor.constraint(equalToConstant: ControlWidth(1.5)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))

    }
    
    @objc func ActionBackground() {
        Delegate?.ActionBackground(Cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


protocol PackagesCellDelegate {
    func ActionBackground(Cell:PackagesCell)
}

class PackagesCell: UITableViewCell {

    var Delegate : PackagesCellDelegate?
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.7454141974, green: 0.7455408573, blue: 0.7453975677, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: -1, height: 1.4)
        View.layer.shadowRadius = 4
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var BackgroundImage : UIView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Male")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
   lazy var DetailsLabel : UIButton = {
       let Button = UIButton()
       Button.titleLabel?.numberOfLines = 1
       Button.contentVerticalAlignment = .center
       Button.titleLabel?.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(11))
       Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
       Button.backgroundColor = .clear
       Button.addTarget(self, action: #selector(ActionBackground), for: .touchUpInside)
       Button.translatesAutoresizingMaskIntoConstraints = false
       return Button
   }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(BackgroundView)

        BackgroundView.addSubview(ImageView)
        BackgroundView.addSubview(TitleLabel)
        BackgroundView.addSubview(DetailsLabel)
        BackgroundView.addSubview(BackgroundImage)

        BackgroundView.layer.masksToBounds = false
        BackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        BackgroundView.leftAnchor.constraint(equalTo: leftAnchor ,constant: ControlX(15)).isActive = true
        BackgroundView.rightAnchor.constraint(equalTo: rightAnchor , constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-15)).isActive = true

        ImageView.topAnchor.constraint(equalTo: topAnchor , constant: ControlX(20)).isActive = true
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        ImageView.centerXAnchor.constraint(equalTo: BackgroundView.centerXAnchor).isActive = true

        TitleLabel.topAnchor.constraint(equalTo: ImageView.bottomAnchor).isActive = true
        TitleLabel.leftAnchor.constraint(equalTo: BackgroundView.leftAnchor ,constant: ControlX(15)).isActive = true
        TitleLabel.rightAnchor.constraint(equalTo: BackgroundView.rightAnchor, constant: ControlX(-15)).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true

        DetailsLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor).isActive = true
        DetailsLabel.leftAnchor.constraint(equalTo: TitleLabel.leftAnchor).isActive = true
        DetailsLabel.rightAnchor.constraint(equalTo: TitleLabel.rightAnchor).isActive = true
        DetailsLabel.heightAnchor.constraint(equalTo: TitleLabel.heightAnchor).isActive = true

        BackgroundImage.topAnchor.constraint(equalTo: BackgroundView.topAnchor).isActive = true
        BackgroundImage.widthAnchor.constraint(equalToConstant: ControlWidth(172.5)).isActive = true
        BackgroundImage.rightAnchor.constraint(equalTo: BackgroundView.rightAnchor).isActive = true
        BackgroundImage.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor).isActive = true

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))

    }
    
    @objc func ActionBackground() {
        Delegate?.ActionBackground(Cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
