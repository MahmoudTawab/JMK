//
//  InviteGuestsSelected.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 26/07/2021.
//

import UIKit

class InviteGuestsSelected: ViewController, UITableViewDelegate, UITableViewDataSource {

    private let InviteGuestsID = "CellId"
    var NameArray = [String]()
    var PhoneArray = [String]()
    var ImageArray = [UIImage]()
    var Space = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        SetUp()
        TableView.AnimateTable()
    }

    
    func SetUp() {
        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(TextView)
        TextView.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlX(10), width: view.frame.width - ControlWidth(30), height: ControlWidth(100))
        
        var height = Int()
        if PhoneArray.count < 4 {
        height =  PhoneArray.count * Int(ControlWidth(90))
        Space = ControlWidth(15)
        }else{
        height = Int(4 * ControlWidth(90))
        Space = ControlWidth(5)
        }
        
        view.addSubview(SelectedGuests)
        SelectedGuests.frame = CGRect(x: ControlX(15), y: TextView.frame.maxY + Space, width: view.frame.width - ControlWidth(30), height: ControlWidth(25))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: ControlX(15), y: SelectedGuests.frame.maxY + Space + ControlX(5), width: view.frame.width - ControlWidth(30) , height: CGFloat(height))
        
        view.addSubview(SendInvitations)
        SendInvitations.frame = CGRect(x: ControlX(15), y: TableView.frame.maxY + Space + ControlX(10), width: view.frame.width - ControlWidth(30), height: ControlWidth(50))
        
        TableView.reloadData()
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
        dismiss.TextDismiss = "Invite Guests"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    NameArray.removeAll()
    PhoneArray.removeAll()
    ImageArray.removeAll()
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var TextView : UITextView = {
        let TV = UITextView()
        TV.backgroundColor = .clear
        TV.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo."
        TV.isEditable = false
        TV.isSelectable = false
        TV.keyboardAppearance = .light
        TV.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        TV.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        TV.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return TV
    }()

    
    lazy var SelectedGuests : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Selected Guests  ", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        ])
        attributedString.append(NSAttributedString(string: "( \(PhoneArray.count) )", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        ]))
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.rowHeight = ControlWidth(90)
        tv.register(InviteGuestsSelectedCell.self, forCellReuseIdentifier: InviteGuestsID)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhoneArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InviteGuestsID, for: indexPath) as! InviteGuestsSelectedCell
        cell.selectionStyle = .none
        cell.NameLabel.text = NameArray[indexPath.row]
        cell.PhoneLabel.text = PhoneArray[indexPath.row]
        cell.ProfileImage.image = ImageArray[indexPath.row]
        cell.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        return cell
    }
    
    lazy var SendInvitations : ButtonNotEnabled = {
    let Button = ButtonNotEnabled(type: .system)
    Button.setTitle("Send Invitations", for: .normal)
    Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
    Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
    Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
    Button.addTarget(self, action: #selector(ActionSend), for: .touchUpInside)
    return Button
    }()

    @objc func ActionSend() {
    let Successfully = ViewSuccessfully()
    Successfully.TextDismiss = ""
    Successfully.GoText = "Go Home"
    Successfully.ImageIcon = "loveLorge"
    Successfully.MessageTitle = "Invitations"
    Successfully.MessageDetails = "Your guests were invited successfully \n to your event"
    Successfully.GoToController.addTarget(self, action: #selector(SuccessfullyInvitations), for: .touchUpInside)
    Successfully.modalPresentationStyle = .overFullScreen
    Successfully.modalTransitionStyle = .crossDissolve
    present(Successfully, animated: true)
    }

    @objc func SuccessfullyInvitations() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
    appDelegate.window?.rootViewController?.dismiss(animated: false)
    appDelegate.window?.makeKeyAndVisible()
    appDelegate.window?.rootViewController = TabBarController()
    }
    }
}
