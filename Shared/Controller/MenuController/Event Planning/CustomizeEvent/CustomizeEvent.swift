//
//  CustomizeEvent.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 24/08/2021.
//

import UIKit

class CustomizeEvent: MenuController {
            

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowHeaderView = false
        MenuLabel.isHidden = true
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
        
        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: ControlX(80), width: view.frame.width - ControlWidth(30), height: view.frame.height - ControlWidth(80))
    }

    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Customize Wedding"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }

}
