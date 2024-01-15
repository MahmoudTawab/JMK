//
//  InviteView.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 22/07/2021.
//

import UIKit

class InviteView: ViewController, MediaBrowserDelegate  {
    
    var Title = String()
    var Image = UIImage()
    var Details = String()
    var Price = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Image = UIImage(named: "Invite2") ?? UIImage()
        Title = "Gold Invitation"
        Details = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr Lorem ipsum dolor sit amet, consetetur sadipscing elitr"
        Price = "EGP 3579"
        
        
        SetUp()
    }
    
    func SetUp() {
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
        
        ViewScroll.addSubview(RectangleView)
        RectangleView.frame = CGRect(x: 0, y: 0, width: ViewScroll.frame.width , height: ControlHeight(340))
        
        ViewScroll.addSubview(ImageView)
        ImageView.frame = CGRect(x: ControlX(60), y: 0, width: ViewScroll.frame.width - ControlWidth(120), height: ControlHeight(330))
        
        ViewScroll.addSubview(LabelTitle)
        LabelTitle.frame = CGRect(x: ControlX(15), y: ImageView.frame.maxY + ControlY(25), width: ViewScroll.frame.width - ControlWidth(30), height: ControlHeight(30))
        
        guard let DetailHeight = Details.heightWithConstrainedWidth(LabelTitle.frame.width, font: UIFont.boldSystemFont(ofSize: ControlWidth(16)), Spacing: ControlHeight(5)) else{return}
        ViewScroll.addSubview(LabelDetails)
        LabelDetails.frame = CGRect(x: ControlX(15), y: LabelTitle.frame.maxY, width: LabelTitle.frame.width, height: DetailHeight)
        
        ViewScroll.addSubview(PriceLabel)
        PriceLabel.frame = CGRect(x: ControlX(15), y: LabelDetails.frame.maxY + ControlY(10), width: LabelTitle.frame.width, height: ControlHeight(30))
 
        // MARK: - ViewScroll contentSize height
        self.ViewScroll.updateContentViewSize(ControlHeight(20))
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "\(Title)"
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
        Scroll.bounces = true
        return Scroll
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = Image
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DidSelect)))
        return ImageView
    }()
    
    @objc func DidSelect() {
        let browser = MediaBrowser(delegate: self)
        browser.enableGrid = false
        browser.title = "Invite"
        let nc = UINavigationController(rootViewController: browser)
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .coverVertical
        present(nc, animated: true)
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return 1
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: Image, caption: Title)
    return photo
    }
    
    lazy var RectangleView : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.8601452708, green: 0.8602899909, blue: 0.8601261973, alpha: 1)
        View.layer.shadowOpacity = 0.4
        View.layer.shadowOffset =  CGSize(width: -1, height: 1)
        View.layer.shadowRadius = 4
        View.backgroundColor = .white
        return View
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.text = Title
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(16))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.text = Details
        Label.spasing = ControlHeight(5)
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var PriceLabel : UILabel = {
        let Label = UILabel()
        Label.text = Price
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(18))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        return Label
    }()
    
}

