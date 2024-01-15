//
//  HasSubMultipleCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/08/2021.
//

import UIKit

protocol HasSubMultipleDelegate {
    func ActionHeart(Cell:HasSubMultipleCell)
    func CountTFDidEnd(Cell:HasSubMultipleCell)
    
    func CountMinus(Cell:HasSubMultipleCell)
    func CountPlus(Cell:HasSubMultipleCell)
    
    func AddHasSubMultipleToCart(Cell:HasSubMultipleCell)
}

class HasSubMultipleCell: UICollectionViewCell {
    
    var delegate:HasSubMultipleDelegate?
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(14))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(11))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ClassLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(11))
        Label.backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 1.0)
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    lazy var AddInviteToCart : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Add to Cart", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(12))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddInvite), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionAddInvite() {
    delegate?.AddHasSubMultipleToCart(Cell: self)
    }
    
    lazy var CountView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.isHidden = true
        
        View.addSubview(MinusButton)
        View.addSubview(PlusButton)
        View.addSubview(CountTF)
        MinusButton.topAnchor.constraint(equalTo: View.topAnchor).isActive = true
        MinusButton.leftAnchor.constraint(equalTo: View.leftAnchor).isActive = true
        MinusButton.heightAnchor.constraint(equalTo: View.heightAnchor).isActive = true
        MinusButton.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
                
        PlusButton.topAnchor.constraint(equalTo: View.topAnchor).isActive = true
        PlusButton.rightAnchor.constraint(equalTo: View.rightAnchor).isActive = true
        PlusButton.heightAnchor.constraint(equalTo: View.heightAnchor).isActive = true
        PlusButton.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        CountTF.topAnchor.constraint(equalTo: View.topAnchor).isActive = true
        CountTF.leftAnchor.constraint(equalTo: MinusButton.rightAnchor , constant: ControlX(8)).isActive = true
        CountTF.rightAnchor.constraint(equalTo: PlusButton.leftAnchor , constant: ControlX(-8)).isActive = true
        CountTF.heightAnchor.constraint(equalTo: View.heightAnchor).isActive = true
        return View
    }()
    
    lazy var MinusButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("-", for: .normal)
        Button.contentEdgeInsets.bottom = ControlY(2)
        Button.backgroundColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(28), weight: .medium)
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionMinus), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionMinus() {
    delegate?.CountMinus(Cell: self)
    }
    
    lazy var CountTF : FloatingTF = {
        let tf = FloatingTF()
        tf.textAlignment = .center
        tf.clearButtonMode = .never
        tf.keyboardType = .numberPad
        tf.font = UIFont(name: "Raleway-Regular", size: ControlWidth(19))
        tf.addTarget(self, action: #selector(TextDef), for: .editingDidEnd)
        return tf
    }()
    
    @objc func TextDef() {        
    delegate?.CountTFDidEnd(Cell: self)
    }
    
    
    lazy var PlusButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("+", for: .normal)
        Button.contentEdgeInsets.bottom = ControlY(2)
        Button.backgroundColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(24), weight: .medium)
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionPlus), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionPlus() {
    delegate?.CountPlus(Cell: self)
    }
    
    lazy var heart : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        image.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        image.layer.shadowOpacity = 0.6
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 6
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageSelect)))
        return image
    }()
    
    @objc func ImageSelect() {
    HeartAnimate()
    delegate?.ActionHeart(Cell: self)
    }
    
    func HeartAnimate() {
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.transform = self.heart.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.transform = .identity
    })
    })
    }
    
    lazy var SelectImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "AddSelect")
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    layer.shadowColor = #colorLiteral(red: 0.8491383195, green: 0.8492813706, blue: 0.8491194844, alpha: 1)
    layer.shadowOpacity = 0.3
    layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
    layer.shadowRadius = 3
    backgroundColor = .white
    layer.borderWidth = 1
    layer.borderColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.5).cgColor
        
    addSubview(heart)
    heart.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
    heart.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-5)).isActive = true
    heart.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    heart.heightAnchor.constraint(equalTo: heart.widthAnchor).isActive = true
        
    addSubview(ImageView)
    ImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ControlX(30)).isActive = true
    ImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-30)).isActive = true
    ImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(20)).isActive = true
    ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(95)).isActive = true
        
    let StackVertical = UIStackView(arrangedSubviews: [LabelTitle,ClassLabel,LabelDetails])
    StackVertical.axis = .vertical
    StackVertical.spacing = ControlWidth(5)
    StackVertical.distribution = .equalSpacing
    StackVertical.alignment = .leading
    StackVertical.backgroundColor = .clear
    StackVertical.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(StackVertical)
    StackVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
    StackVertical.topAnchor.constraint(equalTo: ImageView.bottomAnchor, constant: ControlX(15)).isActive = true
    StackVertical.widthAnchor.constraint(equalTo: self.widthAnchor,constant: ControlWidth(-20)).isActive = true
    StackVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-55)).isActive = true
      
    addSubview(AddInviteToCart)
    AddInviteToCart.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
    AddInviteToCart.topAnchor.constraint(equalTo: StackVertical.bottomAnchor, constant: ControlX(15)).isActive = true
    AddInviteToCart.rightAnchor.constraint(equalTo: self.rightAnchor,constant: ControlX(-10)).isActive = true
    AddInviteToCart.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-15)).isActive = true
        
    addSubview(CountView)
    CountView.leadingAnchor.constraint(equalTo: AddInviteToCart.leadingAnchor).isActive = true
    CountView.topAnchor.constraint(equalTo: AddInviteToCart.topAnchor).isActive = true
    CountView.rightAnchor.constraint(equalTo: AddInviteToCart.rightAnchor).isActive = true
    CountView.bottomAnchor.constraint(equalTo: AddInviteToCart.bottomAnchor).isActive = true
        
    addSubview(SelectImage)
    SelectImage.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(7)).isActive = true
    SelectImage.leftAnchor.constraint(equalTo: self.leftAnchor , constant: ControlX(7)).isActive = true
    SelectImage.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
    SelectImage.heightAnchor.constraint(equalTo: SelectImage.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
