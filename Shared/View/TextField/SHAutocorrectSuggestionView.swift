// Copyright © 2021 SpotHero, Inc. All rights reserved.


import Foundation
import UIKit

class SHAutocorrectSuggestionView: UIView {
        
     private static let cornerRadius: CGFloat = ControlWidth(6)
     private static let arrowHeight: CGFloat = ControlWidth(12)
     private static let arrowWidth: CGFloat = ControlWidth(8)
     var Show = false
    
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(10))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
        override public init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override public func draw(_ rect: CGRect) {
            let contentSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height - Self.arrowHeight)
            let arrowBottom = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height)

            let path = CGMutablePath()
        
            path.move(to: CGPoint(x: arrowBottom.x, y: arrowBottom.y))
            path.addLine(to: CGPoint(x: arrowBottom.x - Self.arrowWidth, y: arrowBottom.y - Self.arrowHeight))

            path.addArc(tangent1End: CGPoint(x: 0, y: contentSize.height),
                        tangent2End: CGPoint(x: 0, y: contentSize.height - Self.cornerRadius),
                        radius: Self.cornerRadius)
            path.addArc(tangent1End: CGPoint(x: 0, y: 0),
                        tangent2End: CGPoint(x: Self.cornerRadius, y: 0),
                        radius: Self.cornerRadius)
            path.addArc(tangent1End: CGPoint(x: contentSize.width, y: 0),
                        tangent2End: CGPoint(x: contentSize.width, y: Self.cornerRadius),
                        radius: Self.cornerRadius)
            path.addArc(tangent1End: CGPoint(x: contentSize.width, y: contentSize.height),
                        tangent2End: CGPoint(x: contentSize.width - Self.cornerRadius, y: contentSize.height),
                        radius: Self.cornerRadius)
        
            path.addLine(to: CGPoint(x: arrowBottom.x + Self.arrowWidth, y: arrowBottom.y - Self.arrowHeight))
        
            path.closeSubpath()
        
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
        
            context.saveGState()
        
            context.addPath(path)
            context.clip()
        

            context.setFillColor(UIColor(red: 232/255, green: 199/255, blue: 199/255, alpha: 1).cgColor)
            context.fill(bounds)
        
            context.restoreGState()
        }
    
        
        public func show(from target: CGRect, inContainerView container: UIView) {
        if !Show {
        self.alpha = 0.2
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        self.frame = target
        container.addSubview(self)
        addSubview(Label)
        Label.topAnchor.constraint(equalTo: self.topAnchor ,constant:ControlY(-1)).isActive = true
        Label.leftAnchor.constraint(equalTo: self.leftAnchor, constant:ControlX(5)).isActive = true
        Label.rightAnchor.constraint(equalTo: self.rightAnchor, constant:ControlX(-5)).isActive = true
        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:ControlY(-12)).isActive = true
        
        UIView.animate(
        withDuration: 0.2,
        animations: {
        self.alpha = 1
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        },completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
        self.transform = .identity
        },completion: { _ in
        self.Show = true
        })
        })
        }
        }
    
        public func dismiss() {
        if Show {
        UIView.animate(
        withDuration: 0.1,
        animations: {
        self.transform = self.transform.scaledBy(x: 1.05, y: 1.05)
        },completion: { _ in
        UIView.animate(
        withDuration: 0.2,
        animations: {
        self.alpha = 0
        self.transform = self.transform.scaledBy(x: 0.8, y: 0.8)
        },completion: { _ in
        self.removeFromSuperview()
        self.Show = false
        })
        })
        }
        }
        
    }
