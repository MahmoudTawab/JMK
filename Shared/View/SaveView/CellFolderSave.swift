//
//  CellFolderSave.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 18/08/2021.
//

import UIKit

class CellFolderSave: UICollectionViewCell {
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(10))
        return Label
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.backgroundColor = .clear
        return ImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        addSubview(LabelTitle)
        addSubview(ImageView)
        
        ImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - ControlHeight(30))
        
        LabelTitle.frame = CGRect(x: 0, y: ImageView.frame.maxY + ControlY(5), width: self.frame.width, height: ControlHeight(25))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
