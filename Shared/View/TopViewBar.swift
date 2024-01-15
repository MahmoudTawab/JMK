//
//  TopViewBar.swift
//  JMK (iOS)
//
//  Created by Emojiios on 12/01/2022.
//

import UIKit

class TopViewBar: UIView {
    
    @IBInspectable var BudgetNum:Int = 0 {
    didSet {
        Budget.text = "\(BudgetNum)"
    }
    }

    @IBInspectable var TotalNum:Int = 0 {
    didSet {
        Total.text = "\(TotalNum)"
    }
    }

    lazy var LabelTotal : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var Total : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.8997861743, green: 0.3585899174, blue: 0.3549687862, alpha: 1)
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var LabelBudget : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var Budget : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    
    lazy var StackTotal : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelTotal,Total])
        Stack.axis = .horizontal
        Stack.spacing = 0
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var StackBudget : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelBudget,Budget])
        Stack.axis = .horizontal
        Stack.spacing = 0
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    override func draw(_ rect: CGRect) {
    let Stack = UIStackView(arrangedSubviews: [StackTotal,StackBudget])
    Stack.axis = .horizontal
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.frame = CGRect(x: ControlX(15), y: 0, width: rect.width - ControlWidth(30), height: rect.height)
    addSubview(Stack)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
        backgroundColor = #colorLiteral(red: 0.9316878319, green: 0.9145766497, blue: 0.9075786471, alpha: 1)
    }
    
    func Show() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
    self.frame = CGRect(x: 0, y: self.frame.minY, width: UIScreen.main.bounds.width, height: 0)
    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.72, initialSpringVelocity: 0.75, options: [], animations: {
    self.alpha = 1
    self.backgroundColor = #colorLiteral(red: 0.9316878319, green: 0.9145766497, blue: 0.9075786471, alpha: 1)
    self.frame = CGRect(x: 0, y: self.frame.minY, width: UIScreen.main.bounds.width, height: ControlWidth(50))
    })
    }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
