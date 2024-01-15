//
//  EventType.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 15/08/2021.
//

import UIKit
import SDWebImage

class EventType: ViewController, UITableViewDelegate, UITableViewDataSource , EventTypeCellDelegate, PackagesCellDelegate {
            
    private let EventTypeID = "EventTypeID"
    private let PackagesID = "PackagesID"
    var Packages = [PackagesWedding]()
    override func viewDidLoad() {
        super.viewDidLoad()

        BackgroundImage.frame = view.bounds
        view.addSubview(BackgroundImage)
        
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))

        
        WeddingPackages()
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(WeddingPackages), for: .touchUpInside)
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
        dismiss.TextDismiss = "Event Planning"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.register(EventTypeCell.self, forCellReuseIdentifier: EventTypeID)
        tv.register(PackagesCell.self, forCellReuseIdentifier: PackagesID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(10), right: 0)
        return tv
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : Packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTypeID, for: indexPath) as! EventTypeCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
            
        cell.Delegate = self
        cell.TitleLabel.text = "Customize Baby Shower"
        cell.DetailsLabel.setTitle("With simple and easy steps you Can customize your perfect \nevent.", for: .normal)
        cell.ImageView.image = UIImage(named: "EventType")
        return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: PackagesID, for: indexPath) as! PackagesCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.Delegate = self
            
        cell.TitleLabel.text = Packages[indexPath.row].PackageName
        cell.DetailsLabel.setTitle("From \(Packages[indexPath.row].BudgetFrom ?? 0)k to\(Packages[indexPath.row].BudgetTo ?? 0)K", for: .normal)
        cell.ImageView.sd_setImage(with: URL(string: Packages[indexPath.row].Icon ?? ""))
        return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? ControlWidth(230):ControlWidth(160)
    }
    
    func ActionBackground(Cell: EventTypeCell) {
    Present(ViewController: self, ToViewController: CustomizeEvent())
    }
    
    func ActionBackground(Cell: PackagesCell) {
    if let index = TableView.indexPath(for: Cell) {
    let Silver = SilverPackage()
    if let Id = Packages[index.item].Id {
    Silver.WeddingPackageId = Id
    Present(ViewController: self, ToViewController: Silver)
    }
    }
    }
    
    
    @objc func WeddingPackages() {
        
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetWeddingPackages)"
//        
//    var Id = String()
//    if let CategoryId = EventPlanningStep1.CategoryId {
//    Id = CategoryId
//    }else{
//    if let CategoryId = LaunchScreen.Cart?.CategoryId {
//    Id = CategoryId
//    }
//    }
//    
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                     "CategoryId": Id]
        
    self.ProgressHud.beginRefreshing()
        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
            ["Id" : 1,"Name" : "Packages Wedding","Icon" : "https://cdn-icons-png.flaticon.com/128/4853/4853062.png","BudgetFrom" : 10000,"BudgetTo" : 20000,"inCart" : true,
                    "Gallery" : [
                        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv5Dwa2Pi0SMi6zmv-ifcJZnPXR5vonEiZ0pFfNDbPvFzEte2xsjopVX30gEruxdOon3Y&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]],
                        
                    "SubCategories" : []],
            
            ["Id" : 1,"Name" : "Packages Wedding","Icon" : "https://cdn-icons-png.flaticon.com/128/4807/4807786.png","BudgetFrom" : 30000,"BudgetTo" : 20000,"inCart" : false,
                    "Gallery" : [
                        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv5Dwa2Pi0SMi6zmv-ifcJZnPXR5vonEiZ0pFfNDbPvFzEte2xsjopVX30gEruxdOon3Y&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]],
                        
                    "SubCategories" : []],
            
            ["Id" : 1,"Name" : "Packages Wedding","Icon" : "https://cdn-icons-png.flaticon.com/128/2403/2403066.png","BudgetFrom" : 40000,"BudgetTo" : 20000,"inCart" : true,
                    "Gallery" : [
                        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv5Dwa2Pi0SMi6zmv-ifcJZnPXR5vonEiZ0pFfNDbPvFzEte2xsjopVX30gEruxdOon3Y&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
                         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]],
                        
                    "SubCategories" : []]
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.Packages.removeAll()

            for item in data {
            self.Packages.append(PackagesWedding(dictionary: item))
            self.TableView.AnimateTable()
            }

            self.ViewNoData.isHidden = true
            self.ProgressHud.endRefreshing() {}
        }
        
//    } Err: { error in
//    if error != "" {
//    self.ViewNoData.isHidden = false
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.WeddingPackages)}
//    }
//    }
    }

}
