//
//  HowItWorksController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/07/2021.
//

import UIKit

class HowItWorksController: ViewController , UITableViewDelegate, UITableViewDataSource {
    
    private let HowItWorksID = "CellHowItWorks"
    var HowItWorksData = [HowItWorks]()
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds

        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(100), height: ControlHeight(50))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
        
        HowItWorksGet()
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.HowItWorksGet), for: .touchUpInside)
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
        dismiss.TextDismiss = "How it works?"
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
        tv.estimatedRowHeight = 80
        tv.rowHeight = UITableView.automaticDimension
        tv.backgroundColor = .clear
        tv.register(HowItWorksCell.self, forCellReuseIdentifier: HowItWorksID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HowItWorksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HowItWorksID, for: indexPath) as! HowItWorksCell
        cell.selectionStyle = .none
        cell.LabelTitle.text = HowItWorksData[indexPath.item].title
        cell.LabelDetails.text = HowItWorksData[indexPath.item].body
        if let icon = HowItWorksData[indexPath.item].icon {
        cell.IconImage.sd_setImage(with: URL(string: icon))
        }
        cell.LabelDetails.spasing = 4
        return cell
    }
    
    @objc func HowItWorksGet() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetHowItWorks)"
        
    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: nil, parameters: [:]) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
            ["id" : "","title" : "Test Title 1","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments.","icon" : "https://cdn-icons-png.flaticon.com/512/3417/3417915.png"],
            ["id" : "","title" : "Test Title 2","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments.","icon" : "https://universidadeniltonlins.com.br/wp-content/plugins/supportboard/supportboard/media/icons/png/icon-attachment.png"],
            ["id" : "","title" : "Test Title 3","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments.","icon" : "https://www.iconpacks.net/icons/1/free-mail-icon-142-thumb.png"],
            ["id" : "","title" : "Test Title 4","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments.","icon" : "https://cdn-icons-png.flaticon.com/512/1674/1674868.png"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            for item in data {
                self.HowItWorksData.append(HowItWorks(dictionary: item))
            }
            
            self.TableView.AnimateTable()
            self.ProgressHud.endRefreshing(){}
            self.ViewNoData.isHidden = self.HowItWorksData.count != 0 ? true:false
        }
        
//    } Err: { error in
//    if error != "" {
//    self.ViewNoData.isHidden = false
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.HowItWorksGet)}
//    }
//    }
    }
    
}
