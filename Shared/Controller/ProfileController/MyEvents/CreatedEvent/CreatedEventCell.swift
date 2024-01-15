//
//  CreatedEventCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 19/07/2021.
//

import UIKit

protocol CreatedEventDelegate {
    func EditAction(cell:CreatedEventCell)
    func PackagesDelete(cell:CreatedEventCell)
    func SubPackagesDelete(cell:CreatedEventCell)
}

class CreatedEventCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource , CellTableCreatedDelegate {
            
    var Delegate : CreatedEventDelegate?
    var CreatedEvent : CreatedEventVC?
    var Cart : CartVC?
    
    var CartDetils : AllCartDetils? {
        didSet {
        LabelName.text = CartDetils?.PackagName ?? ""
        PriceLabel.text = "\(CartDetils?.PackageTotal ?? 0)"
        }
    }

    var CellTrashHidden = true
    private let tableViewID = "CellTableView"
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.rowHeight = ControlWidth(40)
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.register(CellTableCreated.self, forCellReuseIdentifier: tableViewID)
        tv.contentInset = UIEdgeInsets(top: ControlY(10), left: 0, bottom: ControlY(10), right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return CartDetils?.SubPackages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = CellTableCreated(style: .subtitle, reuseIdentifier: tableViewID)
    cell.Delegate = self
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    cell.TrashButton.isHidden = CellTrashHidden
    cell.TitleLabel.text = "\(CartDetils?.SubPackages[indexPath.row].Count ?? 0) X \(CartDetils?.SubPackages[indexPath.row].Name ?? "")"
    return cell
    }
    
    func SubPackagesDelete(cell: CellTableCreated) {
    if let Index = tableView.indexPath(for: cell) {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let token = defaults.string(forKey: "JWT") else{return}
    let api = "\(url + DeleteSubPackages)"

    guard let SqlId = LaunchScreen.User?.SqlId else{return}
    guard let CartId = LaunchScreen.Cart?.CartId else{return}
    guard let EvintId = LaunchScreen.Cart?.EvintId else{return}
    guard let PackageId = CartDetils?.SubPackages[Index.item].PackageId else{return}

    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                    "Platform": "I",
                                    "SqlId": SqlId,
                                    "CartId":CartId,
                                    "SubPackagesId": PackageId,
                                    "EventId":EvintId]

    Cart?.ProgressHud.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { String in
    if let index = self.CartDetils?.SubPackages.firstIndex(where: {$0.PackageId == PackageId})   {
    self.Cart?.ProgressHud.endRefreshing() {}
    self.CartDetils?.SubPackages.remove(at: index)
    self.tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .right)
    self.Delegate?.SubPackagesDelete(cell: self)
    }
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    error != "" ? self.Cart?.ProgressHud.endRefreshing(error, .error) {}:self.Cart?.ProgressHud.endRefreshing() {}
    }
    }
    }
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.7454141974, green: 0.7455408573, blue: 0.7453975677, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: -1, height:1.4)
        View.layer.shadowRadius = 4
        View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var EditButton : UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.image = UIImage(named: "edit")
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.8)
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionEdit)))
        return image
    }()
    
    @objc func ActionEdit() {
        Delegate?.EditAction(cell: self)
    }
    
    lazy var TrashButton : UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.image = UIImage(named: "trash")
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.8)
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionTrash)))
        return image
    }()

    
    @objc func ActionTrash() {
        Delegate?.PackagesDelete(cell: self)
    }


    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var PriceLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Label.textColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(BackgroundView)
        BackgroundView.addSubview(BackgroundImage)
        BackgroundView.addSubview(LabelName)
        BackgroundView.addSubview(tableView)
        BackgroundView.addSubview(PriceLabel)
        BackgroundView.addSubview(TrashButton)
        BackgroundView.addSubview(EditButton)
            
        NSLayoutConstraint.activate([
        BackgroundView.topAnchor.constraint(equalTo: topAnchor),
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ControlX(15)),
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ControlX(15)),
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-15)),
            
        LabelName.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlX(10)),
        LabelName.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor ,constant: ControlX(15)),
        LabelName.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor ,constant: ControlX(-15)),
        LabelName.heightAnchor.constraint(equalToConstant: ControlWidth(30)),
        
        tableView.topAnchor.constraint(equalTo: LabelName.bottomAnchor, constant: ControlX(5)),
        tableView.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor,constant: ControlX(15)),
        tableView.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor,constant: ControlX(-15)),
        tableView.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor ,constant: ControlY(-45)),
        
        PriceLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: ControlX(5)),
        PriceLabel.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor,constant: ControlX(15)),
        PriceLabel.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor,constant: ControlX(-15)),
        PriceLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor),
            
        BackgroundImage.topAnchor.constraint(equalTo: BackgroundView.topAnchor),
        BackgroundImage.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor),
        BackgroundImage.widthAnchor.constraint(equalToConstant: ControlWidth(150)),
        BackgroundImage.heightAnchor.constraint(equalToConstant: ControlWidth(130)),
         
        TrashButton.topAnchor.constraint(equalTo: topAnchor ,constant: ControlX(15)),
        TrashButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        TrashButton.widthAnchor.constraint(equalToConstant: ControlWidth(24)),
        TrashButton.heightAnchor.constraint(equalTo: TrashButton.widthAnchor),
            
        EditButton.centerYAnchor.constraint(equalTo: TrashButton.centerYAnchor),
        EditButton.trailingAnchor.constraint(equalTo: TrashButton.leadingAnchor ,constant: ControlX(-10)),
        EditButton.widthAnchor.constraint(equalTo: TrashButton.widthAnchor),
        EditButton.heightAnchor.constraint(equalTo: TrashButton.heightAnchor)
        ])
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


protocol CellTableCreatedDelegate {
    func SubPackagesDelete(cell:CellTableCreated)
}

class CellTableCreated: UITableViewCell {
    
    var Delegate : CellTableCreatedDelegate?
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var DetailLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.5)
        Label.backgroundColor = .clear
        return Label
    }()

    lazy var TrashButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("−", for: .normal)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(-2), left: 0, bottom: 0, right: 0)
        Button.backgroundColor = .clear
        Button.titleLabel?.font = UIFont.italicSystemFont(ofSize: ControlWidth(18))
        Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        Button.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        Button.layer.borderWidth = ControlHeight(1.5)
        Button.layer.cornerRadius = ControlWidth(20) / 2
        Button.addTarget(self, action: #selector(ActionTrash), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionTrash() {
    Delegate?.SubPackagesDelete(cell: self)
    }
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(TitleLabel)
        contentView.addSubview(DetailLabel)
        contentView.addSubview(TrashButton)
  
        TitleLabel.frame = CGRect(x: 0, y: ControlX(5), width: rect.width - ControlWidth(50), height: ControlWidth(30))
        TrashButton.frame = CGRect(x: frame.maxX - ControlWidth(22), y: ControlX(8), width: ControlWidth(20) , height: ControlWidth(20))
        if let width = DetailLabel.text?.textSizeWithFont(UIFont.systemFont(ofSize: ControlWidth(16))).width {
        DetailLabel.frame = CGRect(x: frame.maxX - ControlX(150), y: ControlX(5), width: width , height: ControlWidth(30))
        }
    }
    
}
