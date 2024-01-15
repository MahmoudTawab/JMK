//
//  IGStoryPreviewHeaderView.swift
//  InstagramStories
//
//  Created by Boominadha Prakash on 06/09/17.
//  Copyright © 2017 DrawRect. All rights reserved.
//

import UIKit

protocol StoryPreviewHeaderProtocol:AnyObject {func didTapCloseButton()}

fileprivate let maxSnaps = 30

//Identifiers
public let progressIndicatorViewTag = 88
public let progressViewTag = 99

final class IGStoryPreviewHeaderView: UIView {
    
    //MARK: - iVars
    public weak var delegate:StoryPreviewHeaderProtocol?
    fileprivate var snapsPerStory: Int = 0
    public var story:IGStory? {
        didSet {
            snapsPerStory  = (story?.snapsCount)! < maxSnaps ? (story?.snapsCount)! : maxSnaps
        }
    }
    
    fileprivate var progressView: UIView?
    internal let snaperImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = ControlHeight(1.0)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let detailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let snaperNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(20))
        return label
    }()
    
    internal let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(20))
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "ic_close")?.withInset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapClose(_:)), for: .touchUpInside)
        return button
    }()
    public var getProgressView: UIView {
        if let progressView = self.progressView {
            return progressView
        }
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        self.progressView = v
        self.addSubview(self.getProgressView)
        return v
    }
    
    //MARK: - Overriden functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        applyShadowOffset()
        loadUIElements()
        installLayoutConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Private functions
    private func loadUIElements(){
        backgroundColor = .clear
        addSubview(getProgressView)
        addSubview(snaperImageView)
        addSubview(detailView)
        detailView.addSubview(snaperNameLabel)
        detailView.addSubview(lastUpdatedLabel)
        addSubview(closeButton)
    }
    private func installLayoutConstraints(){
        //Setting constraints for progressView
        let pv = getProgressView
        NSLayoutConstraint.activate([
            pv.igLeftAnchor.constraint(equalTo: self.igLeftAnchor),
            pv.igTopAnchor.constraint(equalTo: self.igTopAnchor, constant: ControlY(8)),
            self.igRightAnchor.constraint(equalTo: pv.igRightAnchor),
            pv.heightAnchor.constraint(equalToConstant: ControlWidth(10))
            ])
        
        //Setting constraints for snapperImageView
        NSLayoutConstraint.activate([
            snaperImageView.widthAnchor.constraint(equalToConstant: ControlWidth(50)),
            snaperImageView.heightAnchor.constraint(equalToConstant: ControlWidth(50)),
            snaperImageView.igLeftAnchor.constraint(equalTo: self.igLeftAnchor, constant: ControlX(10)),
            snaperImageView.topAnchor.constraint(equalTo: self.topAnchor , constant: ControlX(25)),
            detailView.igLeftAnchor.constraint(equalTo: snaperImageView.igRightAnchor, constant: ControlX(10))
            ])
        layoutIfNeeded() //To make snaperImageView round. Adding this to somewhere else will create constraint warnings.
        
        //Setting constraints for detailView
        NSLayoutConstraint.activate([
            detailView.igLeftAnchor.constraint(equalTo: snaperImageView.igRightAnchor, constant: ControlX(10)),
            detailView.igCenterYAnchor.constraint(equalTo: snaperImageView.centerYAnchor),
            detailView.heightAnchor.constraint(equalToConstant: ControlWidth(50)),
            closeButton.igLeftAnchor.constraint(equalTo: detailView.igRightAnchor, constant: ControlX(10))
            ])
        
        //Setting constraints for closeButton
        NSLayoutConstraint.activate([
            closeButton.igLeftAnchor.constraint(equalTo: detailView.igRightAnchor, constant: ControlX(10)),
            closeButton.igCenterYAnchor.constraint(equalTo: snaperImageView.centerYAnchor),
            closeButton.igRightAnchor.constraint(equalTo: self.igRightAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: ControlWidth(50)),
            closeButton.heightAnchor.constraint(equalToConstant: ControlWidth(50))
            ])
        
        //Setting constraints for snapperNameLabel
        NSLayoutConstraint.activate([
            snaperNameLabel.igLeftAnchor.constraint(equalTo: detailView.igLeftAnchor),
            lastUpdatedLabel.igLeftAnchor.constraint(equalTo: snaperNameLabel.igRightAnchor, constant: ControlX(10)),
            snaperNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: ControlWidth(100)),
            snaperNameLabel.igCenterYAnchor.constraint(equalTo: snaperImageView.centerYAnchor)
            ])
        
        //Setting constraints for lastUpdatedLabel
        NSLayoutConstraint.activate([
            lastUpdatedLabel.igCenterYAnchor.constraint(equalTo: snaperImageView.centerYAnchor),
            lastUpdatedLabel.igLeftAnchor.constraint(equalTo: snaperNameLabel.igRightAnchor, constant: ControlX(10))
            ])
    }
    private func applyShadowOffset() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
    }
    private func applyProperties<T: UIView>(_ view: T, with tag: Int? = nil, alpha: CGFloat = 1.0) -> T {
        view.layer.cornerRadius = ControlHeight(1)
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white.withAlphaComponent(alpha)
        if let tagValue = tag {
            view.tag = tagValue
        }
        return view
    }
    
    //MARK: - Selectors
    @objc func didTapClose(_ sender: UIButton) {
        delegate?.didTapCloseButton()
    }
    
    //MARK: - Public functions
    public func clearTheProgressorSubviews() {
        getProgressView.subviews.forEach { v in
            v.subviews.forEach{v in (v as! IGSnapProgressView).stop()}
            v.removeFromSuperview()
        }
    }
    public func clearAllProgressors() {
        clearTheProgressorSubviews()
        getProgressView.removeFromSuperview()
        self.progressView = nil
    }
    public func clearSnapProgressor(at index:Int) {
        getProgressView.subviews[index].removeFromSuperview()
    }
    
    public func createSnapProgressors() {
        //////////////////////////////
//        print("Progressor count: \(getProgressView.subviews.count)")
            
        let padding: CGFloat = ControlWidth(8)
        let height: CGFloat = ControlWidth(3)
        var pvIndicatorArray: [IGSnapProgressIndicatorView] = []
        var pvArray: [IGSnapProgressView] = []
        
        // Adding all ProgressView Indicator and ProgressView to seperate arrays
        for i in 0..<snapsPerStory{
            let pvIndicator = IGSnapProgressIndicatorView()
            pvIndicator.translatesAutoresizingMaskIntoConstraints = false
            getProgressView.addSubview(applyProperties(pvIndicator, with: i+progressIndicatorViewTag, alpha:0.2))
            pvIndicatorArray.append(pvIndicator)
            
            let pv = IGSnapProgressView()
            pv.translatesAutoresizingMaskIntoConstraints = false
            pvIndicator.addSubview(applyProperties(pv))
            pvArray.append(pv)
        }
        // Setting Constraints for all progressView indicators
        for index in 0..<pvIndicatorArray.count {
            let pvIndicator = pvIndicatorArray[index]
            if index == 0 {
                pvIndicator.leftConstraiant = pvIndicator.igLeftAnchor.constraint(equalTo: self.getProgressView.igLeftAnchor, constant: padding)
                NSLayoutConstraint.activate([
                    pvIndicator.leftConstraiant!,
                    pvIndicator.igCenterYAnchor.constraint(equalTo: self.getProgressView.igCenterYAnchor),
                    pvIndicator.heightAnchor.constraint(equalToConstant: height)
                    ])
                if pvIndicatorArray.count == 1 {
                    pvIndicator.rightConstraiant = self.getProgressView.igRightAnchor.constraint(equalTo: pvIndicator.igRightAnchor, constant: padding)
                    pvIndicator.rightConstraiant!.isActive = true
                }
            }else {
                let prePVIndicator = pvIndicatorArray[index-1]
                pvIndicator.widthConstraint = pvIndicator.widthAnchor.constraint(equalTo: prePVIndicator.widthAnchor, multiplier: 1.0)
                pvIndicator.leftConstraiant = pvIndicator.igLeftAnchor.constraint(equalTo: prePVIndicator.igRightAnchor, constant: padding)
                NSLayoutConstraint.activate([
                    pvIndicator.leftConstraiant!,
                    pvIndicator.igCenterYAnchor.constraint(equalTo: prePVIndicator.igCenterYAnchor),
                    pvIndicator.heightAnchor.constraint(equalToConstant: height),
                    pvIndicator.widthConstraint!
                    ])
                if index == pvIndicatorArray.count-1 {
                    pvIndicator.rightConstraiant = self.igRightAnchor.constraint(equalTo: pvIndicator.igRightAnchor, constant: padding)
                    pvIndicator.rightConstraiant!.isActive = true
                }
            }
        }
        // Setting Constraints for all progressViews
        for index in 0..<pvArray.count {
            let pv = pvArray[index]
            let pvIndicator = pvIndicatorArray[index]
            pv.widthConstraint = pv.widthAnchor.constraint(equalToConstant: 0)
            NSLayoutConstraint.activate([
                pv.igLeftAnchor.constraint(equalTo: pvIndicator.igLeftAnchor),
                pv.heightAnchor.constraint(equalTo: pvIndicator.heightAnchor),
                pv.igTopAnchor.constraint(equalTo: pvIndicator.igTopAnchor),
                pv.widthConstraint!
                ])
        }
        
        snaperNameLabel.text = story?.Title
    }
    
}
