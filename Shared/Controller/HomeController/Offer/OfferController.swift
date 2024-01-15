//
//  OfferController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 18/07/2021.
//

import UIKit

class OfferController: ViewController, UIScrollViewDelegate {
    
    var Home :HomeController?
    var Offer : WhatWeOffer?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        
    }
    
    func SetUp() {
        
        DetailLabel.text = self.Offer?.body
        DetailLabel.spasing = ControlHeight(5)
        guard let DetailHeight = self.DetailLabel.text?.heightWithConstrainedWidth(view.frame.width - ControlWidth(40), font: UIFont.boldSystemFont(ofSize:ControlWidth(15)), Spacing: ControlHeight(5)) else{return}
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(30), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
        
        ViewScroll.addSubview(ImageView)
        ImageView.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlWidth(30), height: ControlWidth(220))
        
        ViewScroll.addSubview(DetailLabel)
        DetailLabel.frame = CGRect(x: ControlX(15), y: ImageView.frame.maxY , width: view.frame.width - ControlWidth(30), height: DetailHeight)        
        
        // MARK: - ViewScroll contentSize height
        self.ViewScroll.updateContentViewSize(ControlWidth(10))
    }
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "What we offer?"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
      self.navigationController?.popViewController(animated: true)
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = true
        Scroll.backgroundColor = .white
        return Scroll
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "maskGroup41")
        return ImageView
    }()
    
    lazy var DetailLabel : UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.numberOfLines = 0
    label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(15))
    return label
    }()
}


