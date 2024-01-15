//
//  VenueSketchVC.swift
//  JMK (iOS)
//
//  Created by Emojiios on 12/01/2022.
//

import UIKit

class VenueSketchVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
    }
 
    fileprivate func SetUp() {
        
    view.addSubview(Dismiss)
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(30), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
    
    ViewScroll.addSubview(ImageView)
    ImageView.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlWidth(30), height: ControlWidth(280))
        
    ViewScroll.addSubview(LabelFromTo)
    LabelFromTo.frame = CGRect(x: ControlX(15), y: ImageView.frame.maxY + ControlX(5) , width: view.frame.width - ControlWidth(30), height: ControlWidth(30))
        
    guard let DetailHeight = Detail.heightWithConstrainedWidth(view.frame.width - ControlWidth(30), font: UIFont.boldSystemFont(ofSize:ControlWidth(15)), Spacing: ControlHeight(5)) else{return}
        
    ViewScroll.addSubview(DetailLabel)
    DetailLabel.frame = CGRect(x: ControlX(15), y: LabelFromTo.frame.maxY + ControlX(5) , width: view.frame.width - ControlWidth(30), height: DetailHeight)
        
    ViewScroll.addSubview(Checkout)
    Checkout.frame = CGRect(x: ControlX(15), y: DetailLabel.frame.maxY + ControlX(30) , width: view.frame.width - ControlWidth(30), height: ControlWidth(50))
        
    // MARK: - ViewScroll contentSize height
    self.ViewScroll.updateContentViewSize(ControlWidth(30))
    }
    
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Concept Venue Sketch"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
        self.navigationController?.popViewController(animated: true)
    }

    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.showsVerticalScrollIndicator = false
        Scroll.bounces = true
        return Scroll
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "Sketch")
        ImageView.contentMode = .scaleAspectFill
        ImageView.backgroundColor = .clear
        ImageView.clipsToBounds = true
        return ImageView
    }()

    lazy var LabelFromTo : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1417151988, green: 0.1417151988, blue: 0.1417151988, alpha: 1)
        Label.text = "2300-2500 EGP"
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        return Label
    }()
    
    let Detail = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    lazy var DetailLabel : UILabel = {
    let label = UILabel()
    label.text =  Detail
    label.numberOfLines = 0
    label.backgroundColor = .clear
    label.spasing = ControlHeight(5)
    label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(15))
    return label
    }()
    
    lazy var Checkout : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Checkout", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionCheckout), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionCheckout() {
    Present(ViewController: self, ToViewController: CheckoutVC())
    }


}


