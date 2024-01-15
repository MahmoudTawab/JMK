//
//  InviteGuestsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/07/2021.
//

import UIKit
import ContactsUI

struct Contacts {
var Numbers:String
var Names:String
var Image:UIImage
var Id : String?
}

class InviteGuestsVC: ViewController ,CNContactPickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,InviteGuestsDelegate {
    
    var IdSelect = [String]()
    var objects  = [Contacts]()
    var filtered = [Contacts]()
    private let InviteGuestsID = "CellInviteGuests"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
        getContacts()
        CollectionView.AnimateCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,object: nil, queue: OperationQueue.main,using: keyboardWillShowNotification)
        
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,object: nil, queue: OperationQueue.main,
        using: keyboardWillHideNotification)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func getContacts() {
    let store = CNContactStore()
    switch CNContactStore.authorizationStatus(for: .contacts){
    case .authorized:
    self.retrieveContactsWithStore(store: store)
    case .notDetermined:
    store.requestAccess(for: .contacts){succeeded, err in
    guard err == nil && succeeded else{return}
    self.retrieveContactsWithStore(store: store)
    }default:
    print("Not handled")
    }
    }
    
    func retrieveContactsWithStore(store: CNContactStore) {
    let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey,CNContactImageDataKey, CNContactEmailAddressesKey] as [Any]
    let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
    do {
    try store.enumerateContacts(with: request){ (contact, cursor) -> Void in
    for phone in contact.phoneNumbers {
    if phone.value.stringValue != "" && phone.value.stringValue.count > 9 {
        
    let formatter = CNContactFormatter()
    let imageData = contact.imageData ?? Data()
    let Number = phone.value.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
    self.objects.append(Contacts(Numbers: Number, Names: formatter.string(from: contact) ?? "No Name", Image: UIImage(data: imageData) ?? UIImage(named: "User") ?? UIImage(), Id: "\(contact.identifier):\(phone.value.stringValue)"))
        
    self.filtered.append(Contacts(Numbers: Number, Names: formatter.string(from: contact) ?? "No Name", Image: UIImage(data: imageData) ?? UIImage(named: "User") ?? UIImage() , Id: "\(contact.identifier):\(phone.value.stringValue)"))

    }
    }
    }
    } catch let error {
    NSLog("Fetch contact error: \(error)")
    }
    DispatchQueue.main.async {
    self.CollectionView.reloadData()
    }
    }
    
    func keyboardWillShowNotification(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        EdgeInsets(top: 0, bottom: keyboardSize.height + 10)
    }
    
    func keyboardWillHideNotification(notification: Notification) {
    EdgeInsets(top: 0, bottom: 10)
    }
    
    func SetUp() {
        
    BackgroundImage.frame = view.bounds
    view.addSubview(BackgroundImage)
    
    view.addSubview(Dismiss)
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
    
    view.addSubview(NextButton)
    NextButton.frame = CGRect(x: view.frame.maxX - ControlX(60), y: ControlX(25), width: ControlWidth(50), height: ControlWidth(50))
     
    view.addSubview(SearchTextField)
    SearchTextField.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlX(10), width: view.frame.width - ControlWidth(85), height: ControlWidth(40))
        
    SearchTextField.addSubview(SearchIcon)
    SearchIcon.frame = CGRect(x: SearchTextField.frame.maxX - ControlX(46), y: ControlX(7), width: ControlWidth(26), height: ControlWidth(26))
        
    view.addSubview(FilterButton)
    FilterButton.frame = CGRect(x: view.frame.maxX - ControlX(60), y: Dismiss.frame.maxY + ControlX(5), width: ControlWidth(50), height: ControlWidth(50))
        
    view.addSubview(CollectionView)
    CollectionView.frame = CGRect(x: 0, y: SearchTextField.frame.maxY + ControlX(10), width: view.frame.width , height: view.frame.height - ControlWidth(120))
    EdgeInsets(top: 0, bottom: ControlY(10))
    }
    
    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.alpha = 0.4
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "group31203")
        return ImageView
    }()
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Invite Guests \(IdSelect.count)/\(objects.count)"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    lazy var NextButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Next", for: .normal)
        Button.backgroundColor = .clear
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        Button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        Button.setTitleColor(UIColor(red:99 / 255, green:87 / 255, blue:82 / 255, alpha: 1), for: .normal)
        return Button
    }()
    
    
    @objc func ActionNext() {
    let InviteSelected = InviteGuestsSelected()
        
    for item in IdSelect {
    let Select = objects.filter{($0.Id == item)}
     
    Select.forEach { User in
    InviteSelected.NameArray.append(User.Names)
    InviteSelected.PhoneArray.append(User.Numbers)
    InviteSelected.ImageArray.append(User.Image)
    }
    
    if InviteSelected.PhoneArray.count == Select.count {
    Present(ViewController: self, ToViewController: InviteSelected)
    }
    }
    }
    
    lazy var SearchTextField : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6031731846)
        tf.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        tf.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        tf.attributedPlaceholder = NSAttributedString(string: "Search contacts",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)])
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(8) , height: tf.frame.height))
        tf.leftViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(36), height: tf.frame.height))
        tf.rightViewMode = .always
        tf.autocorrectionType = .no
        tf.layer.borderWidth = 0.6
        tf.keyboardAppearance = .light
        tf.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5).cgColor
        tf.font = UIFont(name: "Raleway-Regular", size: ControlWidth(14))
        tf.clearButtonMode = .never
        tf.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        return tf
    }()
    
    lazy var SearchIcon : UIButton = {
        let Button = UIButton(type: .system)
        Button.setImage(UIImage(named: "loupe"), for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionSearchIcon), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSearchIcon() {
    SearchTextField.becomeFirstResponder()
    }
    
    lazy var FilterButton : UIButton = {
        let Button = UIButton(type: .system)
        let image = UIImage(named: "filter")?.withInset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        Button.setBackgroundImage(image, for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionFilter), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionFilter() {
    let PopUp = PopUpDownView()
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(230)
    PopUp.radius = 25
        
    // Add in Items PopUp
    PopUp.View.addSubview(FilterGuests)
    FilterGuests.frame = CGRect(x: ControlX(15), y: ControlX(20), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(30))
        
    PopUp.View.addSubview(AllSelect)
    AllSelect.frame = CGRect(x: ControlX(15), y: FilterGuests.frame.maxY + ControlX(10), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(35))
    AddBottomBorder(AllSelect, "All")
        
    PopUp.View.addSubview(Invited)
    Invited.frame = CGRect(x: ControlX(15), y: AllSelect.frame.maxY + ControlX(20), width: AllSelect.frame.width, height: AllSelect.frame.height)
    AddBottomBorder(Invited, "Invited")
        
    PopUp.View.addSubview(NotInvited)
    NotInvited.frame = CGRect(x: ControlX(15), y: Invited.frame.maxY + ControlX(20), width: AllSelect.frame.width, height: AllSelect.frame.height)
    AddBottomBorder(NotInvited, "Not Invited")
        
    present(PopUp, animated: true)
    }
    
    
    lazy var FilterGuests : UILabel = {
        let Label = UILabel()
        Label.text = "Filter Guests"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(17))
        Label.textColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var AllSelect : UIButton = {
        let Button = UIButton(type: .system)
        Button.addTarget(self, action: #selector(ActionAllSelect), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionAllSelect() {
    AllSelect.setImage(UIImage(named: "group_31491"), for: .normal)
    Invited.setImage(UIImage(named: ""), for: .normal)
    NotInvited.setImage(UIImage(named: ""), for: .normal)
    }
    
    lazy var Invited : UIButton = {
        let Button = UIButton(type: .system)
        Button.addTarget(self, action: #selector(ActionInvited), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionInvited() {
    Invited.setImage(UIImage(named: "group_31491"), for: .normal)
    NotInvited.setImage(UIImage(named: ""), for: .normal)
    AllSelect.setImage(UIImage(named: ""), for: .normal)
    }
    
    lazy var NotInvited : UIButton = {
        let Button = UIButton(type: .system)
        Button.layer.masksToBounds = true
        Button.addTarget(self, action: #selector(ActionNotInvited), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionNotInvited() {
    NotInvited.setImage(UIImage(named: "group_31491"), for: .normal)
    Invited.setImage(UIImage(named: ""), for: .normal)
    AllSelect.setImage(UIImage(named: ""), for: .normal)
    }
    
    func AddBottomBorder(_ Button:UIButton ,_ Title:String) {
    Button.setTitle(Title, for: .normal)
    Button.backgroundColor = .clear
    Button.contentHorizontalAlignment = .left
    Button.semanticContentAttribute = .forceRightToLeft
    Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
    if let width = Button.title(for: .normal)?.textSizeWithFont(Button.titleLabel?.font ?? UIFont.systemFont(ofSize: ControlWidth(15))).width {
    Button.imageEdgeInsets = UIEdgeInsets(top: 0, left: Button.frame.width - width - ControlX(35), bottom: 0, right: 0)
    }
    Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: Button.frame.size.height + ControlY(10), width: Button.frame.size.width, height: ControlWidth(1))
    bottomLine.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.15).cgColor
    Button.layer.addSublayer(bottomLine)
    }
    
    
    lazy var CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.register(InviteGuestsCell.self, forCellWithReuseIdentifier: InviteGuestsID)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InviteGuestsID, for: indexPath) as! InviteGuestsCell
        cell.backgroundColor = .clear
        cell.Delegate = self
            
        let contact = self.filtered[indexPath.row]
        let Phone = String(contact.Numbers.enumerated().map { $0 > 0 && $0 % 4 == 0 ? [" ",$1] : [$1]}.joined())
            
        cell.PhoneLabel.text = Phone
        cell.NameLabel.text = contact.Names
        cell.ProfileImage.image = contact.Image
        cell.IdCell = contact.Id
            

        if let Id = contact.Id {
        if self.IdSelect.contains(Id) {
        cell.SelectButton.setImage(UIImage(named: "InviteSelect"), for: .normal)
        }else{
        cell.SelectButton.setImage(UIImage(named: "AddNoSelect"), for: .normal)
        }

        self.Dismiss.TextDismiss = "Invite Guests \(self.IdSelect.count)/\(self.objects.count)"
        }
            
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: ControlWidth(90))
    }
    
    func ActionSelectImage(Cell:InviteGuestsCell) {
        if let indexPath = CollectionView.indexPath(for: Cell) {
        guard let Id = Cell.IdCell else {return}
        if self.IdSelect.contains(Id) {
        if let index = self.IdSelect.firstIndex(of: Id) {
        IdSelect.remove(at: index)
        CollectionView.reloadItems(at: [indexPath])
        }
        }else{
        IdSelect.append(Id)
        CollectionView.reloadItems(at: [indexPath])
        }
           
        
        UIView.animate(withDuration: 0.3, animations: {
        Cell.SelectButton.transform = Cell.SelectButton.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.3, animations: {
        Cell.SelectButton.transform = .identity
        })
        })
        }
    }
    
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
    if textfield.text == "" {
    self.filtered = self.objects
    } else {
    self.filtered = self.objects.filter { Text in
    if let text = textfield.text?.lowercased() {
    return Text.Names.lowercased().contains(text) || Text.Numbers.lowercased().contains(text)
    }else {
    return false
    }
    }
    }

    CollectionView.reloadData()
    }
    
    func EdgeInsets(top:CGFloat,bottom:CGFloat) {
        let contentInsets = UIEdgeInsets(top: top, left: 0.0, bottom: bottom, right: 0.0)
        CollectionView.contentInset = contentInsets
        CollectionView.scrollIndicatorInsets = contentInsets
    }
}
