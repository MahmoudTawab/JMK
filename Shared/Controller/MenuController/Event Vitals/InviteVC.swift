//
//  InviteVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 22/07/2021.
//

import UIKit

class InviteVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUp()
        
    }
    
    func SetUp() {
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
        
        ViewScroll.addSubview(DetailsTV)
        
        DetailsTV.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(15)).isActive = true
        DetailsTV.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
        DetailsTV.topAnchor.constraint(equalTo: ViewScroll.topAnchor, constant: ControlY(10)).isActive = true
        DetailsTV.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
        
        ViewScroll.addSubview(borderTV)
        borderTV.leadingAnchor.constraint(equalTo: DetailsTV.leadingAnchor).isActive = true
        borderTV.trailingAnchor.constraint(equalTo: DetailsTV.trailingAnchor).isActive = true
        borderTV.bottomAnchor.constraint(equalTo: DetailsTV.bottomAnchor, constant: ControlX(5)).isActive = true
        borderTV.heightAnchor.constraint(equalToConstant: ControlWidth(1)).isActive = true
        
        ViewScroll.addSubview(Stack1)
        ViewScroll.addSubview(LinkType)
        
        ViewScroll.addSubview(Static)
        ViewScroll.addSubview(Animated)
        ViewScroll.addSubview(ThePrice)

        ViewScroll.addSubview(StackItems)
        
        Stack1.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(15)).isActive = true
        Stack1.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
        Stack1.topAnchor.constraint(equalTo: DetailsTV.bottomAnchor, constant: ControlX(40)).isActive = true
        Stack1.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        LinkType.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(15)).isActive = true
        LinkType.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
        LinkType.topAnchor.constraint(equalTo: Stack1.bottomAnchor, constant: ControlX(15)).isActive = true
        LinkType.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true

        Static.leftAnchor.constraint(equalTo: Link.leftAnchor).isActive = true
        Static.rightAnchor.constraint(equalTo: Link.rightAnchor).isActive = true
        Static.topAnchor.constraint(equalTo: LinkType.bottomAnchor, constant: ControlX(15)).isActive = true
        Static.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        
        Animated.leftAnchor.constraint(equalTo: HardCopy.leftAnchor).isActive = true
        Animated.rightAnchor.constraint(equalTo: HardCopy.rightAnchor).isActive = true
        Animated.topAnchor.constraint(equalTo: LinkType.bottomAnchor, constant: ControlX(15)).isActive = true
        Animated.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        ThePrice.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(15)).isActive = true
        ThePrice.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
        ThePrice.topAnchor.constraint(equalTo: Static.bottomAnchor, constant: ControlX(20)).isActive = true
        ThePrice.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true

        StackItems.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(15)).isActive = true
        StackItems.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
        StackItems.topAnchor.constraint(equalTo: ThePrice.bottomAnchor, constant: ControlX(20)).isActive = true
        StackItems.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        
    // MARK: - ViewScroll contentSize height
    ViewScroll.contentSize = CGSize(width: view.frame.width , height: view.frame.height)
    }
            
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Invitations"
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
        return Scroll
    }()

    
    lazy var  DetailsTV : GrowingTextView = {
    let TV = GrowingTextView()
    TV.placeholder = "Invitation details"
    TV.minHeight = ControlWidth(70)
    TV.maxHeight = ControlWidth(200)
    TV.placeholderColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 0.6)
    TV.backgroundColor = .clear
    TV.tintColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
    TV.textColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
    TV.autocorrectionType = .no
    TV.font = UIFont(name: "Raleway-Regular", size: ControlWidth(14))
    TV.translatesAutoresizingMaskIntoConstraints = false
    return TV
    }()
    
    lazy var borderTV : UIView = {
    let border = UIView()
    border.backgroundColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 0.6)
    border.translatesAutoresizingMaskIntoConstraints = false
    return border
    }()
    
    lazy var Stack1 : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [Link,HardCopy,Both])
    Stack.axis = .horizontal
    Stack.spacing = 10
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()


    lazy var Link : CheckboxInvite = {
        let View = CheckboxInvite()
        View.tag = 0
        View.ActionButton(Select: false)
        View.Label.text = "Link"
        View.addTarget(self, action: #selector(CheckboxTopAction(_:)), for: .touchUpInside)
        return View
    }()
    
    lazy var HardCopy : CheckboxInvite = {
        let View = CheckboxInvite()
        View.tag = 1
        View.ActionButton(Select: true)
        View.Label.text = "Hard copy"
        View.addTarget(self, action: #selector(CheckboxTopAction(_:)), for: .touchUpInside)
        return View
    }()
    
    lazy var Both : CheckboxInvite = {
        let View = CheckboxInvite()
        View.tag = 2
        View.ActionButton(Select: false)
        View.Label.text = "Both"
        View.addTarget(self, action: #selector(CheckboxTopAction(_:)), for: .touchUpInside)
        return View
    }()
    
    lazy var LinkType : UILabel = {
        let Label = UILabel()
        Label.text = "Link Type"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var Static : CheckboxInvite = {
        let View = CheckboxInvite()
        View.tag = 3
        View.ActionButton(Select: true)
        View.Label.text = "Static"
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addTarget(self, action: #selector(CheckboxBottomAction(_:)), for: .touchUpInside)
        return View
    }()
    
    lazy var Animated : CheckboxInvite = {
        let View = CheckboxInvite()
        View.tag = 4
        View.ActionButton(Select: false)
        View.Label.text = "Animated"
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addTarget(self, action: #selector(CheckboxBottomAction(_:)), for: .touchUpInside)
        return View
    }()
    
    var Price = 3529
    var AddAnimated = 500
    @objc func CheckboxTopAction(_ Checkbox:CheckboxInvite) {
        switch Checkbox.tag {
        case 0:
        Link.ActionButton(Select: true)
        HardCopy.ActionButton(Select: false)
        Both.ActionButton(Select: false)
        Price = 3579
        case 1:
        Link.ActionButton(Select: false)
        HardCopy.ActionButton(Select: true)
        Both.ActionButton(Select: false)
        Price = 3529
        case 2:
        Link.ActionButton(Select: false)
        HardCopy.ActionButton(Select: false)
        Both.ActionButton(Select: true)
        Price = 2929
        default:break
        }
        ThePrice.text = "EGP \(Price + AddAnimated)"
    }
    
    @objc func CheckboxBottomAction(_ Checkbox:CheckboxInvite) {
        switch Checkbox.tag {
        case 3:
        AddAnimated = 500
        Static.ActionButton(Select: true)
        Animated.ActionButton(Select: false)
        case 4:
        Static.ActionButton(Select: false)
        Animated.ActionButton(Select: true)
        AddAnimated = 800
        default:break
        }
        ThePrice.text = "EGP \(Price + AddAnimated)"
    }
    
    lazy var ThePrice : UILabel = {
        let Label = UILabel()
        Label.text = "EGP 4029"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [AddToCart,InviteViewButton])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(20)
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var AddToCart : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Add to Cart", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(AddInviteToCart), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    
    @objc func AddInviteToCart() {
        self.ProgressHud.beginRefreshing()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ProgressHud.endRefreshing() {self.navigationController?.popViewController(animated: true)}
        }
    }
    
    lazy var InviteViewButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("View Invite", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(InviteViewAction), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func InviteViewAction() {
        Present(ViewController: self, ToViewController: InviteView())
    }
}


class CheckboxInvite: UIButton {
    
    lazy var Image : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.tintColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()

    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(Image)
        addSubview(Label)
        
        Image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        Image.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        Image.heightAnchor.constraint(equalToConstant: ControlWidth(28)).isActive = true
        Image.widthAnchor.constraint(equalToConstant: ControlWidth(28)).isActive = true
        
        Label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        Label.leftAnchor.constraint(equalTo: Image.rightAnchor,constant: ControlX(10)).isActive = true
        Label.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        Label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    @objc func ActionButton(Select:Bool) {
    Image.image =  Select ? UIImage(named: "AddSelect") : UIImage(named: "AddNoSelect")
    if Select {
    UIView.animate(withDuration: 0.2, animations: {
    self.Image.transform = self.Image.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.2, animations: {
    self.Image.transform = .identity
    })
    })
    }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

