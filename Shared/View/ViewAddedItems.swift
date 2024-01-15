//
//  ViewAddedItems.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/08/2021.
//

import UIKit

class ViewAddedItems: UIView {
    
    @IBInspectable var Items:Int = 0 {
    didSet {
    AddedLabel.text = "\(Items) items added In Cart"
    }
    }
    
    lazy var AddedLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    override func draw(_ rect: CGRect) {
    addSubview(AddedLabel)
    AddedLabel.frame = CGRect(x: ControlX(15), y: 0, width: rect.width - ControlWidth(30), height: ControlWidth(60))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 1.0)
    }
    
    func Show() {
    self.isHidden = false
    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],animations: {
    self.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY - ControlWidth(60), width: UIScreen.main.bounds.width, height: ControlWidth(60))
    })
    }
    
    func animShow() {
    self.isHidden = false
    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],animations: {
    self.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY - ControlWidth(60), width: UIScreen.main.bounds.width, height: ControlWidth(60))
    self.timr.invalidate()
    self.timr = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.Time), userInfo: nil, repeats: true)
    self.layoutIfNeeded()
    })
    }

    var timr = Timer()
    @objc func Time() {
    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],animations: {
    self.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: UIScreen.main.bounds.width, height: 0)
    self.layoutIfNeeded()
    self.timr.invalidate()
    self.isHidden = true
    })
    }

    
    func animHide() {
    self.isHidden = true
    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],animations: {
    self.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: UIScreen.main.bounds.width, height: ControlWidth(60))
    self.layoutIfNeeded()
    })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
