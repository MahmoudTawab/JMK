//
//  PackageCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/08/2021.
//

import UIKit
import SDWebImage

class PackageCell: UITableViewCell {
    
    let tableViewID = "CellTableView"
    let PopUp = PopUpDownView()
    var Package : SilverPackage?
    var ItemsDetails : MenuPackagesItemsDetails?
    var DetilsSubItems = [PackagesDetilsSubItems]()
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.rowHeight = ControlWidth(40)
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.register(CellTablePackage.self, forCellReuseIdentifier: tableViewID)
        tv.contentInset = UIEdgeInsets(top: ControlY(10), left: 0, bottom: ControlY(10), right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    
    // MARK: - Start SetUp PopUpDownView
    var ImageID = "ImageID"
    var ImagePopUp = [UIImage]()
    lazy var PopUpCollectionImage : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.isPagingEnabled = true
        vc.showsHorizontalScrollIndicator = false
        vc.register(CellCollectionPackage.self, forCellWithReuseIdentifier: ImageID)
        return vc
    }()

    lazy var pageControl:CHIPageControlPuya = {
        let pc = CHIPageControlPuya(frame: CGRect(x: 0, y:0, width: 100, height: 10))
        pc.delegate = self
        pc.tintColor = .black
        pc.enableTouchEvents = true
        pc.backgroundColor = .white
        pc.radius = ControlWidth(5)
        pc.padding = ControlWidth(10)
        pc.currentPageTintColor = #colorLiteral(red: 0.8610321879, green: 0.7267792821, blue: 0.6523330212, alpha: 1)
        pc.transform = CGAffineTransform(scaleX: ControlWidth(1), y: ControlWidth(1))
        return pc
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()

    var DetailHeight = CGFloat()
    var Detail = String()
    lazy var DetailLabel : UITextView = {
        let TV = UITextView()
        TV.text = Detail
        TV.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(16))
        TV.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        TV.isSelectable = false
        TV.isEditable = false
        TV.spasing = ControlHeight(6)
        TV.backgroundColor = .clear
        TV.keyboardAppearance = .light
        TV.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        return TV
    }()
    
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
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(BackgroundView)
        BackgroundView.addSubview(LabelName)
        BackgroundView.addSubview(tableView)
        BackgroundView.addSubview(BackgroundImage)
            
        NSLayoutConstraint.activate([
        BackgroundView.topAnchor.constraint(equalTo: topAnchor),
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(15)),
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)),
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlY(-15)),
        
        LabelName.topAnchor.constraint(equalTo: BackgroundView.topAnchor ,constant: ControlX(15)),
        LabelName.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor ,constant: ControlX(15)),
        LabelName.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor ,constant: ControlX(-15)),
        LabelName.heightAnchor.constraint(equalToConstant: ControlWidth(30)),
        
        tableView.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor),
        tableView.topAnchor.constraint(equalTo: LabelName.bottomAnchor, constant: ControlY(5)),
        tableView.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor),
            
        BackgroundImage.topAnchor.constraint(equalTo: BackgroundView.topAnchor),
        BackgroundImage.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor),
        BackgroundImage.widthAnchor.constraint(equalToConstant: ControlWidth(120)),
        BackgroundImage.heightAnchor.constraint(equalToConstant: ControlWidth(100))
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

///... Set Up Cell Table Package
extension PackageCell: UITableViewDelegate, UITableViewDataSource , CellTablePackageDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DetilsSubItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = CellTablePackage(style: .subtitle, reuseIdentifier: tableViewID)

    cell.TitleLabel.text = DetilsSubItems[indexPath.row].Name
    cell.Delegate = self
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    return cell
    }
    
    func BackgroundAction(cell: CellTablePackage) {
            
    if let index = tableView.indexPath(for: cell) {
        
    guard let ItemId = DetilsSubItems[index.row].Id else{return}
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + GetItemDetils)"

    guard let CartId = LaunchScreen.Cart?.CartId else{return}
    guard let SqlId = LaunchScreen.User?.SqlId else{return}
        
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                    "Platform": "I",
                                    "SqlId": SqlId,
                                    "CartId": "\(CartId)",
                                    "ItemId": "\(ItemId)",
                                    "Token": "8_Py5oXPKhS6fUmbMz_1AQPuSX9jJLDBq-Zb2Zqv3DY"]

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    self.Package?.ProgressHud.beginRefreshing()
    }
           
    PostAPI(api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
        
    self.ItemsDetails = MenuPackagesItemsDetails(dictionary: data)
    self.ImagePopUp.removeAll()
        
    if let Details = self.ItemsDetails?.Details {                    
    self.TitleLabel.text = Details.Name
    self.Detail = Details.Description ?? ""
                 
    if Details.Gallery.count == 0 {
    self.ImagePopUp.append(UIImage(named: "group26396") ?? UIImage())
    self.PopUpCollectionImage.AnimateCollection()
    }else{
                    
    for Photo in Details.Gallery {
    if let images = Photo.PhotoPath {
    SDWebImageManager.shared.loadImage(with: URL(string: images),
    options: .highPriority ,progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
    if let img = image {
    self.ImagePopUp.append(img)
    self.PopUpCollectionImage.AnimateCollection()
    self.pageControl.numberOfPages = self.ImagePopUp.count
    }}}}}
    self.Package?.ProgressHud.endRefreshing() {self.SetUpPopUp()}
    }
        
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    self.Package?.ProgressHud.endRefreshing(error, .error) {}
    }
    }
    }
    }
    
    func SetUpPopUp() {
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
        
    guard let Height = Detail.heightWithConstrainedWidth(PopUp.view.frame.width - ControlWidth(30), font: UIFont.boldSystemFont(ofSize:ControlWidth(16)), Spacing: ControlHeight(6)) else{return}
        
    self.DetailHeight = Height < (UIScreen.main.bounds.height / 2.2) ? Height:(UIScreen.main.bounds.height / 2.2)
        
    PopUp.endCardHeight = ControlWidth(self.DetailHeight + 290)
    PopUp.radius = 25
    PopUp.View.backgroundColor = .white
        
    // MARK: - Start SetUp PopUp
    PopUp.View.addSubview(PopUpCollectionImage)
    PopUp.View.addSubview(pageControl)
    PopUp.View.addSubview(TitleLabel)
    PopUp.View.addSubview(DetailLabel)
        
    PopUpCollectionImage.frame = CGRect(x: ControlX(15), y: ControlX(5), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(190))
        
    pageControl.frame = CGRect(x: ControlX(15), y: PopUpCollectionImage.frame.maxY + ControlX(15), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(10))
        
    TitleLabel.frame = CGRect(x: ControlX(15), y: pageControl.frame.maxY + ControlX(10), width: PopUp.view.frame.width - ControlWidth(30), height: ControlHeight(30))
    
    DetailLabel.frame = CGRect(x: ControlX(15), y: TitleLabel.frame.maxY , width: PopUp.view.frame.width - ControlWidth(30), height: self.DetailHeight + 15)
        
    Package?.present(PopUp, animated: true)
    }
    
}

///... Set Up Cell Collection Package
extension PackageCell: UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout ,CHIBasePageControlDelegate ,MediaBrowserDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImagePopUp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageID, for: indexPath) as! CellCollectionPackage
        cell.ItemsImage.image = ImagePopUp[indexPath.item]
        return cell
    }
    
    func didTouch(pager: CHIBasePageControl, index: Int) {
    pageControl.set(progress: index, animated: true)
    PopUpCollectionImage.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let browser = MediaBrowser(delegate: self)
    browser.enableGrid = false
    browser.title = "Package Details"
    browser.setCurrentIndex(at: indexPath.item)
    browser.displayMediaNavigationArrows = true
    let nc = UINavigationController(rootViewController: browser)
    nc.modalPresentationStyle = .fullScreen
    nc.modalTransitionStyle = .coverVertical
    PopUp.present(nc, animated: true)
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
    ImagePopUp.count
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageWidth = Float(PopUpCollectionImage.frame.width)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(PopUpCollectionImage.contentSize.width)
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
     
        self.pageControl.set(progress: Int(newPage), animated: true)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: ImagePopUp[index] ,caption: "Wedding Package Details")
    return photo
    }
    
}

