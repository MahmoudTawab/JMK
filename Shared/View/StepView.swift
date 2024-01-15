//
//  StepView.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 10/08/2021.
//

import UIKit

class StepView: UIView {
        
    @IBInspectable
    var ViewNumber:Int = 0 {
        didSet {
            SetUp(ViewNumber: ViewNumber)
        }
    }
    
    func SetUp(ViewNumber:Int) {
        let ColorSelect = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        let Color = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        
        switch ViewNumber {
        case 0:
        Button1.backgroundColor = ColorSelect
        Label1.textColor = ColorSelect
        Button2.backgroundColor = Color
        Label2.textColor = Color
        Button3.backgroundColor = Color
        Label3.textColor = Color
        Button4.backgroundColor = Color
        Label4.textColor = Color
            
        case 1:
        Button1.backgroundColor = Color
        Label1.textColor = Color
            
        Button2.backgroundColor = ColorSelect
        Label2.textColor = ColorSelect
            
        Button3.backgroundColor = Color
        Label3.textColor = Color
        Button4.backgroundColor = Color
        Label4.textColor = Color
         
        case 2:
        Button1.backgroundColor = Color
        Label1.textColor = Color
                
        Button2.backgroundColor = Color
        Label2.textColor = Color
                
        Button3.backgroundColor = ColorSelect
        Label3.textColor = ColorSelect
        Button4.backgroundColor = Color
        Label4.textColor = Color
            
        case 3:
        Button1.backgroundColor = Color
        Label1.textColor = Color
                    
        Button2.backgroundColor = Color
        Label2.textColor = Color
             
        Button3.backgroundColor = Color
        Label3.textColor = Color
            
        Button4.backgroundColor = ColorSelect
        Label4.textColor = ColorSelect
            
        default:
        break
        }
        
        let Image = UIImage(named: "tick")?.withInset(UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.Button1.setBackgroundImage(ViewNumber < 1 ? nil:Image, for: .normal)
        self.Button2.setBackgroundImage(ViewNumber < 2 ? nil:Image, for: .normal)
        self.Button3.setBackgroundImage(ViewNumber < 3 ? nil:Image, for: .normal)
            
        self.Button1.setTitle(ViewNumber < 1 ? "1" : "", for: .normal)
        self.Button2.setTitle(ViewNumber < 2 ? "2" : "", for: .normal)
        self.Button3.setTitle(ViewNumber < 3 ? "3" : "", for: .normal)
        }

    }
    
    
    lazy var Button1 : UIButton = {
        let Button = UIButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()

    lazy var Label1 : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(12))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var Button2 : UIButton = {
        let Button = UIButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()

    lazy var Label2 : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(12))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var Button3 : UIButton = {
        let Button = UIButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()

    lazy var Label3 : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(12))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var Button4 : UIButton = {
        let Button = UIButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()

    lazy var Label4 : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(12))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    func SetUpButton(_ Button:UIButton ,Title:String) {
        Button.isEnabled = false
        Button.setTitle(Title, for: .normal)
        Button.setTitleColor(.white, for: .normal)
        Button.tintColor = .white
        Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: ControlWidth(18))
        Button.layer.cornerRadius = Button.frame.height / 2
    }
    
    lazy var PointView1 : DottedLineView = {
        let Button = DottedLineView()
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    lazy var PointView2 : DottedLineView = {
        let Button = DottedLineView()
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    lazy var PointView3 : DottedLineView = {
        let Button = DottedLineView()
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()

    
    func ViewNumberTwo() {
        
        addSubview(Button1)
        addSubview(Button2)
        addSubview(Label1)
        addSubview(Label2)
        addSubview(PointView1)
        
        Button1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Button1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ControlX(10)).isActive = true
        Button1.heightAnchor.constraint(equalToConstant: ControlHeight(50)).isActive = true
        Button1.widthAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Label1.topAnchor.constraint(equalTo: Button1.bottomAnchor , constant: ControlY(10)).isActive = true
        Label1.centerXAnchor.constraint(equalTo: Button1.centerXAnchor).isActive = true
        Label1.widthAnchor.constraint(equalToConstant: ControlWidth(81)).isActive = true
        Label1.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
    
        Button2.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        Button2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-10)).isActive = true
        Button2.widthAnchor.constraint(equalTo: Button1.widthAnchor).isActive = true
        Button2.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        PointView1.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        PointView1.leftAnchor.constraint(equalTo: Button1.rightAnchor ,constant: ControlX(5)).isActive = true
        PointView1.rightAnchor.constraint(equalTo: Button2.leftAnchor ,constant: ControlX(-5)).isActive = true
        PointView1.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Label2.centerYAnchor.constraint(equalTo: Label1.centerYAnchor).isActive = true
        Label2.centerXAnchor.constraint(equalTo: Button2.centerXAnchor).isActive = true
        Label2.widthAnchor.constraint(equalTo: Label1.widthAnchor).isActive = true
        Label2.heightAnchor.constraint(equalTo: Label1.heightAnchor).isActive = true
    }
    
    func ViewNumberFour() {
        
        addSubview(Button1)
        addSubview(Button2)
        addSubview(Button3)
        addSubview(Button4)
        addSubview(Label1)
        addSubview(Label2)
        addSubview(Label3)
        addSubview(Label4)
        addSubview(PointView1)
        addSubview(PointView2)
        addSubview(PointView3)
        
        Button1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Button1.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        Button1.heightAnchor.constraint(equalToConstant: ControlWidth(44)).isActive = true
        Button1.widthAnchor.constraint(equalToConstant: ControlWidth(44)).isActive = true
        
        Label1.topAnchor.constraint(equalTo: Button1.bottomAnchor , constant: ControlY(5)).isActive = true
        Label1.centerXAnchor.constraint(equalTo: Button1.centerXAnchor).isActive = true
        Label1.widthAnchor.constraint(equalToConstant: ControlWidth(81)).isActive = true
        Label1.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-5)).isActive = true
    
        PointView1.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        PointView1.leftAnchor.constraint(equalTo: Button1.rightAnchor ,constant: ControlX(5)).isActive = true
        PointView1.widthAnchor.constraint(equalTo: Button1.widthAnchor).isActive = true
        PointView1.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Button2.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        Button2.leftAnchor.constraint(equalTo: PointView1.rightAnchor, constant: ControlX(5)).isActive = true
        Button2.widthAnchor.constraint(equalTo: Button1.widthAnchor).isActive = true
        Button2.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Label2.centerYAnchor.constraint(equalTo: Label1.centerYAnchor).isActive = true
        Label2.centerXAnchor.constraint(equalTo: Button2.centerXAnchor).isActive = true
        Label2.widthAnchor.constraint(equalTo: Label1.widthAnchor).isActive = true
        Label2.heightAnchor.constraint(equalTo: Label1.heightAnchor).isActive = true
        
        PointView2.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        PointView2.leftAnchor.constraint(equalTo: Button2.rightAnchor ,constant: ControlX(5)).isActive = true
        PointView2.widthAnchor.constraint(equalTo: Button1.widthAnchor).isActive = true
        PointView2.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Button3.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        Button3.leftAnchor.constraint(equalTo: PointView2.rightAnchor, constant: ControlX(5)).isActive = true
        Button3.widthAnchor.constraint(equalTo: Button1.widthAnchor).isActive = true
        Button3.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Label3.centerYAnchor.constraint(equalTo: Label1.centerYAnchor).isActive = true
        Label3.centerXAnchor.constraint(equalTo: Button3.centerXAnchor).isActive = true
        Label3.widthAnchor.constraint(equalTo: Label1.widthAnchor).isActive = true
        Label3.heightAnchor.constraint(equalTo: Label1.heightAnchor).isActive = true
        
        PointView3.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        PointView3.leftAnchor.constraint(equalTo: Button3.rightAnchor ,constant: ControlX(5)).isActive = true
        PointView3.widthAnchor.constraint(equalTo: Button1.widthAnchor).isActive = true
        PointView3.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Button4.centerYAnchor.constraint(equalTo: Button1.centerYAnchor).isActive = true
        Button4.leftAnchor.constraint(equalTo: PointView3.rightAnchor, constant: ControlX(5)).isActive = true
        Button4.widthAnchor.constraint(equalTo: Button1.widthAnchor).isActive = true
        Button4.heightAnchor.constraint(equalTo: Button1.heightAnchor).isActive = true
        
        Label4.centerYAnchor.constraint(equalTo: Label1.centerYAnchor).isActive = true
        Label4.centerXAnchor.constraint(equalTo: Button4.centerXAnchor).isActive = true
        Label4.widthAnchor.constraint(equalTo: Label1.widthAnchor).isActive = true
        Label4.heightAnchor.constraint(equalTo: Label1.heightAnchor).isActive = true
        
    }
    

    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        
        PointView1.lineWidth = ControlWidth(4.5)
        PointView2.lineWidth = ControlWidth(4.5)
        PointView3.lineWidth = ControlWidth(4.5)
        
        
        SetUpButton(Button1, Title: "1")
        SetUpButton(Button2, Title: "2")
        SetUpButton(Button3, Title: "3")
        SetUpButton(Button4, Title: "4")
    }
}



@IBDesignable
public class DottedLineView: UIView {

    @IBInspectable
    public var lineColor: UIColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    
    @IBInspectable
    public var lineWidth: CGFloat = CGFloat(4.5)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        configureRoundPath(path: path, rect: rect)
        lineColor.setStroke()
        path.stroke()
    }
    
    private func configureRoundPath(path: UIBezierPath, rect: CGRect) {
        let center = rect.height * 0.5
        path.move(to: CGPoint(x: lineWidth + 8, y: center))
        path.addLine(to: CGPoint(x: rect.maxX - 6, y: center))

        let dashes: [CGFloat] = [0, lineWidth * 2]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        path.lineCapStyle = CGLineCap.round
    }
    
}

