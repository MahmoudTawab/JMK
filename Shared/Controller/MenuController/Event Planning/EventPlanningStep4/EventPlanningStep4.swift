//
//  EventPlanningStep4.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 20/12/2021.
//

import UIKit

class EventPlanningStep4: ViewController , UITextFieldDelegate {
    
    var EstimatedFrom : String?
    var EstimatedTo : String?
    
    var Nighte : Bool?
    var Classic : Bool?

    var ColorsPaaltId : Int?
    var FavoriteMusicId : Int?
    
    var FirstName : String?
    var SecondName : String?

    var Elements : String?
    var Note : String?

    var Pinterest : String?
    var Gender : Bool?

    var Age : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(20), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = CGRect(x: 0, y: view.frame.height - ControlWidth(222.5), width: ControlWidth(375), height: ControlWidth(222.5))
        
        // MARK: - Start View1
        view.addSubview(StackView)
        StackView.frame = CGRect(x: ControlX(20), y: ControlX(65), width: ControlWidth(335), height: view.frame.height - ControlWidth(120))
        
    }
    
    
    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Male")
        return ImageView
    }()
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Event Planning"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var StackView : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [TitleLabel,ViewStep,IconImage,LabelTitle,LabelDetails,PlanEvent])
    Stack.axis = .vertical
    Stack.spacing = 20
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
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
        View.ViewNumber = 3
        View.ViewNumberFour()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        return View
    }()
    
    lazy var IconImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "plan")
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(250)).isActive = true
        return ImageView
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.text = "Plan Event"
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(18))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    

    let Details = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam."
    lazy var LabelDetails : UITextView = {
        let TV = UITextView()
        TV.text = Details
        TV.textAlignment = .center
        TV.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        TV.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        TV.isSelectable = false
        TV.isEditable = false
        TV.spasing = ControlHeight(4)
        TV.backgroundColor = .clear
        TV.keyboardAppearance = .light
        TV.translatesAutoresizingMaskIntoConstraints = false
        TV.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        return TV
    }()
    

    lazy var PlanEvent : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Plan Event", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionPlanEvent), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Button
    }()


    @objc func ActionPlanEvent() {
//        guard let token = defaults.string(forKey: "JWT") else{return}
//        guard let url = defaults.string(forKey: "API") else{return}
//        
//        guard let SqlId = LaunchScreen.User?.SqlId else{return}
//
//        let ApiAddEvent = "\(url + PhoneAddEvent)"
//            
//        guard let CategoryId = EventPlanningStep1.CategoryId else { return }
//        guard let date = EventPlanningStep1.date else { return }
//        
//        guard let AttendeesFrom = EventPlanningStep1.AttendeesFrom else { return }
//        guard let AttendeesTo = EventPlanningStep1.AttendeesTo else { return }
//        
//        guard let EstimatedFrom = EventPlanningStep1.EstimatedFrom else { return }
//        guard let EstimatedTo = EventPlanningStep1.EstimatedTo else { return }
//        
//        guard let Night = EventPlanningStep2.IsNight else { return }
//        guard let Classic = EventPlanningStep2.IsClassic else { return }
//        
//        guard let Music = EventPlanningStep2.MusicId else { return }
//        guard let Colors = EventPlanningStep2.ColorsId else { return }
//        
//
//        let Age = EventPlanningStep3Cell.Age ?? 0
//        let Gender = EventPlanningStep3Cell.Gender ?? false
//        let FirstName = EventPlanningStep3Cell.FirstName ?? ""
//        let LastName = EventPlanningStep3Cell.LastName ?? ""
//        let PinterestLink = EventPlanningStep3Cell.PinterestLink ?? ""
//        guard let EventNotes = EventPlanningStep3Cell.EventNotes else { return }
//        guard let Elements = EventPlanningStep3Cell.MustHaveElements else { return }
//            
//        let ParametersCategory:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                                 "SqlId": SqlId,
//                                                 "Platform": "I",
//                                                 
//                                                 "CategoryId":CategoryId,
//                                                 "Date":date,
//                                
//                                                 "AttendeesFrom":AttendeesFrom,
//                                                 "AttendeesTo":AttendeesTo,
//                                                 
//                                                 "EstimatedFrom": EstimatedFrom,
//                                                 "EstimatedTo": EstimatedTo,
//                                                 
//                                                 "Nighte":Night,
//                                                 "Classic":Classic,
//                                                 
//                                                 "ColorsPaaltId":Colors,
//                                                 "FavoriteMusicId":Music,
//                                                 
//                                                 "FirstName": FirstName,
//                                                 "SecondName":LastName,
//                                                 "Elements": Elements,
//                                                 "Note": EventNotes,
//                                                 "Pinterest": PinterestLink,
//                                                 "Gender": Gender ,
//                                                 "Age": Age]
        
        self.ProgressHud.beginRefreshing()
//        PostAPI(api: ApiAddEvent, token: token, parameters: ParametersCategory) { String in
//        } DictionaryData: { data in
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.ProgressHud.endRefreshing() {
            self.Present(ViewController: self, ToViewController: EventType())
            }
        }

//        } ArrayOfDictionary: { _ in
//        } Err: { error in
//        if error != "" {
//        self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionPlanEvent)}
//        }
//        }
    }
    
}
