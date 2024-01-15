//
//  MyEventsCellUpcoming.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 19/07/2021.
//

import UIKit

protocol MyEventsDelegateUpcoming {
    func ActionView(cell:MyEventsCellUpcoming)
    func TrashAction(cell:MyEventsCellUpcoming)
}

class MyEventsCellUpcoming: UITableViewCell {
    
    var Delegate : MyEventsDelegateUpcoming?
    
    var UpcomingAndPastHeight:NSLayoutConstraint?
    lazy var UpcomingAndPast : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
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
    
    lazy var IconImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Event10")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.layer.borderWidth = 1
        View.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.25).cgColor
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    @objc func ActionBackground() {
    Delegate?.ActionView(cell: self)
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
    
    lazy var StackProgress : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [NameWeddingLabel,ProgressView])
    Stack.axis = .vertical
    Stack.spacing = 6
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    lazy var NameWeddingLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    func SetProgressLabel(_ Progress:Float) {
        let attributedString = NSMutableAttributedString(string: "In Progress  ", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)

        ])
        
        attributedString.append(NSAttributedString(string: "( \(Progress)% )", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.5)
        ]))
        NameWeddingLabel.attributedText = attributedString
    }

    lazy var ProgressView : UIProgressView = {
    let Prog = UIProgressView()
    Prog.tintColor = UIColor(red: 214 / 255, green: 176 / 255, blue: 156 / 255, alpha: 1)
    Prog.trackTintColor = UIColor(red: 102 / 255, green: 90 / 255, blue: 86 / 255, alpha: 1)
    Prog.translatesAutoresizingMaskIntoConstraints = false
    return Prog
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        contentView.addSubview(UpcomingAndPast)
        contentView.addSubview(BackgroundView)
        contentView.addSubview(LabelTitle)
        contentView.addSubview(LabelDetails)
        contentView.addSubview(IconImage)
        contentView.addSubview(TrashButton)
        
        contentView.addSubview(StackProgress)
        
        UpcomingAndPast.topAnchor.constraint(equalTo: topAnchor).isActive = true
        UpcomingAndPast.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(20)).isActive = true
        UpcomingAndPast.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-20)).isActive = true
        UpcomingAndPastHeight = UpcomingAndPast.heightAnchor.constraint(equalToConstant: ControlWidth(40))
        UpcomingAndPastHeight?.isActive = true
        
        BackgroundView.topAnchor.constraint(equalTo: UpcomingAndPast.bottomAnchor).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(20)).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-20)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-20)).isActive = true
            
        IconImage.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlX(16)).isActive = true
        IconImage.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor,constant: ControlX(15)).isActive = true
        IconImage.widthAnchor.constraint(equalToConstant: ControlWidth(32)).isActive = true
        IconImage.heightAnchor.constraint(equalTo: IconImage.widthAnchor,constant: ControlHeight(-5)).isActive = true
            
        LabelTitle.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlX(12)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: IconImage.trailingAnchor,constant: ControlX(18)).isActive = true
        LabelTitle.widthAnchor.constraint(equalTo: BackgroundView.widthAnchor , constant: ControlWidth(-100)).isActive = true
        LabelTitle.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
            
        LabelDetails.topAnchor.constraint(equalTo: LabelTitle.bottomAnchor).isActive = true
        LabelDetails.leadingAnchor.constraint(equalTo: LabelTitle.leadingAnchor).isActive = true
        LabelDetails.widthAnchor.constraint(equalTo: LabelTitle.widthAnchor).isActive = true
        LabelDetails.heightAnchor.constraint(equalTo: LabelTitle.heightAnchor).isActive = true
        
        TrashButton.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlX(16)).isActive = true
        TrashButton.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor,constant: ControlX(-15)).isActive = true
        TrashButton.widthAnchor.constraint(equalToConstant: ControlWidth(24)).isActive = true
        TrashButton.heightAnchor.constraint(equalToConstant: ControlWidth(24)).isActive = true
        
        StackProgress.topAnchor.constraint(equalTo: LabelDetails.bottomAnchor ,constant: ControlX(6)).isActive = true
        StackProgress.leadingAnchor.constraint(equalTo: LabelTitle.leadingAnchor).isActive = true
        StackProgress.widthAnchor.constraint(equalTo: LabelTitle.widthAnchor).isActive = true
        StackProgress.heightAnchor.constraint(equalToConstant: ControlWidth(28)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
