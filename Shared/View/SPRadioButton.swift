//
//  SPRadioButton.swift
//  Color
//
//  Created by Mahmoud Abd El Tawab on 6/24/19.
//  Copyright © 2019 Mahmoud Abd El Tawab. All rights reserved.
//

import UIKit
@IBDesignable
class SPRadioButton: UIButton {
    
    @IBInspectable
    var gap:CGFloat = ControlWidth(13.4) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var WidthHeight:CGFloat = ControlWidth(16) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var btnColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var fillColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var isOn: Bool = false {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var Space:CGFloat = ControlWidth(12) {
    didSet {
    self.setNeedsDisplay()
    }
    }
    
    
    @IBInspectable var text:String = "" {
      didSet {
      Label.text = text
      }
    }
    
    
     lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .left
        Label.backgroundColor = .clear
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        return Label
    }()
    
    override func draw(_ rect: CGRect) {
        self.contentMode = .scaleAspectFill
        self.backgroundColor = .clear
        drawCircles(rect: rect)
    }
    
    
    //MARK:- Draw inner and outer circles
    
    func drawCircles(rect: CGRect) {
        var path = UIBezierPath()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: rect.midY - (WidthHeight / 2), width: WidthHeight, height: WidthHeight))
        addSubview(Label)
        Label.frame = CGRect(x: WidthHeight + Space, y: (rect.midY - (WidthHeight / 2)) + 1, width: frame.width - WidthHeight - Space, height: WidthHeight)
    
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.path = path.cgPath
        circleLayer.lineWidth = 1.1
        circleLayer.strokeColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        layer.addSublayer(circleLayer)
        
        
        if self.isOn {
        let innerCircleLayer = CAShapeLayer()
        let rectForInnerCircle = CGRect(x: self.gap, y: (rect.midY - (WidthHeight / 2)) + self.gap, width: self.WidthHeight - 2 * self.gap, height: self.WidthHeight - 2 * self.gap)
        innerCircleLayer.path = UIBezierPath(ovalIn: rectForInnerCircle).cgPath
        innerCircleLayer.fillColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
    
        self.layer.addSublayer(innerCircleLayer)

         let flash = CABasicAnimation(keyPath: "opacity")
         flash.duration = 0.4
         flash.fromValue = 1 // alpha
         flash.toValue = 0.2 // alpha
         flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
         flash.autoreverses = true
         flash.repeatCount = 1
         innerCircleLayer.add(flash, forKey: nil)
        }
        self.layer.shouldRasterize =  true
        self.layer.rasterizationScale = UIScreen.main.nativeScale
        
    }
    

}

