//
//  SavedVC.swift
//  
//
//  Created by Emoji Technology on 27/07/2021.
//

import UIKit

class SavedVC: ViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, SavedDelegate {
     
    
    private let SavedID = "CellSaved"
    var SavedFolderOn = [Saved]()
    var SavedFolderOF : Saved?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds

        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
        
        view.addSubview(AddButton)
        AddButton.frame = CGRect(x: view.frame.maxX - ControlX(50), y: ControlX(30), width: ControlWidth(50), height: ControlWidth(50))
        
        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: ControlX(90), width: view.frame.width - ControlWidth(30), height: view.frame.height - ControlWidth(90))
        
        
        GetSaved()
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
        refreshControl.addTarget(self, action: #selector(GetSaved), for: .valueChanged)
        CollectionView.refreshControl = refreshControl
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSaved), for: .touchUpInside)
    }
    
    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.alpha = 0.4
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "group31203")
        return ImageView
    }()
    
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Saved"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var AddButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        let image = UIImage(named: "group_26383")?.withInset(UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        Button.setBackgroundImage(image, for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionAdd), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionAdd() {
        SetUpViewAddEditFolder()
        SetUpAddFolder()
    }
    
    let PopAddEditFolder = PopUpDownView()
    func SetUpViewAddEditFolder() {
    PopAddEditFolder.currentState = .open
    PopAddEditFolder.modalPresentationStyle = .overFullScreen
    PopAddEditFolder.modalTransitionStyle = .coverVertical
    PopAddEditFolder.endCardHeight = ControlWidth(180)
    PopAddEditFolder.radius = 0
    PopAddEditFolder.View.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 237/255, alpha: 1)
    PopAddEditFolder.ViewDismiss.alpha = 0
        
    // Add in Items PopUp
    PopAddEditFolder.View.addSubview(DismissAdd)
    DismissAdd.frame = CGRect(x: ControlX(15), y: ControlX(10), width: ControlWidth(50), height: ControlWidth(40))
        
    PopAddEditFolder.View.addSubview(AddFolderLabel)
    AddFolderLabel.frame = CGRect(x: PopAddEditFolder.view.center.x - ControlX(75), y: ControlY(10), width: ControlWidth(150), height: ControlWidth(40))
        
    PopAddEditFolder.View.addSubview(AddFolderTF)
    AddFolderTF.frame = CGRect(x: PopAddEditFolder.view.center.x - ControlX(75), y: AddFolderLabel.frame.maxY + ControlY(5), width: ControlWidth(150), height: ControlWidth(30))
    
    PopAddEditFolder.View.addSubview(AddAndEditFolder)
    AddAndEditFolder.frame = CGRect(x: ControlX(15), y: AddFolderTF.frame.maxY + ControlX(20), width: PopAddEditFolder.view.frame.width - ControlWidth(30), height: ControlWidth(50))
    }
    
    func SetUpAddFolder() {
    AddFolderLabel.text = "Add New Folder"
    AddAndEditFolder.setTitle("Add Folder", for: .normal)
    present(PopAddEditFolder, animated: true)
    }
    
    lazy var DismissAdd : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismissAdd)))
        return dismiss
    }()
    
    @objc func ActionDismissAdd() {
    PopAddEditFolder.Dismiss()
    }
    
    lazy var AddFolderLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 99/255,green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var AddFolderTF : FloatingTF = {
        let tf = FloatingTF()
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = true
        tf.attributedPlaceholder = NSAttributedString(string: "Tables", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(ScrollTopAddEditFolder), for: .editingDidBegin)
        return tf
    }()
    
    @objc func ScrollTopAddEditFolder() {
    DispatchQueue.main.async {
    self.PopAddEditFolder.ViewScroll.setContentOffset(CGPoint(x: 0, y: ControlY(75)), animated: true)
    }
    }
    
    lazy var AddAndEditFolder : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionAddFolder), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionAddFolder() {
    if AddFolderTF.text?.TextNull() == true {
    if AddAndEditFolder.title(for: .normal) == "Add Folder" {
    NewFolderAdd()
    }else{
    UpdateFolder()
    }
    }else{
    PopEditDelete.Dismiss()
    PopAddEditFolder.Dismiss()
    }
    }
    
    @objc func NewFolderAdd() {
    guard let text = AddFolderTF.text else {return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + AddNewFolder)"
//        
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                     "SqlId": SqlId,
//                                     "FolderName": text]

    self.ProgressHud.beginRefreshing()
//        
//    PostAPI(api: api, token: token, parameters: parameters) { String in
//    } DictionaryData: { data in

        let data = ["Id" : 1,"Name" : "\(text)","Detalis" : []] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.SavedFolderOn.append(Saved(dictionary: data))
            self.SavedFolderOn.last?.Name = text
            self.CollectionView.reloadData()
            
            self.AddFolderTF.text = ""
            self.PopAddEditFolder.Dismiss()
            self.ProgressHud.endRefreshing("Success Add New Folder", .success) {}
        }
        
//        }
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.NewFolderAdd)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }
    
    @objc func UpdateFolder() {
    guard let Id = SavedId else {return}
    guard let text = AddFolderTF.text else {return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + UpdateSavedFolder)"
        

//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "SqlId": SqlId,
//                                     "Platform": "I",
//                                     "FolderId": Id,
//                                     "FolderName": text]

    self.ProgressHud.beginRefreshing()
        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
//
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.SavedFolderOn[self.SelectIndex.row].Name = text
            self.CollectionView.reloadData()
            
            self.AddFolderTF.text = ""
            self.PopEditDelete.Dismiss()
            self.PopAddEditFolder.Dismiss()
            self.ProgressHud.endRefreshing("Success Update Folder", .success) {}
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.UpdateFolder)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }

    lazy var CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.alwaysBounceVertical = true
        vc.showsVerticalScrollIndicator = false
        vc.register(SavedCell.self, forCellWithReuseIdentifier: SavedID)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return vc
    }()


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SavedFolderOn.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedID, for: indexPath) as! SavedCell
        cell.LabelTitle.text = SavedFolderOn[indexPath.item].Name
        cell.Delegate = self
    
        cell.Image1.sd_setImage(with: URL(string: SavedFolderOn[indexPath.item].Detalis[safe: 0]?.Path ?? "")) { _, _, _, _ in}
        cell.Image2.sd_setImage(with: URL(string: SavedFolderOn[indexPath.item].Detalis[safe: 1]?.Path ?? "")) { _, _, _, _ in}
        cell.Image3.sd_setImage(with: URL(string: SavedFolderOn[indexPath.item].Detalis[safe: 2]?.Path ?? "")) { _, _, _, _ in}
        return cell
    }
    
    func AllImageAction(Cell:SavedCell) {
    if let index = CollectionView.indexPath(for: Cell) {
    if !SavedFolderOn[index.item].Detalis.isEmpty {
    let SavedDetalis = ViewImageSaved()
    SavedDetalis.Saved = self
    SavedDetalis.SavedIndex = index
    SavedDetalis.SavedFolder = SavedFolderOn[index.item]
    Present(ViewController: self, ToViewController: SavedDetalis)
    }
    }
    }
    
    var SavedId : Int?
    var SelectIndex = IndexPath()
    let PopEditDelete = PopUpDownView()
    func EditDeleteAction(Cell:SavedCell) {
    if let index = CollectionView.indexPath(for: Cell) {
    SelectIndex = index
    SavedId = SavedFolderOn[index.row].Id
    }
        
    PopEditDelete.currentState = .open
    PopEditDelete.modalPresentationStyle = .overFullScreen
    PopEditDelete.modalTransitionStyle = .coverVertical
    PopEditDelete.endCardHeight = ControlWidth(180)
    PopEditDelete.radius = 25
    PopEditDelete.ViewDismiss.alpha = 0.5
        
    // Add in Items PopUp
    PopEditDelete.View.addSubview(FolderSettings)
    FolderSettings.frame = CGRect(x: ControlX(15), y: ControlX(20), width: PopEditDelete.view.frame.width - ControlWidth(30), height: ControlWidth(30))
        
    PopEditDelete.View.addSubview(EditFolder)
    EditFolder.frame = CGRect(x: ControlX(15), y: FolderSettings.frame.maxY + ControlX(10), width: PopEditDelete.view.frame.width - ControlWidth(30), height: ControlWidth(35))
    AddBottomBorder(EditFolder, "Edit Folder")
            
    PopEditDelete.View.addSubview(DeleteFolder)
    DeleteFolder.frame = CGRect(x: ControlX(15), y: EditFolder.frame.maxY + ControlX(20), width: EditFolder.frame.width, height: ControlWidth(35))
    AddBottomBorder(DeleteFolder, "Delete Folder")
        
    present(PopEditDelete, animated: true)
    }
    
    lazy var FolderSettings : UILabel = {
        let Label = UILabel()
        Label.text = "Folder Settings"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(17))
        Label.textColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var EditFolder : UIButton = {
        let Button = UIButton(type: .system)
        Button.setImage(UIImage(named: "edit"), for: .normal)
        Button.addTarget(self, action: #selector(ActionEditFolder), for: .touchUpInside)
        return Button
    }()

    @objc func ActionEditFolder() {
    SetUpViewAddEditFolder()
    SetUpEditFolder()
    }
    
    func SetUpEditFolder() {
    AddFolderLabel.text = "Edit Folder"
    AddAndEditFolder.setTitle("Save Changes", for: .normal)
    PopEditDelete.present(PopAddEditFolder, animated: true)
    }
    
    lazy var DeleteFolder : UIButton = {
        let Button = UIButton(type: .system)
        Button.clipsToBounds = true
        Button.setImage(UIImage(named: "trash"), for: .normal)
        Button.addTarget(self, action: #selector(ActionDeleteFolder), for: .touchUpInside)
        return Button
    }()
    

    @objc func ActionDeleteFolder() {
    ShowMessageAlert("𝗶", "DELETE FOLDER", "Are You Sure You Want to\nDelete this Folder", false, self.ActionDelete, "Delete")
    }

    @objc func ActionDelete() {
        
//    guard let Id = SavedId else {return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + DeleteSavedFolder)"
//            
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "SqlId": SqlId,
//                                     "Platform": "I",
//                                     "FolderId": Id]

    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.SavedFolderOn.remove(at: self.SelectIndex.item)
            self.CollectionView.deleteItems(at: [self.SelectIndex])
            self.CollectionView.reloadData()
            self.ProgressHud.endRefreshing() {self.IfNoData()}
            self.PopEditDelete.Dismiss()
            self.PopAddEditFolder.Dismiss()
        }
        
        
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData()
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionDelete)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }

    }

    func AddBottomBorder(_ Button:UIButton ,_ Title:String) {
    Button.setTitle(Title, for: .normal)
    Button.backgroundColor = .clear
    Button.contentHorizontalAlignment = .left
    Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
    Button.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    Button.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)

    Button.titleEdgeInsets = UIEdgeInsets(top: 0, left: ControlX(15), bottom: 0, right: 0)
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: Button.frame.size.height + ControlHeight(10), width: Button.frame.size.width , height: ControlHeight(1))
    bottomLine.backgroundColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.15).cgColor
    Button.layer.addSublayer(bottomLine)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ControlWidth(167), height: ControlWidth(177))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlWidth(15)
    }
    
    @objc func GetSaved() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + GetSavedFolder)"
//
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                      "SqlId": SqlId]

    self.ProgressHud.beginRefreshing()
        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
            
        ["Id" : 1,"Name" : "Folder 1","Detalis" :
        [["Id" : 1,"ProdectId" : 1,"Path" : "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_640.jpg","type" : "Test type"],
        ["Id" : 2,"ProdectId" : 2,"Path" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlohRRu0HkkNOxJId941Dm4ijDlXhRvGjVbcxTNShVeuSfoEBaOl83D3QoW-bkUSGLHsU&usqp=CAU","type" : "Test type"],
        ["Id" : 3,"ProdectId" : 3,"Path" : "https://st.depositphotos.com/20293186/58514/i/450/depositphotos_585149742-stock-photo-chamomile-black-background-close-summer.jpg","type" : "Test type"],
         ["Id" : 4,"ProdectId" : 4,"Path" : "https://images.ctfassets.net/hrltx12pl8hq/3Z1N8LpxtXNQhBD5EnIg8X/975e2497dc598bb64fde390592ae1133/spring-images-min.jpg","type" : "Test type"]]],
        
        
        ["Id" : 2,"Name" : "Folder 2","Detalis" :
        [["Id" : 1,"ProdectId" : 1,"Path" : "https://images.pexels.com/photos/46216/sunflower-flowers-bright-yellow-46216.jpeg","type" : "Test type"],
        ["Id" : 2,"ProdectId" : 2,"Path" : "https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2016/08/girasoles-2.jpg?fit=1024%2C768&quality=50&strip=all&ssl=1","type" : "Test type"],
        ["Id" : 3,"ProdectId" : 3,"Path" : "https://img.freepik.com/foto-gratis/girasoles-generados-ai_23-2150681808.jpg","type" : "Test type"]]],
        
        
        ["Id" : 2,"Name" : "Folder 3","Detalis" :
        [["Id" : 1,"ProdectId" : 1,"Path" : "https://huggingface.co/datasets/huggingfacejs/tasks/resolve/main/image-classification/image-classification-input.jpeg","type" : "Test type"],
        ["Id" : 2,"ProdectId" : 2,"Path" : "https://images.unsplash.com/photo-1580784355694-0d5295dcc007?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE3fHx8ZW58MHx8fHx8&w=1000&q=80","type" : "Test type"],
        ["Id" : 3,"ProdectId" : 3,"Path" : "https://st4.depositphotos.com/26985830/31451/i/450/depositphotos_314511594-stock-photo-surprised-tabby-kitten-village-orange.jpg","type" : "Test type"]]],
        
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.SavedFolderOn.removeAll()
            
            for item in data {
                self.SavedFolderOn.append(Saved(dictionary: item))
                self.CollectionView.AnimateCollection()
            }
            
            self.IfNoData()
            self.ProgressHud.endRefreshing() {}
            self.CollectionView.refreshControl?.endRefreshing()
        }
        
//    } Err: { error in
//    self.IfNoData()
//    self.CollectionView.refreshControl?.endRefreshing()
//            
//    if error != "" && error != "No Content" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.GetSaved)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    
//    }
    }

    func IfNoData() {
        if self.SavedFolderOn.count == 0 {
        self.ViewNoData.isHidden = false
        }else{
        self.ViewNoData.isHidden = true
        }
    }
    
}
