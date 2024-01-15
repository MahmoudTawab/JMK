//
//  EventPlanningStep3.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 20/12/2021.
//

import UIKit

class EventPlanningStep3: ViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource ,Step3CellDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(20), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = CGRect(x: 0, y: view.frame.height - ControlWidth(222.5), width: ControlWidth(375), height: ControlWidth(222.5))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
    }
    
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.bounces = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 80
        tv.backgroundColor = .white
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(EventPlanningStep3Cell.self, forCellReuseIdentifier: "Cell")
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return tv
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventPlanningStep3Cell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.Delegate = self
        return cell
    }
    
    func ActionNext() {
    Present(ViewController: self, ToViewController: EventPlanningStep4())
    }
    
    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Male")
        return ImageView
    }()
}
