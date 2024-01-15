//
//  OurStoryController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/07/2021.
//

import UIKit

class OurStoryController: ViewController ,UITableViewDelegate , UITableViewDataSource {

    private let OurStoryId = "CellOurStory"
    var Story = [OurStory]()
    var image = ["","mission3","eye"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetStory), for: .touchUpInside)
        
        GetStory()
    }
    
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Our Story"
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
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(OurStoryCell.self, forCellReuseIdentifier: OurStoryId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Story.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OurStoryId, for: indexPath) as! OurStoryCell
        cell.selectionStyle = .none
        
        cell.LabelTitle.text = Story[indexPath.item].title
        cell.LabelDetails.text = Story[indexPath.item].body
        
        if indexPath.item == 0 {
        cell.IconBackground.isHidden = false
        cell.ImageLeft.isHidden = true
        cell.CellBackground.backgroundColor = .white
        cell.ImageTop.image = UIImage(named: "OurStory")
        }else{
        cell.ImageLeft.isHidden = false
        cell.IconBackground.isHidden = true
        cell.ImageLeft.image = UIImage(named: image[indexPath.item])
        cell.CellBackground.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        }
        
        return cell
    }
    
    
    @objc func GetStory() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetOurStory)"
        
    self.ProgressHud.beginRefreshing()
            
//    PostAPI(api: api, token: nil, parameters: [:]) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
    
        let data = [
            ["id" : "","title" : "Test Title 1","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments."],
            ["id" : "","title" : "Test Title 2","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments."],
            ["id" : "","title" : "Test Title 3","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments."]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            for item in data {
                if self.Story.count <= 2 {
                    self.Story.append(OurStory(dictionary: item))
                }
            }
            
            self.TableView.AnimateTable()
            self.ProgressHud.endRefreshing(){}
            self.ViewNoData.isHidden = self.Story.count != 0 ? true:false
        }
//    } Err: { error in
//    if error != "" {
//    self.ViewNoData.isHidden = false
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetStory)}
//    }
//    }
    }
}
