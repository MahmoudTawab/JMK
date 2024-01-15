//
//  PaymentSettingsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 01/08/2021.
//

import UIKit

class PaymentSettingsVC: ViewController , UITableViewDelegate, UITableViewDataSource ,PaymentSettingsDelegate {
        
    private let PaymentID = "CellPayment"
    var TitlePlaces = ["Lorem Card","Lorem Card","Lorem Card"]
    var DetailsPlaces = ["2345**********","2345**********","2345**********"]

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
        TableView.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width , height: view.frame.height - ControlWidth(90))
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
        dismiss.TextDismiss = "Payment Settings"
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
        tv.rowHeight = ControlWidth(90)
        tv.register(PaymentSettingsCell.self, forCellReuseIdentifier: PaymentID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TitlePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentID, for: indexPath) as! PaymentSettingsCell
        cell.selectionStyle = .none
        cell.Delegate = self
        cell.LabelTitle.text = TitlePlaces[indexPath.row]
        cell.LabelDetails.text = DetailsPlaces[indexPath.row]
        
        if BackgroundIndex == indexPath {
        cell.PaymentSettingsWidth?.constant = ControlWidth(45)
        }else{
        cell.PaymentSettingsWidth?.constant = 0
        }
        
        return cell
    }
    
    var BackgroundIndex = IndexPath(row: 0, section: 0)
    func BackgroundAction(cell: PaymentSettingsCell) {
    UIView.animate(withDuration: 0.3, animations: {
    cell.PaymentSettings.transform = cell.PaymentSettings.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.3, animations: {
    cell.PaymentSettings.transform = .identity
    })
    })
    if let index = TableView.indexPath(for: cell) {
    BackgroundIndex = index
    TableView.reloadData()
    }
    }
    
    func EditAction(cell: PaymentSettingsCell) {
    Present(ViewController: self, ToViewController: EditCardVC())
    }
    
    var SelectIndex = IndexPath(row: 0, section: 0)
    func TrashAction(cell: PaymentSettingsCell) {
        if let index = TableView.indexPath(for: cell) {
        SelectIndex = index
        ShowMessageAlert("𝗶", "DELETE PAYMENT", "Are You Sure You Want to\nDelete this Payment", false, self.ActionDelete, "Delete")
        }
    }
    
    @objc func ActionDelete() {
    TableView.beginUpdates()
    TitlePlaces.remove(at: SelectIndex.item)
    TableView.deleteRows(at: [SelectIndex], with: .right)
    TableView.endUpdates()
    BackgroundIndex = IndexPath(row: 0, section: 0)
    }
    
    
}
