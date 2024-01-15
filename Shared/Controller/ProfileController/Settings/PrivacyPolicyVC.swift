//
//  PrivacyPolicyVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 02/08/2021.
//

import UIKit
import FlagPhoneNumber

class PrivacyPolicyVC: ViewController , UITableViewDelegate, UITableViewDataSource {
    
    private let PrivacyPolicyID = "CellPrivacyPolicy"
    var Privacy = [PrivacyPolicy]()
    override func viewDidLoad() {
    super.viewDidLoad()
        
    SetUp()
    
    }
        
    func SetUp() {
        
    BackgroundImage.frame = view.bounds
    view.addSubview(BackgroundImage)
            
    view.addSubview(Dismiss)
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
    view.addSubview(TableView)
    TableView.frame = CGRect(x: 0, y:  ControlX(90), width: view.frame.width , height: view.frame.height - ControlWidth(90))
                
    GetPrivacyPolicy()
    ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetPrivacyPolicy), for: .touchUpInside)
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
        dismiss.TextDismiss = "Privacy Policy"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.estimatedRowHeight = ControlWidth(80)
        tv.rowHeight = UITableView.automaticDimension
        tv.register(UITableViewCell.self, forCellReuseIdentifier: PrivacyPolicyID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(10), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Privacy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: PrivacyPolicyID)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        if let Label = cell.textLabel , let DetailLabel = cell.detailTextLabel {
        Label.text = Privacy[indexPath.row].Title
        cell.detailTextLabel?.text = Privacy[indexPath.row].Body
        
        Label.numberOfLines = 0
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    
        DetailLabel.numberOfLines = 0
        DetailLabel.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        DetailLabel.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
    
        Label.frame = CGRect(x: ControlX(15), y: Label.frame.origin.y - ControlY(1.5), width: cell.frame.width - ControlWidth(30), height: Label.frame.height)
        
        DetailLabel.frame = CGRect(x: ControlX(15), y: DetailLabel.frame.origin.y + ControlY(1.5), width: cell.frame.width - ControlWidth(30), height: DetailLabel.frame.height)
        }
        return cell
    }
    
    @objc func GetPrivacyPolicy() {
//        guard let url = defaults.string(forKey: "API") else{return}
//        guard let token = defaults.string(forKey: "JWT") else{return}
//        let api = "\(url + PhoneGetPrivacyPolicy)"
//            
//      
//        let parameters:[String : Any] = ["language": "EN"]
//        
        self.ProgressHud.beginRefreshing()
//
//        PostAPI(api: api, token: token, parameters: parameters) { _ in
//        } DictionaryData: { _ in
//        } ArrayOfDictionary: { data in
        let data = [
           ["Title" : "Test Title 1","Body" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
           ["Title" : "Test Title 2","Body" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
           ["Title" : "Test Title 3","Body" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
           ["Title" : "Test Title 4","Body" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"],
           ["Title" : "Test Title 5","Body" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"]]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.Privacy.removeAll()
            
            for item in data {
                self.Privacy.append(PrivacyPolicy(dictionary: item))
                self.TableView.reloadData()
            }
            
            self.ProgressHud.endRefreshing(){}
            self.ViewNoData.isHidden = self.Privacy.count != 0 ? true:false
        }
//        } Err: { error in
//        
//        if error != "" {
//        self.ViewNoData.isHidden = false
//        self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetPrivacyPolicy)}
//        }
//        }
    }


}
