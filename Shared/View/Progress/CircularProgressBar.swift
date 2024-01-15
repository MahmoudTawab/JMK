//
//  CircularProgressBar.swift
//  Progress
//
//  Created by NiravPatel on 12/06/19.
//  Copyright © 2019 NiravPatel. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {
    
    lazy var ViewSlider : CircularSlider = {
        let View = CircularSlider()
        View.isEnabled = false
        View.lineWidth = ControlWidth(10)
        View.endThumbTintColor = .clear
        View.diskColor = .white
        View.diskFillColor = .white
        View.endThumbStrokeColor = .clear
        View.backgroundColor = .clear
        View.endThumbStrokeHighlightedColor = .clear
        View.thumbRadius = 0
        View.thumbLineWidth = 0
        View.backtrackLineWidth = ControlWidth(10)
        View.trackColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        return View
    }()
    
    //MARK: awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
    }
    
    override func draw(_ rect: CGRect) {
        addSubview(ViewSlider)
        ViewSlider.frame = self.bounds
        
        addSubview(labelNumber)
        labelNumber.frame = CGRect(x: 0, y: ViewSlider.center.y - ControlWidth(15), width: self.frame.width, height: ControlWidth(30))
        
        addSubview(labelTitel)
        labelTitel.frame = CGRect(x: 0, y: self.frame.maxY - ControlWidth(5), width: self.frame.width, height: ControlWidth(30))
    }

    
    lazy var labelNumber : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(24))
        return Label
    }()
    
    lazy var labelTitel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.font = UIFont(name: "Raleway-Regular",size: ControlWidth(15))
        return Label
    }()
    

}
