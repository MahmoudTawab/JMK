//
//  VKProgressHud.swift
//  VKProgressHud
//
//  Created by Vamshi Krishna on 25/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


public enum AlertStyle {
    case success,error,nono
}

class VKProgressHud: UIView {
    
    let rotatorImageLayer: CALayer = CALayer()
    let replicatorCircleLayer = CAReplicatorLayer()
    var circle = CALayer()
    var shapeLayerForCroc = CAShapeLayer()
    
    var dotLength:CGFloat = ControlWidth(12)
    var instanceCount:Int = Int(ControlWidth(12))
    var animationDuration = CFTimeInterval(ControlWidth(2.5))

    override func draw(_ rect: CGRect) {
        
        addSubview(ViewBackground)
        let label = VKLabel(frame: CGRect(origin: CGPoint(x: ViewBackground.center.x - (width/2),y: ViewBackground.center.y - ControlWidth(10)), size: CGSize(width: width, height: ControlWidth(20))))
        label.text = "LOADING"
        ViewBackground.addSubview(label)
        
        self.alpha = 0
    }
    
    func Animation() {
        
        let width = ViewBackground.frame.width - ControlWidth(80)
        let height = ViewBackground.frame.height - ControlWidth(80)
        
        replicatorCircleLayer.frame = CGRect(x: ControlWidth(40), y: ControlWidth(40), width: width, height: height)
        
        circle.frame = CGRect(origin: CGPoint.zero,
        size: CGSize(width: dotLength, height: dotLength))
        circle.cornerRadius = dotLength/2
        circle.backgroundColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
        
        
        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorCircleLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorCircleLayer.backgroundColor = UIColor.clear.cgColor
         ViewBackground.layer.addSublayer(replicatorCircleLayer)
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: ViewBackground.bounds.size.width / 2.0,y: ViewBackground.bounds.size.height / 2.0), radius: (width/2)+dotLength-2, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        shapeLayerForCroc.path = circlePath.cgPath
        shapeLayerForCroc.fillColor = UIColor.clear.cgColor
         ViewBackground.layer.addSublayer(shapeLayerForCroc)
        
        let airplaneImage = UIImageView()
        airplaneImage.backgroundColor = .clear
        airplaneImage.image = UIImage(named:"like (2)")?.withRenderingMode(.alwaysTemplate)
        airplaneImage.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
        rotatorImageLayer.contents = airplaneImage.image?.cgImage
        rotatorImageLayer.frame = CGRect(x: 0, y: 0,
                                    width: ControlWidth(20),
                                    height: ControlWidth(20))
        
        rotatorImageLayer.opacity = 1.0
        rotatorImageLayer.backgroundColor = UIColor.clear.cgColor
        ViewBackground.layer.addSublayer(rotatorImageLayer)
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.3
        fadeOut.toValue = 1
        fadeOut.duration = animationDuration
        fadeOut.repeatCount = Float.greatestFiniteMagnitude
        
        circle.add(fadeOut, forKey: nil)
        
        replicatorCircleLayer.instanceDelay = fadeOut.duration / CFTimeInterval(instanceCount)
        replicatorCircleLayer.addSublayer(circle)
        replicatorCircleLayer.instanceCount = instanceCount
        
        let crocAnimationPos = CAKeyframeAnimation(keyPath: "position")
        crocAnimationPos.path = self.shapeLayerForCroc.path
        crocAnimationPos.calculationMode = CAAnimationCalculationMode.linear
    
        let crocOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        crocOrientationAnimation.fromValue = 0
        crocOrientationAnimation.toValue = 2.0 * .pi
        
        let crocAnimation = CAAnimationGroup()
        crocAnimation.duration = self.animationDuration
        crocAnimation.repeatDuration = .infinity
        crocAnimation.animations = [crocAnimationPos, crocOrientationAnimation]
        self.rotatorImageLayer.add(crocAnimation, forKey: nil)
        
        ViewBackground.layer.cornerRadius = ControlWidth(18)
        ViewBackground.layer.masksToBounds = true
    }
    
    
    func endRefreshing(_ Title:String = "" ,_ AlertStyle: AlertStyle = .nono ,_ completion: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        self.timer.invalidate()
        UIView.animate(withDuration: 0.5) {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.alpha = 0
        } completion: { (_) in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.Show = false
        }
            
        if AlertStyle == .error {
        ShowMessageAlert("𝗶","Error", Title, true){}
        }else if AlertStyle == .success {
        ShowMessageAlert("✓","Success", Title, true){}
        }
            
        completion()
        }
        }
    }
  
    var Show = false
    var timer = Timer()
    func beginRefreshing() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    if !self.Show {
    self.Show = true
    self.Animation()
    self.timer = Timer.scheduledTimer(timeInterval: 25, target: self, selector: #selector(self.TimedOut), userInfo: self, repeats: false)
    UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
    self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
    self.alpha = 1
    self.transform = .identity
    })
    }
    }
    }
    
    @objc func TimedOut() {
    if self.Show && self.alpha != 0 {
    self.Show = false
    self.timer.invalidate()
    UIView.animate(withDuration: 0.5) {
    self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    self.alpha = 0
    } completion: { (_) in
    }
    }
    }
    
    lazy var ViewBackground : UIView = {
        let View = UIView(frame: CGRect(x: self.center.x - ControlWidth(80), y: self.center.y - ControlWidth(80), width: ControlWidth(160), height: ControlWidth(160)))
        View.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.3704603314, blue: 0.349206537, alpha: 1)
        return View
    }()

    
}


class VKLabel: UIView {
    
    let gradientLabelLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [
            UIColor.black.cgColor,
            UIColor.white.cgColor,
            UIColor.black.cgColor,
            ]
        gradient.colors = colors
        
        let locations: [NSNumber] = [
            0.0, 0.5 ,1.0
        ]
        gradient.locations = locations
        
        return gradient
    }()
    
    
    let textAttributesForLabel: [NSAttributedString.Key: Any] = {
        let ps = NSMutableParagraphStyle()
        ps.alignment = .center
        return [
            
            NSAttributedString.Key.paragraphStyle as NSAttributedString.Key: ps,.font: UIFont(name: "Raleway-MediumItalic", size: ControlWidth(15)) ?? UIFont.boldSystemFont(ofSize: ControlWidth(15))
        ]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            
             let image = UIGraphicsImageRenderer(size: bounds.size)
                .image { _ in
                    text.draw(in: bounds, withAttributes: textAttributesForLabel as [NSAttributedString.Key : Any])
            }
            
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image.cgImage
            
            gradientLabelLayer.mask = maskLayer
        }
    }
    
    
    override func layoutSubviews() {
        gradientLabelLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 3 * bounds.size.width,
            height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.addSublayer(gradientLabelLayer)
        
        let labelAnimation = CABasicAnimation(keyPath: "locations")
        labelAnimation.fromValue = [0.0, 0.0, 0.25]
        labelAnimation.toValue = [0.75, 1.0, 1.0]
        labelAnimation.duration = 1.5
        labelAnimation.repeatCount = Float.infinity
        
        gradientLabelLayer.add(labelAnimation, forKey: nil)
    }
    
}
