//
//  EventPlanningStep1.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 20/12/2021.
//

import UIKit
import SDWebImage

class EventPlanningStep1: ViewController, RangeSeekSliderDelegate ,UITextFieldDelegate {

   static var Category = [EventCategory]()
   static var Sub = [EventCategorySub]()
    
   static var EventClassic = [EventClassicMusic]()
   static var EventModern = [EventModernMusic]()
   static var EventColors = [EventCategoryColors]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        SetUp()
        
        LodEventCategory()
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(20), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = CGRect(x: 0, y: view.frame.height - ControlWidth(222.5), width: ControlWidth(375), height: ControlWidth(222.5))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
    }

  func SetUp(_ height:CGFloat = 700) {
      
    // MARK: - Start View1
    ViewScroll.addSubview(StackView)
    StackView.frame = CGRect(x: ControlX(20), y: 0, width: view.frame.width - ControlWidth(40), height: ControlWidth(height))
    
    ViewScroll.contentSize = CGSize(width: view.frame.width, height: height + ControlHeight(90))
    ViewNoData.RefreshButton.addTarget(self, action: #selector(self.LodEventCategory), for: .touchUpInside)
   }

    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.alpha = 0
        Scroll.bounces = false
        Scroll.backgroundColor = .white
        return Scroll
    }()
    
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

    // MARK: - Start View
    lazy var StackView : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [TitleLabel,ViewStep,EventCategoryTF,EventTypeTF,DateTF,AttendeesLabel,EstimatedBudget,EstimatedLabel,StackEstimatedFromAndTo,NextButton])
    Stack.axis = .vertical
    Stack.spacing = 30
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()

    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Event Details"
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
            
    lazy var ViewStep : StepView = {
        let View = StepView()
        View.Label1.text = "Event\ndetails"
        View.Label2.text = "Event\npreferences"
        View.Label3.text = "Event\nElements"
        View.Label4.text = "Start\nPlanning"
        View.ViewNumber = 0
        View.ViewNumberFour()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        return View
    }()

    static var CategoryId :String?
    lazy var EventCategoryTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.FieldHeight = ControlWidth(60)
        tf.IconImage = UIImage(named: "EventCategory")
        tf.SetUpIcon(LeftOrRight: false, Width: ControlWidth(25), Height: ControlWidth(30))
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionEventCategory)))
        tf.Icon.addTarget(self, action: #selector(ActionEventCategory), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Event category", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    static var IsEventCategory = true
    @objc func ActionEventCategory() {
    DateTF.text = ""
    EventCategoryTF.resignFirstResponder()
    EventPlanningStep1.IsEventCategory = true
    SetUpPopUp(CGFloat(EventPlanningStep1.Category.count) * ControlWidth(68))
    TableView.reloadData()
    }

    func SetUpPopUp(_ Height:CGFloat) {
        let PopUp = PopUpDownView()
        PopUp.currentState = .open
        PopUp.modalPresentationStyle = .overFullScreen
        PopUp.modalTransitionStyle = .coverVertical
        PopUp.endCardHeight = ControlWidth(Height)
        PopUp.radius = 25

        PopUp.View.addSubview(TableView)
        PopUp.View.addSubview(PopUpTopView)

        PopUpTopView.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlY(10)).isActive = true
        PopUpTopView.centerXAnchor.constraint(equalTo: PopUp.View.centerXAnchor).isActive = true
        PopUpTopView.widthAnchor.constraint(equalToConstant: ControlWidth(150)).isActive = true
        PopUpTopView.heightAnchor.constraint(equalToConstant: ControlWidth(5)).isActive = true

        TableView.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlY(20)).isActive = true
        TableView.leftAnchor.constraint(equalTo: PopUp.View.leftAnchor).isActive = true
        TableView.rightAnchor.constraint(equalTo: PopUp.View.rightAnchor).isActive = true
        TableView.heightAnchor.constraint(equalToConstant: ControlWidth(330)).isActive = true
        present(PopUp, animated: true)
    }


    lazy var PopUpTopView : UIView = {
        let View = UIView()
        View.layer.cornerRadius = ControlHeight(2)
        View.backgroundColor = UIColor(red: 99 / 255.0, green: 87 / 255.0, blue: 82 / 255.0, alpha: 1.0)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    private let EventID = "CellEvent"
    static var indexSelectSub = IndexPath()
    static var indexSelectCategory = IndexPath()
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = UIEdgeInsets(top: 0, left: ControlX(20), bottom: 0, right: ControlX(20))
        tv.register(EventCategoryCell.self, forCellReuseIdentifier: EventID)
        return tv
    }()

    lazy var EventTypeTF : FloatingTF = {
        let tf = FloatingTF()
        tf.isHidden = true
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.FieldHeight = ControlWidth(60)
        tf.IconImage = UIImage(named: "down")
        tf.SetUpIcon(LeftOrRight: false, Width: ControlWidth(25), Height: ControlWidth(28))
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionEventType)))
        tf.Icon.addTarget(self, action: #selector(ActionEventType), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Event Type", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    @objc func ActionEventType() {
    DateTF.text = ""
    EventTypeTF.resignFirstResponder()
    EventPlanningStep1.IsEventCategory = false
    SetUpPopUp(CGFloat(EventPlanningStep1.Sub.count) * ControlWidth(68))
    TableView.reloadData()
    }


    static var date : String?
    lazy var DateTF : FloatingTF = {
        let tf = FloatingTF()
        tf.FieldHeight = ControlWidth(60)
        tf.IconImage = UIImage(named: "calendar_(2)")
        tf.SetUpIcon(LeftOrRight: false, Width: ControlWidth(25), Height: ControlWidth(30))
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionDate)))
        tf.Icon.addTarget(self, action: #selector(ActionDate), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Date", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    let pickerView = UIDatePicker()
    @objc func ActionDate() {
        
    if !EventCategoryTF.NoError() {
    ActionEventCategory()
    return
    }else if EventTypeTF.isHidden == false && !EventTypeTF.NoError() {
    ActionEventType()
    return
    }
        
    let PopUp = PopUpDownView()
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(260)
    PopUp.radius = 25

    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.text = "Date Picker"
    Label.textAlignment = .center
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(22))
    Label.translatesAutoresizingMaskIntoConstraints = false
    PopUp.View.addSubview(Label)
    Label.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlY(10)).isActive = true
    Label.leftAnchor.constraint(equalTo: PopUp.View.leftAnchor,constant: ControlX(20)).isActive = true
    Label.rightAnchor.constraint(equalTo: PopUp.View.rightAnchor,constant: ControlX(-20)).isActive = true
    Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
    PopUp.View.addSubview(pickerView)
    pickerView.backgroundColor = .white
    if #available(iOS 13.4, *) {pickerView.preferredDatePickerStyle = .wheels} else {}
    pickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlY(50)).isActive = true
    pickerView.leftAnchor.constraint(equalTo: PopUp.View.leftAnchor,constant: ControlX(20)).isActive = true
    pickerView.rightAnchor.constraint(equalTo: PopUp.View.rightAnchor,constant: ControlX(-20)).isActive = true
    pickerView.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true

    present(PopUp, animated: true)
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh : mm a , dd/MM/yyyy"
    let selectedDate: String = dateFormatter.string(from: sender.date)
    DateTF.text = selectedDate
        
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: sender.date)
        
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    EventPlanningStep1.date =  dateFormatter2.string(from: calendar.date(from:components) ?? sender.date)
    }

    lazy var AttendeesLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Attendees number"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99 / 255.0, green: 87 / 255.0, blue: 82 / 255.0, alpha: 1.0)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()

    lazy var EstimatedBudget : RangeSeekSlider = {
    let View = RangeSeekSlider()
        View.delegate = self

        View.selectedMinValue = View.minValue
        View.selectedMaxValue = View.maxValue
        View.lineHeight = ControlHeight(3)
        View.handleColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        View.handleDiameter = ControlHeight(25.0)
        View.selectedHandleDiameterMultiplier = 1.3
        View.numberFormatter.numberStyle = .none
        View.numberFormatter.locale = Locale(identifier: "en_US")
        View.numberFormatter.maximumFractionDigits = 0
        View.minLabelColor = UIColor(red: 99 / 255.0, green: 87 / 255.0, blue: 82 / 255.0, alpha: 1.0)
        View.maxLabelColor = UIColor(red: 99 / 255.0, green: 87 / 255.0, blue: 82 / 255.0, alpha: 1.0)
        View.tintColor = UIColor(red: 99 / 255.0, green: 87 / 255.0, blue: 82 / 255.0, alpha: 1.0)
        View.colorBetweenHandles = UIColor(red: 232 / 255.0, green: 199 / 255.0, blue: 199 / 255.0, alpha: 1.0)
        View.minLabelFont = UIFont(name: "Raleway-Regular" ,size: ControlWidth(9)) ?? UIFont.italicSystemFont(ofSize: ControlWidth(9))
        View.maxLabelFont = UIFont(name: "Raleway-Regular" ,size: ControlWidth(9)) ?? UIFont.italicSystemFont(ofSize: ControlWidth(9))

    //      View.minDistance = 50
    //      View.maxDistance = 1000
        View.numberFormatter.positivePrefix = ""
        View.numberFormatter.positiveSuffix = "EGP"
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    return View
    }()

    static var AttendeesTo : String?
    static var AttendeesFrom : String?
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
    EventPlanningStep1.AttendeesFrom = "\(Int(minValue))"
    EventPlanningStep1.AttendeesTo = "\(Int(maxValue))"
    }

    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
    return "\(Int(minValue))"
    }

    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue: CGFloat) -> String? {
    return "\(Int(stringForMaxValue))"
    }


    lazy var EstimatedLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Estimated budget"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(14))
        Label.textColor = UIColor(red: 99 / 255.0, green: 87 / 255.0, blue: 82 / 255.0, alpha: 1.0)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()

    lazy var StackEstimatedFromAndTo : UIStackView = {
       let Stack = UIStackView(arrangedSubviews: [EstimatedFromTF,EstimatedToTF])
       Stack.axis = .horizontal
       Stack.spacing = 20
       Stack.distribution = .fillEqually
       Stack.alignment = .fill
       Stack.backgroundColor = .clear
       Stack.translatesAutoresizingMaskIntoConstraints = false
       Stack.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
       return Stack
    }()

    static var EstimatedFrom : String?
    lazy var EstimatedFromTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.attributedPlaceholder = NSAttributedString(string: "From", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    static var EstimatedTo : String?
    lazy var EstimatedToTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.attributedPlaceholder = NSAttributedString(string: "To", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    var TextFieldRange = Int()
    var TextFieldRangeTo = Int()
    var TextFieldRangeFrom = Int()
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        
        EventPlanningStep1.EstimatedTo = EstimatedToTF.text
        EventPlanningStep1.EstimatedFrom = EstimatedFromTF.text
        
        if EstimatedToTF == textField {
        TextFieldRange = TextFieldRangeTo
        }else{
        TextFieldRange = TextFieldRangeFrom
        }
        
        guard let text = textField.text as NSString? else { return false }
        let newText = text.replacingCharacters(in: range, with: string)
        if newText.isEmpty {
          return true
        }
        else if let intValue = Int(newText), intValue <= TextFieldRange {
          return true
        }
        return false
      }

    lazy var NextButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Next", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionNext(_:)), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Button
    }()
    

    @objc func ActionNext(_ Button:UIButton) {
    if EventTypeTF.isHidden == false {
    if EventCategoryTF.NoError() && EventTypeTF.NoError() && DateTF.NoError() {
    PresentStep2()
    }
    }else{
    if EventCategoryTF.NoError() && DateTF.NoError()  {
    PresentStep2()
    }
    }
    }
    
    func PresentStep2() {
    Present(ViewController: self, ToViewController: EventPlanningStep2())
    }
    
}

extension EventPlanningStep1 : UITableViewDelegate, UITableViewDataSource ,EventCategoryDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return EventPlanningStep1.IsEventCategory == true ? EventPlanningStep1.Category.count : EventPlanningStep1.Sub.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: EventID, for: indexPath) as! EventCategoryCell
        tableView.rowHeight = ControlWidth(60)
        Cell.backgroundColor = .white
        Cell.selectionStyle = .none
        Cell.Delegate = self


        if EventPlanningStep1.IsEventCategory {
        Cell.ItemsLabel.text = EventPlanningStep1.Category[indexPath.row].Name
        Cell.ItemsImage.sd_setImage(with: URL(string: EventPlanningStep1.Category[indexPath.row].Icon ?? ""))
        Cell.SelectImage.alpha = EventPlanningStep1.indexSelectCategory == indexPath ? 1 : 0
        }else{
        Cell.ItemsLabel.text = EventPlanningStep1.Sub[indexPath.row].Name
        Cell.ItemsImage.sd_setImage(with: URL(string: EventPlanningStep1.Sub[indexPath.row].Icon ?? ""))
        Cell.SelectImage.alpha = EventPlanningStep1.indexSelectSub == indexPath ? 1 : 0
        }
    
        return Cell
    }
    
    func ActionDackground(Cell: EventCategoryCell) {
    if let Index = TableView.indexPath(for: Cell) {
    if EventPlanningStep1.IsEventCategory {
    EventTypeTF.isHidden = Cell.ItemsLabel.text == "Other" ? false:true
    EventCategoryTF.text = Cell.ItemsLabel.text
    EventPlanningStep1.indexSelectCategory = Index
    Cell.ItemsLabel.text == "Other" ? SetUp(790):SetUp(700)
    
    TextFieldRangeTo = EventPlanningStep1.Category[Index.row].Controls?.BudgetTo ?? 0
    TextFieldRangeFrom = EventPlanningStep1.Category[Index.row].Controls?.BudgetFrom ?? 0
            
    pickerView.SetMinAndMaxDate(EventPlanningStep1.Category[Index.row].Controls?.MinDays ?? 0)
        
    EstimatedFromTF.text = "\(EventPlanningStep1.Category[Index.row].Controls?.BudgetFrom ?? 0)"
    EstimatedToTF.text = "\(EventPlanningStep1.Category[Index.row].Controls?.BudgetTo ?? 0)"
        
    EventPlanningStep1.EstimatedTo = "\(EventPlanningStep1.Category[Index.row].Controls?.BudgetTo ?? 0)"
    EventPlanningStep1.EstimatedFrom = "\(EventPlanningStep1.Category[Index.row].Controls?.BudgetFrom ?? 0)"
        
    EstimatedBudget.minValue = CGFloat(EventPlanningStep1.Category[Index.row].Controls?.AttendeesFrome ?? 0)
    EstimatedBudget.maxValue = CGFloat(EventPlanningStep1.Category[Index.row].Controls?.AttendeesTo ?? 100)
            
    EstimatedBudget.selectedMinValue = CGFloat(EventPlanningStep1.Category[Index.row].Controls?.AttendeesFrome ?? 0)
    EstimatedBudget.selectedMaxValue = CGFloat(EventPlanningStep1.Category[Index.row].Controls?.AttendeesTo ?? 100)
      
    EventPlanningStep1.AttendeesFrom = "\(Int(EventPlanningStep1.Category[Index.row].Controls?.AttendeesFrome ?? 0))"
    EventPlanningStep1.AttendeesTo = "\(Int(EventPlanningStep1.Category[Index.row].Controls?.AttendeesTo ?? 100))"
        
    EventPlanningStep1.CategoryId = EventPlanningStep1.Category[EventPlanningStep1.indexSelectCategory.row].Controls?.CategoryId ?? ""
    }else{
        
    EventPlanningStep1.indexSelectSub = Index
    EventTypeTF.text = Cell.ItemsLabel.text
    
    TextFieldRangeTo = EventPlanningStep1.Sub[Index.row].Controls?.BudgetTo ?? 0
    TextFieldRangeFrom = EventPlanningStep1.Sub[Index.row].Controls?.BudgetFrom ?? 0
            
    pickerView.SetMinAndMaxDate(EventPlanningStep1.Sub[Index.row].Controls?.MinDays ?? 0)
        
    EstimatedFromTF.text = "\(EventPlanningStep1.Sub[Index.row].Controls?.BudgetFrom ?? 0)"
    EstimatedToTF.text = "\(EventPlanningStep1.Sub[Index.row].Controls?.BudgetTo ?? 0)"
        
    EventPlanningStep1.EstimatedTo = "\(EventPlanningStep1.Sub[Index.row].Controls?.BudgetTo ?? 0)"
    EventPlanningStep1.EstimatedFrom = "\(EventPlanningStep1.Sub[Index.row].Controls?.BudgetFrom ?? 0)"
        
    EstimatedBudget.minValue = CGFloat(EventPlanningStep1.Sub[Index.row].Controls?.AttendeesFrome ?? 0)
    EstimatedBudget.maxValue = CGFloat(EventPlanningStep1.Sub[Index.row].Controls?.AttendeesTo ?? 100)
        
    EstimatedBudget.selectedMinValue = CGFloat(EventPlanningStep1.Sub[Index.row].Controls?.AttendeesFrome ?? 0)
    EstimatedBudget.selectedMaxValue = CGFloat(EventPlanningStep1.Sub[Index.row].Controls?.AttendeesTo ?? 100)

    EventPlanningStep1.AttendeesFrom = "\(Int(EventPlanningStep1.Sub[Index.row].Controls?.AttendeesFrome ?? 0))"
    EventPlanningStep1.AttendeesTo = "\(Int(EventPlanningStep1.Sub[Index.row].Controls?.AttendeesTo ?? 100))"
        
    EventPlanningStep1.CategoryId = EventPlanningStep1.Sub[EventPlanningStep1.indexSelectSub.row].Controls?.CategoryId ?? ""
    }
     

    TableView.reloadData()
    }
    }
    
}

extension EventPlanningStep1 {
//    lod Api
    @objc func LodEventCategory() {
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let ApiEventCategory = "\(url + GetEventCategory)"
        
        
    let ParametersCategory:[String : Any] = [:]
    self.ProgressHud.beginRefreshing()
        
//    PostAPI(api: ApiEventCategory, token: nil, parameters: ParametersCategory) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        
        let data = [["Id" : "","Name" : "Test 1","Icon" : "https://cdn-icons-png.flaticon.com/128/4807/4807774.png","Couple" : "Couple","HasSub" : true,
                     "Controls":["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                         ,"BudgetFrom" : 200
                                         ,"BudgetTo" : 1000
                                         ,"AttendeesFrome" : 1000
                                         ,"AttendeesTo" : 20000
                                         ,"MinDays" : 5],
                    
                     "Sub" : [["Id" : "","Name" : "", "StringIcon" : "String","Controls" :
                                ["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                ,"BudgetFrom" : 200
                                ,"BudgetTo" : 10000
                                ,"AttendeesFrome" : 1000
                                ,"AttendeesTo" : 20000
                                ,"MinDays" : 5]]]
                    ],
                    
                    ["Id" : "","Name" : "Test 2","Icon" : "https://cdn-icons-png.flaticon.com/128/4876/4876362.png","Couple" : "Couple","HasSub" : true,
                                 "Controls":["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                                     ,"BudgetFrom" : 200
                                                     ,"BudgetTo" : 1000
                                                     ,"AttendeesFrome" : 1000
                                                     ,"AttendeesTo" : 20000
                                                     ,"MinDays" : 5],
                                
                    "Sub" : [["Id" : "","Name" : "", "StringIcon" : "String","Controls" :
                                            ["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                            ,"BudgetFrom" : 200
                                            ,"BudgetTo" : 10000
                                            ,"AttendeesFrome" : 1000
                                            ,"AttendeesTo" : 20000
                                            ,"MinDays" : 5]]]
                                ],
                    
                    
                    ["Id" : "","Name" : "Test 3","Icon" : "https://cdn-icons-png.flaticon.com/128/2403/2403066.png","Couple" : "Couple","HasSub" : true,
                                 "Controls":["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                                     ,"BudgetFrom" : 200
                                                     ,"BudgetTo" : 1000
                                                     ,"AttendeesFrome" : 1000
                                                     ,"AttendeesTo" : 20000
                                                     ,"MinDays" : 5],
                                
                    "Sub" : [["Id" : "","Name" : "", "StringIcon" : "String","Controls" :
                                            ["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                            ,"BudgetFrom" : 200
                                            ,"BudgetTo" : 10000
                                            ,"AttendeesFrome" : 1000
                                            ,"AttendeesTo" : 20000
                                            ,"MinDays" : 5]]]
                                ],
                    
                    
                    ["Id" : "","Name" : "Test 4","Icon" : "https://cdn-icons-png.flaticon.com/128/4299/4299944.png","Couple" : "Couple","HasSub" : true,
                                 "Controls":["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                                     ,"BudgetFrom" : 200
                                                     ,"BudgetTo" : 1000
                                                     ,"AttendeesFrome" : 1000
                                                     ,"AttendeesTo" : 20000
                                                     ,"MinDays" : 5],
                                
                    "Sub" : [["Id" : "","Name" : "", "StringIcon" : "String","Controls" :
                                            ["CategoryId" : "","TitleValue" : "TitleValue","GroomName" : true,"Gender" : true,"Age" : true,"DelegateName" : true,"DelegatePhone" : true
                                            ,"BudgetFrom" : 200
                                            ,"BudgetTo" : 10000
                                            ,"AttendeesFrome" : 1000
                                            ,"AttendeesTo" : 20000
                                            ,"MinDays" : 5]]]
                    ]
        ]
         
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.ViewNoData.isHidden = true
            self.ViewScroll.alpha = 1
            
            for item in data {
                EventPlanningStep1.Category.append(EventCategory(dictionary: item))
                
                if let SubDictionary = item["Sub"] as? [[String:Any]]  {
                    for item in SubDictionary {
                        EventPlanningStep1.Sub.append(EventCategorySub(dictionary: item))
                    }
                }
            }
            
            
            //    let ApiPreferencesDetails = "\(url + GetEventPreferencesDetails)"
            //    let ParametersDetails:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
            //                                            "Platform": "I"]
            //
            //    PostAPI(api: ApiPreferencesDetails, token: token, parameters: ParametersDetails) { _ in
            //    } DictionaryData: { data in
            
            let data = [
                "Colors":[
                    ["Id" : 0,"IconPath" : "https://www.color-hex.com/palettes/8645.png"],
                    ["Id" : 0,"IconPath" : "https://www.color-hex.com/palettes/14604.png"],
                    ["Id" : 0,"IconPath" : "https://www.color-hex.com/palettes/95636.png"],
                    ["Id" : 0,"IconPath" : "https://www.color-hex.com/palettes/92071.png"],
                    ["Id" : 0,"IconPath" : "https://www.color-hex.com/palettes/74869.png"],
                    ["Id" : 0,"IconPath" : "https://www.color-hex.com/palettes/3538.png"],
                    ["Id" : 0,"IconPath" : "https://www.color-hex.com/palettes/29431.png"]],
                
                "ModernMusic":[
                    ["Id" : 0, "Name" : "Modern 1","IconPath" : "https://cdn-icons-png.flaticon.com/128/13303/13303264.png"],
                    ["Id" : 0, "Name" : "Modern 2","IconPath" : "https://cdn-icons-png.flaticon.com/128/12919/12919808.png"],
                    ["Id" : 0, "Name" : "Modern 3","IconPath" : "https://cdn-icons-png.flaticon.com/128/6050/6050471.png"],
                    ["Id" : 0, "Name" : "Modern 4","IconPath" : "https://cdn-icons-png.flaticon.com/128/5944/5944154.png"],
                    ["Id" : 0, "Name" : "Modern 5","IconPath" : "https://cdn-icons-png.flaticon.com/128/4386/4386173.png"],
                    ["Id" : 0, "Name" : "Modern 6","IconPath" : "https://cdn-icons-png.flaticon.com/128/6050/6050600.png"],
                    ["Id" : 0, "Name" : "Modern 7","IconPath" : "https://cdn-icons-png.flaticon.com/128/11384/11384346.png"]],
                
                "ClassicMusic":[
                    ["Id" : 0, "Name" : "Classic 1","IconPath" : "https://cdn-icons-png.flaticon.com/128/836/836847.png"],
                    ["Id" : 0, "Name" : "Classic 2","IconPath" : "https://cdn-icons-png.flaticon.com/128/1776/1776612.png"],
                    ["Id" : 0, "Name" : "Classic 3","IconPath" : "https://cdn-icons-png.flaticon.com/128/2702/2702531.png"],
                    ["Id" : 0, "Name" : "Classic 4","IconPath" : "https://cdn-icons-png.flaticon.com/128/1639/1639407.png"],
                    ["Id" : 0, "Name" : "Classic 5","IconPath" : "https://cdn-icons-png.flaticon.com/128/1082/1082750.png"],
                    ["Id" : 0, "Name" : "Classic 6","IconPath" : "https://cdn-icons-png.flaticon.com/128/6088/6088655.png"],
                    ["Id" : 0, "Name" : "Classic 7","IconPath" : "https://cdn-icons-png.flaticon.com/128/7590/7590242.png"]]
            ]
            
            
            if let Colors = data["Colors"]  {
                for item in Colors {
                    EventPlanningStep1.EventColors.append(EventCategoryColors(dictionary: item))
                }
            }
            
            if let ModernMusic = data["ModernMusic"]  {
                for item in ModernMusic {
                    EventPlanningStep1.EventModern.append(EventModernMusic(dictionary: item))
                }
            }
            
            if let ClassicMusic = data["ClassicMusic"]  {
                for item in ClassicMusic {
                    EventPlanningStep1.EventClassic.append(EventClassicMusic(dictionary: item))
                }
            }
            
            self.ProgressHud.endRefreshing() {}
            self.TableView.reloadData()
            
            //    } ArrayOfDictionary: { _ in
            //    } Err: { error in
            //    self.IfError(error)
            //    }
            
            //    } Err: { error in
            //    self.IfError(error)
            //    if error != "" {
            //    return
            //    }
            //    }
        }

        
    }
    

    func IfError(_ error:String) {

        if EventPlanningStep1.Category.count == 0 {
        self.ViewNoData.isHidden = false
        self.ViewScroll.alpha = 0
        self.ProgressHud.endRefreshing() {}
        }
            
        if error != "" {
        self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.LodEventCategory)}
        }
    }
}
