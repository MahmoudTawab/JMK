//
//  OurStoryCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/07/2021.
//

import UIKit
import FlagPhoneNumber

class OurStoryCell: UITableViewCell {
    
    lazy var IconBackground : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(220)).isActive = true
        
        View.addSubview(ImageTop)
        ImageTop.topAnchor.constraint(equalTo: View.topAnchor).isActive = true
        ImageTop.leftAnchor.constraint(equalTo: View.leftAnchor).isActive = true
        ImageTop.bottomAnchor.constraint(equalTo: View.bottomAnchor , constant: ControlY(20)).isActive = true
        ImageTop.rightAnchor.constraint(equalTo:  View.rightAnchor , constant: ControlX(-60)).isActive = true
        return View
    }()
    
    lazy var ImageTop:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
        
    lazy var LabelTitle : CustomLabel = {
        let Label = CustomLabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(17))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var LabelDetails : CustomLabel = {
        let Label = CustomLabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var ImageLeft:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var CellBackground : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = 6
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        addSubview(CellBackground)
        CellBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        CellBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: ControlX(15)).isActive = true
        CellBackground.rightAnchor.constraint(equalTo: rightAnchor , constant: ControlX(-15)).isActive = true
        CellBackground.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-20)).isActive = true
        
        let StackHorizontal = UIStackView(arrangedSubviews: [LabelDetails,ImageLeft])
        StackHorizontal.axis = .horizontal
        StackHorizontal.distribution = .fill
        StackHorizontal.spacing = ControlHeight(10)
        StackHorizontal.alignment = .center
        StackHorizontal.backgroundColor = .clear
        StackHorizontal.translatesAutoresizingMaskIntoConstraints = false
        
        let StackVertical = UIStackView(arrangedSubviews: [IconBackground,LabelTitle,StackHorizontal])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlHeight(2)
        StackVertical.distribution = .equalSpacing
        StackVertical.alignment = .fill
        StackVertical.backgroundColor = .clear
        StackVertical.translatesAutoresizingMaskIntoConstraints = false
        
        CellBackground.addSubview(StackVertical)
        StackHorizontal.arrangedSubviews[1].trailingAnchor.constraint(equalTo: StackVertical.trailingAnchor , constant: ControlX(-25)).isActive = true
        StackHorizontal.arrangedSubviews[1].widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        StackHorizontal.arrangedSubviews[1].heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        StackVertical.leadingAnchor.constraint(equalTo: CellBackground.leadingAnchor).isActive = true
        StackVertical.topAnchor.constraint(equalTo: CellBackground.topAnchor).isActive = true
        StackVertical.trailingAnchor.constraint(equalTo: CellBackground.trailingAnchor).isActive = true
        StackVertical.bottomAnchor.constraint(equalTo: CellBackground.bottomAnchor ,constant: ControlY(-25)).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CustomLabel: UILabel {
    var verticalPadding: CGFloat = ControlHeight(8)
    var horizontalPadding: CGFloat = ControlWidth(15)

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: horizontalPadding, bottom: -verticalPadding, right: horizontalPadding)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            self.spasing = ControlHeight(4)
            let textWidth = super.intrinsicContentSize.width - horizontalPadding * 2
            let textHeight = sizeThatFits(CGSize(width: textWidth, height: .greatestFiniteMagnitude)).height
            let width = textWidth + horizontalPadding * 2
            let height = textHeight + verticalPadding * 2
            return CGSize(width: width, height: height)
        }
    }
}
