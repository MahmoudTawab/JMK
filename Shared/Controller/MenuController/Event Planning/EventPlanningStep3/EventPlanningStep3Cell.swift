//
//  EventPlanningStep3Cell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 21/12/2021.
//

import UIKit

protocol Step3CellDelegate {
    func ActionNext()
}

class EventPlanningStep3Cell: UITableViewCell {

    var Delegate : Step3CellDelegate?

    lazy var StackView1 : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [TitleLabel,ViewStep,GenderLabel,ViewMaleAndFemale,FirstNameTF,LastNameTF,AgeTF,MustHaveElementsTF,EventNotesTF])
    Stack.axis = .vertical
    Stack.spacing = 25
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    lazy var StackView2 : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [PinterestLinkTF,NextButton])
    Stack.axis = .vertical
    Stack.spacing = 25
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    lazy var StackView : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [StackView1,StackView2])
    Stack.axis = .vertical
    Stack.spacing = 25
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    

    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Personal Questions"
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
            
    lazy var ViewStep : StepView = {
        let View = StepView()
        View.Label1.text = "Event\ndetails"
        View.Label2.text = "Event\npreferences"
        View.Label3.text = "Event\nElements"
        View.Label4.text = "Start\nPlanning"
        View.ViewNumber = 2
        View.ViewNumberFour()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        return View
    }()

    static var FirstName : String? 
    lazy var FirstNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.isHidden = true
        tf.TitleHidden = false
        tf.FieldHeight = ControlHeight(50)
        tf.addTarget(self, action: #selector(FirstNameText), for: .editingChanged)
        return tf
    }()
    
    @objc func FirstNameText() {
    EventPlanningStep3Cell.FirstName = FirstNameTF.text
    }

    static var LastName : String?
    lazy var LastNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.FieldHeight = ControlWidth(50)
        tf.attributedPlaceholder = NSAttributedString(string: "Groom name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(LastNameText), for: .editingChanged)
        return tf
    }()
    
    @objc func LastNameText() {
    EventPlanningStep3Cell.LastName = LastNameTF.text
    }
    
    static var Age : Int?
    lazy var AgeTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.FieldHeight = ControlWidth(50)
        tf.attributedPlaceholder = NSAttributedString(string: "Age", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(AgeText), for: .editingChanged)
        return tf
    }()
    
    @objc func AgeText() {
    if let text = AgeTF.text {
    EventPlanningStep3Cell.Age = (text as NSString).integerValue
    }
    }
    
    static var MustHaveElements : String?
    lazy var MustHaveElementsTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.FieldHeight = ControlWidth(50)
        tf.attributedPlaceholder = NSAttributedString(string: "What is the must have elements in your event?", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(MustHaveElementsText), for: .editingChanged)
        return tf
    }()
    
    @objc func MustHaveElementsText() {
    EventPlanningStep3Cell.MustHaveElements = MustHaveElementsTF.text
    }
    
    static var EventNotes : String?
    lazy var EventNotesTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.FieldHeight = ControlWidth(50)
        tf.attributedPlaceholder = NSAttributedString(string: "Event Notes", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(EventNotesText), for: .editingChanged)
        return tf
    }()
    
    @objc func EventNotesText() {
    EventPlanningStep3Cell.EventNotes = EventNotesTF.text
    }
    
    lazy var GenderLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Gender"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = UIColor(red:  99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        return Label
    }()

    lazy var ViewMaleAndFemale : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        
        View.addSubview(MaleButton)
        MaleButton.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        MaleButton.leftAnchor.constraint(equalTo: View.leftAnchor).isActive = true
        MaleButton.centerYAnchor.constraint(equalTo: View.centerYAnchor).isActive = true
        
        View.addSubview(FemaleButton)
        FemaleButton.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        FemaleButton.leftAnchor.constraint(equalTo: MaleButton.rightAnchor , constant: ControlX(20)).isActive = true
        FemaleButton.centerYAnchor.constraint(equalTo: View.centerYAnchor).isActive = true
        
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return View
    }()
    
    static var Gender : Bool? = nil
    lazy var MaleButton : SPRadioButton = {
        let Button = SPRadioButton()
        Button.text = "Male"
        Button.isOn = true
        Button.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionYes), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(4), left: 0, bottom: 0, right: 0)
        return Button
    }()
    
    @objc func ActionYes() {
    MaleButton.isOn = true
    FemaleButton.isOn = false
    EventPlanningStep3Cell.Gender = true
    }

    lazy var FemaleButton : SPRadioButton = {
        let Button = SPRadioButton()
        Button.text = "Female"
        Button.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.backgroundColor = .clear
        Button.Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionNo), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(4), left: 0, bottom: 0, right: 0)
        return Button
    }()
    
    @objc func ActionNo() {
    FemaleButton.isOn = true
    MaleButton.isOn = false
    EventPlanningStep3Cell.Gender = false
    }
    
    static var PinterestLink : String?
    lazy var PinterestLinkTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.clearButtonMode = .never
        tf.FieldHeight = ControlHeight(50)
        tf.IconImage = UIImage(named: "Group 31790")
        tf.SetUpIcon(LeftOrRight: false, Width: 32, Height: 36)
        tf.Icon.addTarget(self, action: #selector(ActionPinterestLink), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Pinterest link (Optional)", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(PinterestLinkText), for: .editingChanged)
        return tf
    }()
    
    @objc func PinterestLinkText() {
    EventPlanningStep3Cell.PinterestLink = PinterestLinkTF.text
    }
    
    @objc func ActionPinterestLink() {
        guard let url = URL(string: "https://www.pinterest.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }

    
    lazy var NextButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setTitle("Next", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Button
    }()

    @objc func ActionNext() {
        
    if FirstNameTF.isHidden == false && !FirstNameTF.NoError() {
    return
    }
    if LastNameTF.isHidden == false && !LastNameTF.NoError() {
    return
    }
    if AgeTF.isHidden == false && !AgeTF.NoError() {
    return
    }
        
    if MustHaveElementsTF.NoError() && EventNotesTF.NoError() {
    Delegate?.ActionNext()
    }
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.isHidden = true
        
        if EventPlanningStep1.IsEventCategory {

        if let First = EventPlanningStep1.Category[EventPlanningStep1.indexSelectCategory.row].Controls?.TitleValue {
        FirstNameTF.isHidden = false
        FirstNameTF.attributedPlaceholder = NSAttributedString(string: First, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        }

        LastNameTF.isHidden = !(EventPlanningStep1.Category[EventPlanningStep1.indexSelectCategory.row].Controls?.GroomName ?? true)
        GenderLabel.isHidden = !(EventPlanningStep1.Category[EventPlanningStep1.indexSelectCategory.row].Controls?.Gender ?? true)
        ViewMaleAndFemale.isHidden = !(EventPlanningStep1.Category[EventPlanningStep1.indexSelectCategory.row].Controls?.Gender ?? true)
        AgeTF.isHidden = !(EventPlanningStep1.Category[EventPlanningStep1.indexSelectCategory.row].Controls?.Age ?? true)
        }else{

        if let First = EventPlanningStep1.Sub[EventPlanningStep1.indexSelectSub.row].Controls?.TitleValue {
        FirstNameTF.isHidden = false
        FirstNameTF.attributedPlaceholder = NSAttributedString(string: First, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        }

        LastNameTF.isHidden = !(EventPlanningStep1.Sub[EventPlanningStep1.indexSelectSub.row].Controls?.GroomName ?? true)
        GenderLabel.isHidden = !(EventPlanningStep1.Sub[EventPlanningStep1.indexSelectSub.row].Controls?.Gender ?? true)
        ViewMaleAndFemale.isHidden = !(EventPlanningStep1.Sub[EventPlanningStep1.indexSelectSub.row].Controls?.Gender ?? true)
        AgeTF.isHidden = !(EventPlanningStep1.Sub[EventPlanningStep1.indexSelectSub.row].Controls?.Age ?? true)
        }
        
        addSubview(StackView)
        StackView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(20)).isActive = true
        StackView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(20)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlX(-20)).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
