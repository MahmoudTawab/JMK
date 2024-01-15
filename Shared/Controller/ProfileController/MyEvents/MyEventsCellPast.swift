//
//  MyEventsCellPast.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/12/2021.
//

import UIKit

protocol MyEventsDelegatePast {
    func ActionView(cell:MyEventsCellPast)
    func ActionAddFeedback(cell:MyEventsCellPast)
}

class MyEventsCellPast: UITableViewCell {
    
    var Delegate : MyEventsDelegatePast?
    
    var UpcomingAndPastHeight:NSLayoutConstraint?
    lazy var UpcomingAndPast : UILabel = {
        let Label = UILabel()
        Label.text = "Past Events"
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
    
    lazy var ViewRating : UIRating = {
        let View = UIRating()
        View.isHidden = true
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var AddFeedback : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Add Feedback", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(11))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.isHidden = true
        Button.addTarget(self, action: #selector(ActionAddFeedback), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionAddFeedback() {
    Delegate?.ActionAddFeedback(cell: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        contentView.addSubview(UpcomingAndPast)
        contentView.addSubview(BackgroundView)
        contentView.addSubview(LabelTitle)
        contentView.addSubview(LabelDetails)
        contentView.addSubview(ViewRating)
        contentView.addSubview(AddFeedback)
        contentView.addSubview(IconImage)
        
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

        ViewRating.topAnchor.constraint(equalTo: LabelDetails.bottomAnchor , constant: ControlX(5)).isActive = true
        ViewRating.leadingAnchor.constraint(equalTo: LabelDetails.leadingAnchor).isActive = true
        ViewRating.widthAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
        ViewRating.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        
        AddFeedback.topAnchor.constraint(equalTo: LabelDetails.bottomAnchor, constant: ControlX(5)).isActive = true
        AddFeedback.leadingAnchor.constraint(equalTo: LabelDetails.leadingAnchor).isActive = true
        AddFeedback.widthAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        AddFeedback.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
