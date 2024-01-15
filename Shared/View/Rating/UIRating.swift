//
//  UIRating.swift
//  UIRating
//
//  Created by Arman Zoghi on 1/23/21.
//

import Foundation
import UIKit

/// The delegate protocol used by UIRating.
public protocol UIRatingDelegate {
    /// Returns the rating selected.
    /// - Parameter rating: The selected rating.
    func currentRating(rating: Double)
}

/// A customizable rating view.
 class UIRating: UIView {
    
    var Value: Int = 5
    fileprivate let slider = UISlider()
    fileprivate let stackView = UIStackView()
    fileprivate var option: Float!
    fileprivate var animationHandler = false
    fileprivate var rating: Double = 0.0
    
    var SetRating: Int = 0 {
        didSet {
        optionsConfig(rating: SetRating)
        }
    }
    
    /// Sets the amount of option to rate from.
    var numberOfOptions: Int = 5 {
        didSet {
        }
    }
    /// Allows the selection of half ratings if set to true.
    var allowHalfSelection = false {
        didSet {

        }
    }
    /// Sets the spacing between options.
    var spacing: CGFloat = ControlHeight(2) {
        didSet {
            self.stackView.spacing = self.spacing
        }
    }
    
    /// The delegate for UIRating.
    var delegate: UIRatingDelegate?
    
    //icons
    /// Sets the icon to use for an empty rating.
     lazy var emptyIcon = UIImage(named: "flower2")?.withInset(UIEdgeInsets(top: ControlY(6), left: 0, bottom: ControlY(6), right: ControlX(3)))

    /// Sets the icon to use for a half rating.
    lazy var halfFullIcon = UIImage(named: "flower")?.withInset(UIEdgeInsets(top: ControlY(6), left: 0, bottom: ControlY(6), right: ControlX(3)))
    /// Sets the icon to use for a full rating.
    lazy var fullIcon     = UIImage(named: "flower")?.withInset(UIEdgeInsets(top: ControlY(6), left: 0, bottom: ControlY(6), right: ControlX(3)))
    
//MARK: View life cycle
    
    /// The default initializer for UIRating.
    /// - Parameter frame: Sets the frame for the UIRating instance.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        slider.isEnabled = false
        self.allConfigs()
    }
    
    /// The required coder initializer for UIRating.
    /// - Parameter coder: NSCoder.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
//MARK: - all configs
    fileprivate func allConfigs() {
        
        self.sliderConfig()
        
        self.stackViewConfig()
    }
    
//MARK: - Slider
    //config
    fileprivate func sliderConfig() {
        self.addSubview(self.slider)
        self.sliderConstraints()
        self.slider.setThumbImage(UIImage(), for: .normal)
        self.slider.setMinimumTrackImage(UIImage(), for: .normal)
        self.slider.setMaximumTrackImage(UIImage(), for: .normal)
        self.addSliderGesturesAndTargets()
    }
    //gestures
    fileprivate func addSliderGesturesAndTargets() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.sliderTapped(gestureRecognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.sliderTapped(gestureRecognizer:)))
        self.slider.addGestureRecognizer(tapGestureRecognizer)
        self.slider.addGestureRecognizer(panGestureRecognizer)
        self.slider.addTarget(self, action: #selector(self.sliderUpdated(_:)), for: .valueChanged)
        self.slider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: .touchUpInside)
        self.slider.addTarget(self, action: #selector(self.sliderBeingDragged(_:)), for: .touchDown)
    }
    //constraints
    fileprivate func sliderConstraints() {
        self.slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.slider, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.slider, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.slider, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.slider, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }
    
//MARK: - all configs
    //configs
    fileprivate func stackViewConfig() {
        self.addSubview(self.stackView)
        self.stackViewConstraints()
        self.stackView.isUserInteractionEnabled = false
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = self.spacing
    }
    //constraints
    fileprivate func stackViewConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
//MARK: - icon
    //config
    fileprivate func optionsConfig(rating:Int) {
        
        for image in 0...numberOfOptions - 1 {
        let option1 = UIImageView()
        option1.contentMode = .scaleAspectFill
           
        if image > rating - 1 {
        option1.image = self.emptyIcon
        }else{
        option1.image = self.fullIcon
        }
           
        if self.stackView.arrangedSubviews.count - 1 < image {
        self.stackView.addArrangedSubview(option1)
        }
        }
        
        self.option = 1 / Float(self.numberOfOptions)
    }
    
        
//MARK: - Slider objc
    @objc fileprivate func sliderUpdated(_ slider: UISlider) {
        let y = 1 / Float(self.numberOfOptions)
        var ratingIncrease:Double = 1.0
        
        if self.allowHalfSelection == true {
            ratingIncrease = 0.5
        }
        
        for i in 0...(numberOfOptions - 1) {
            let imageView = self.stackView.arrangedSubviews[i] as! UIImageView
            if self.allowHalfSelection && self.slider.value > (self.option - y) && self.slider.value < (self.option - y + (y / 2)) {
                self.rating += ratingIncrease
                if imageView.image != self.halfFullIcon {
                    UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        imageView.image = self.halfFullIcon
                    }, completion: nil)
                }
            } else
            if self.slider.value > (self.option - y) {
                if self.allowHalfSelection {
                    self.rating += ratingIncrease
                }
                self.rating += ratingIncrease
                if imageView.image != self.fullIcon {
                    UIView.transition(with: imageView, duration: 0.3, options: .transitionFlipFromLeft) {
                        imageView.image = self.fullIcon
                        imageView.transform = CGAffineTransform.init(translationX: 0, y: -ControlY(11))
                    } completion: { (_) in
                        UIView.animate(withDuration: 0.2) {
                            imageView.transform = .identity
                        }
                    }
                }
            } else {
                if imageView.image != self.emptyIcon {
                    if self.rating < 0 {
                        self.rating -= ratingIncrease
                    }
                    UIView.transition(with: imageView, duration: 0.3, options: .transitionFlipFromRight) {
                        imageView.image = self.emptyIcon
                    }
                }
            }
            self.option += y
        }
        
        Value = Int(self.rating)
        self.delegate?.currentRating(rating: self.rating)
        self.rating = 0
        self.option = y //reset
    }
    
    @objc fileprivate func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
        
        slider.minimumValue = 0.20
        let pointTapped: CGPoint = gestureRecognizer.location(in: self.slider)
        let positionOfSlider: CGPoint = self.slider.frame.origin
        let widthOfSlider: CGFloat = self.slider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(self.slider.maximumValue) / widthOfSlider)
        self.slider.setValue(Float(newValue), animated: true)
        if gestureRecognizer.state == .ended {
                
        }
        self.sliderUpdated(self.slider)
        
    }
    
    @objc fileprivate func sliderBeingDragged(_ sender: UIScrollView) {
        
        self.sliderUpdated(self.slider)
    }
    
    @objc fileprivate func sliderValueChanged(_ sender: UIScrollView) {
        
        
        self.sliderUpdated(self.slider)
    }
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    func SetUpTitleLabel(TitleText:String) {
        addSubview(TitleLabel)
        TitleLabel.bottomAnchor.constraint(equalTo: self.topAnchor , constant: -ControlHeight(2)).isActive = true
        TitleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - ControlWidth(50)).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: ControlHeight(28)).isActive = true
        TitleLabel.text = TitleText
        layer.masksToBounds = false
        clipsToBounds = false
        slider.isEnabled = true
    }
    
}

//MARK: - Delegate
extension UIRating: UIRatingDelegate {
    public func currentRating(rating: Double) {
        
    }
}
