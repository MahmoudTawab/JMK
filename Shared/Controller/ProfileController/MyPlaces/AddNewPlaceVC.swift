//
//  AddNewPlaceVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 31/07/2021.
//

import UIKit
import Photos
import ImagePicker
import FirebaseAuth
import SDWebImage
import FlagPhoneNumber

class AddNewPlaceVC: ViewController, ImagePickerDelegate, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , AddNewPlaceCellDelegate ,MediaBrowserDelegate, UITextFieldDelegate {
        
    var DismissTitle = String()
    var PlaceId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUp()
        
        IfIsUpdatePlace()
        
    }
    
    func SetUp() {
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: ControlX(80), width: view.frame.width, height: view.frame.height - ControlWidth(80))
        
        
        let StackVertical = UIStackView(arrangedSubviews: [PlaceAreaTF,PlaceAddressTF,PlaceNameTF,IndoorOrOutdoorTF,PlaceTypeTF])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(30)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.clipsToBounds = false
        StackVertical.backgroundColor = .clear
        ViewScroll.addSubview(StackVertical)
        StackVertical.frame = CGRect(x: ControlX(15), y: ControlX(20), width: view.frame.width - ControlWidth(30), height: ControlWidth(400))
    
        
        ViewScroll.addSubview(PlacePhotos)
        PlacePhotos.frame = CGRect(x: ControlX(15), y: ControlX(460), width: view.frame.width - ControlWidth(30), height: ControlWidth(20))
        
        ViewScroll.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: ControlX(500), width: view.frame.width - ControlWidth(30), height: ControlWidth(150))
        
        ViewScroll.addSubview(SubmitOrSaveChanges)
        SubmitOrSaveChanges.frame = CGRect(x: ControlX(15), y: ControlX(675), width: view.frame.width - ControlWidth(30), height: ControlWidth(50))

        // MARK: - ViewScroll contentSize height
        self.ViewScroll.updateContentViewSize(ControlWidth(30))
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        return Scroll
    }()
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "\(DismissTitle)"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()

    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    lazy var PlaceAreaTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.delegate = self
        tf.Icon.setTitle("\u{33A1}", for: .normal)
        tf.SetUpIcon(LeftOrRight: false, Width: 33, Height: 25)
        tf.Icon.titleLabel?.font = UIFont(name: "Raleway-Light", size: ControlWidth(23))
        tf.Icon.setTitleColor(UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1), for: .normal)
        tf.attributedPlaceholder = NSAttributedString(string: "Place Area", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
          return true
        }
        else if let intValue = Int(newText), intValue <= 32000 {
          return true
        }
        return false
      }

    
    lazy var PlaceAddressTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Place address", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var PlaceNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Place name", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var IndoorOrOutdoorTF : FloatingTF = {
        let tf = FloatingTF()
        tf.IconImage = UIImage(named: "down")
        tf.SetUpIcon(LeftOrRight: false)
        tf.TitleHidden = false
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Icon.addTarget(self, action: #selector(IndoorOrOutdoorChanging), for: .touchUpInside)
        tf.addTarget(self, action: #selector(IndoorOrOutdoorChanging), for: .editingDidBegin)
        tf.attributedPlaceholder = NSAttributedString(string: "Is it Indoor or outdoor place?", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func IndoorOrOutdoorChanging() {
    IndoorOrOutdoorTF.resignFirstResponder()
    let title = "Is it Indoor or outdoor place?"
    let attributeString = NSMutableAttributedString(string: title)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)],//3
                                                  range: NSMakeRange(0, title.utf8.count))
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
    alertController.setValue(attributeString, forKey: "attributedTitle")
    alertController.addAction(UIAlertAction(title: "Yes", style: .default , handler: { (_) in
    self.IndoorOrOutdoorTF.text = "Yes"
    self.PlaceTypeTF.becomeFirstResponder()
    }))
 

    alertController.addAction(UIAlertAction(title: "No", style: .default , handler: { (_) in
    self.IndoorOrOutdoorTF.text = "No"
    self.PlaceTypeTF.becomeFirstResponder()
    }))
        
    alertController.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
    present(alertController, animated: true)
    }
    
    lazy var PlaceTypeTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Place type", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var PlacePhotos : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Place Photos " , attributes: [
        .font: UIFont(name: "Raleway-Regular", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
        .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        ])
        attributedString.append(NSAttributedString(string: "(Optional)", attributes: [
        .font: UIFont(name: "Raleway-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
        .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.6508079062)
        ]))
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        return Label
    }()
    
    private let PlaceID = "CellPlace"
    lazy var CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(8)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.showsHorizontalScrollIndicator = false
        vc.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        vc.dataSource = self
        vc.delegate = self
        vc.register(AddNewPlaceImageCell.self, forCellWithReuseIdentifier: PlaceID)
        return vc
    }()

    var imageArray = [MyPlacesImage]()
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
        return 1
        }else{
        return imageArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceID, for: indexPath) as! AddNewPlaceImageCell
        
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        
        if indexPath.section == 0 {
        cell.TopImage.isHidden = true
        cell.LabelTitle.isHidden = false
        cell.ImageView.backgroundColor = .clear
        cell.ImageView.image = UIImage(named: "add")?.withInset(UIEdgeInsets(top: 18, left: 10, bottom: 27, right: 8))

        cell.ImageView.layer.shadowColor = UIColor.clear.cgColor
        cell.backgroundColor = UIColor(red: 57/255, green: 56/255, blue: 55/255, alpha: 1)
        }else{
        cell.Delegate = self
        cell.backgroundColor = .clear
        cell.TopImage.isHidden = false
        cell.LabelTitle.isHidden = true

        cell.ImageView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.ImageView.image = imageArray[indexPath.item].Image
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 32) / 3, height: collectionView.frame.height)
    }
    
    var mediaArray = [Media]()
    var thumbs = [Media]()
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return imageArray.count
    }
    
    func thumbnail(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    for image in imageArray {
    let Image = Media(image: image.Image ?? UIImage(), caption: "New Place Image")
    thumbs.append(Image)
    }
    return thumbs[index]
    }

    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    for image in imageArray {
    let Image = Media(image: image.Image ?? UIImage(), caption: "New Place Image")
    mediaArray.append(Image)
    }
    return mediaArray[index]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 0 {
    ActionPlacePhotos()
    }else{
    let browser = MediaBrowser(delegate: self)
    browser.setCurrentIndex(at: indexPath.row)
    browser.displayMediaNavigationArrows = true
    let nc = UINavigationController(rootViewController: browser)
    nc.modalPresentationStyle = .fullScreen
    nc.modalTransitionStyle = .coverVertical
    present(nc, animated: true)
    }
    }
    
    var SelectIndex = IndexPath(item: 0, section: 0)
    func TopImageSelect(cell: AddNewPlaceImageCell) {
        if let index = CollectionView.indexPath(for: cell) {
        UIView.animate(withDuration: 0.2, animations: {
        cell.transform = cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.2, animations: {
        cell.transform = .identity
        })
        })
        
        SelectIndex = index
        ShowMessageAlert("𝗶", "DELETE IMAGE", "Are You Sure You Want to\nDelete this Image", false, self.ActionDelete, "Delete")
        }
    }
    
    @objc func ActionDelete() {
        
    if imagesUrl.count > SelectIndex.item {
    imagesUrl.remove(at: SelectIndex.item)
    }else{
        
    evenAssets.remove(at: SelectIndex.item - imagesUrl.count)
    }

    imageArray.remove(at: SelectIndex.item)
    CollectionView.deleteItems(at: [SelectIndex])
    CollectionView.reloadData()
    }

    var evenAssets = [PHAsset]()
    @objc func ActionPlacePhotos() {
    view.endEditing(false)
    let config = Configuration()
    config.doneButtonTitle = "Finish"
    config.noImagesTitle = "Sorry! Please Wait..."
    config.recordLocation = true
    config.showsImageCountLabel = true
    let imagePickerController = ImagePickerController(configuration: config)
    imagePickerController.delegate = self
    imagePickerController.imageLimit = 10 - imagesUrl.count
    imagePickerController.stack.assets = evenAssets
    Present(ViewController: self, ToViewController: imagePickerController)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
                
    if evenAssets.count <= 10 - imagesUrl.count {
        
    imageArray.removeAll { Image in
    if Image.islocal {
    evenAssets.removeAll()
    return true
    }
    return false
    }
        
    for Image in images {
    imageArray.append(MyPlacesImage(Path: "PhotoPath", Image: Image, islocal: true))
    CollectionView.reloadData()
    }
    evenAssets.append(contentsOf: imagePicker.stack.assets)
    }else{
    print("error")
    }
        
    self.self.navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
    self.self.navigationController?.popViewController(animated: true)
    }
    
    lazy var SubmitOrSaveChanges : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()
    
    static let PostPlace = NSNotification.Name(rawValue: "PostPlace")
    @objc func ActionSaveChanges() {
    if PlaceAreaTF.NoError() && PlaceAddressTF.NoError() && PlaceNameTF.NoError() && IndoorOrOutdoorTF.NoError() && PlaceTypeTF.NoError() {
    AddAndUpdatePlace()
    }else{
    ViewScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    }
    
    var images = [UIImage]()
    var imagesUrl = [String]()
    var UploadImage = [[String:Any]]()
    @objc func AddAndUpdatePlace() {

    self.ProgressHud.beginRefreshing()
    if imageArray.count != 0 {
    guard let Uid = Auth.auth().currentUser?.uid else{return}
        
    if imagesUrl.count != 0 {
    for Image in self.imagesUrl {
    self.UploadImage.append(["PhotoPath":Image])
    }
    }
        
        
    for Image in imageArray {
        
    if Image.islocal {
    if let image = Image.Image {
    self.images.append(image)
        
    StoragArray(child: ["places_pictures",Uid], image: self.images) { url in
            
    self.UploadImage.append(["PhotoPath":url])
            
    if self.UploadImage.count == self.imageArray.count {
    if self.DismissTitle == "Add New Place" {
    self.AddPlaceApi()
    }else{
    self.UpdatePlace()
    }
    }
            
    } Err: { error in
    if error != "" {
    self.ProgressHud.endRefreshing(error, .error) {}
    return
    }else{
    self.ProgressHud.endRefreshing() {}
    }
    }
    }
    }
        
    if imageArray.count == imagesUrl.count {
    if self.DismissTitle == "Add New Place" {
    self.AddPlaceApi()
    }else{
    self.UpdatePlace()
    }
    }
    }
        
    }else{
    if self.DismissTitle == "Add New Place" {
    self.AddPlaceApi()
    }else{
    self.UpdatePlace()
    }
    }
        
    }
    
    
    func AddPlaceApi() {
    guard let PlaceArea = PlaceAreaTF.text else{return}
    guard let PlaceAddress = PlaceAddressTF.text else{return}
    guard let PlaceName = PlaceNameTF.text else{return}
    let IndoorOrOutdoorTF = IndoorOrOutdoorTF.text == "Yes" ? true : false
    guard let PlaceType = PlaceTypeTF.text else{return}

    guard let url = defaults.string(forKey: "API") else{return}
    guard let token = defaults.string(forKey: "JWT") else{return}
    let api = "\(url + AddNewPlace)"


    guard let SqlId = LaunchScreen.User?.SqlId else{return}
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                     "SqlId": SqlId,
                                     "Platform": "I",

                                     "Area": (PlaceArea as NSString).integerValue,
                                     "Address": PlaceAddress,
                                     "Name": PlaceName,
                                     "Indoor": IndoorOrOutdoorTF,
                                     "Type": PlaceType,
                                     "Photo": self.UploadImage]
        
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.ProgressHud.endRefreshing("Success Add Place", .success) {
    self.images.removeAll()
    self.UploadImage.removeAll()
    NotificationCenter.default.post(name: AddNewPlaceVC.PostPlace, object: nil)
    }
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.images.removeAll()
    self.UploadImage.removeAll()
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.AddAndUpdatePlace)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }

    }
    }
    
    @objc func UpdatePlace() {
    guard let PlaceArea = PlaceAreaTF.text else{return}
    guard let PlaceAddress = PlaceAddressTF.text else{return}
    guard let PlaceName = PlaceNameTF.text else{return}
    let IndoorOrOutdoorTF = IndoorOrOutdoorTF.text == "Yes" ? true : false
    guard let PlaceType = PlaceTypeTF.text else{return}

    guard let Id = PlaceId else{return}
    guard let url = defaults.string(forKey: "API") else{return}
    guard let token = defaults.string(forKey: "JWT") else{return}
    let api = "\(url + UpdatePlaceDetails)"

    guard let SqlId = LaunchScreen.User?.SqlId else{return}
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                     "SqlId": SqlId,
                                     "Platform": "I",
                                     "Id": Id,
                                     "Area": (PlaceArea as NSString).integerValue,
                                     "Address": PlaceAddress,
                                     "Name": PlaceName,
                                     "Indoor": IndoorOrOutdoorTF,
                                     "Type": PlaceType,
                                     "Photo": self.UploadImage]

    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.ProgressHud.endRefreshing("Success Update Place", .success) {
    self.images.removeAll()
    self.UploadImage.removeAll()
    NotificationCenter.default.post(name: AddNewPlaceVC.PostPlace, object: nil)
    }
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.images.removeAll()
    self.UploadImage.removeAll()
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.AddAndUpdatePlace)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }

    }
    }
    
    @objc func IfIsUpdatePlace() {
    if let Id = PlaceId {
        
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + GetPlaceDetails)"

    guard let token = defaults.string(forKey: "JWT") else{return}
    guard let SqlId = LaunchScreen.User?.SqlId else{return}

    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                     "SqlId": SqlId,
                                     "Platform": "I",
                                     "PlaceId" : Id]
        
    self.ProgressHud.beginRefreshing()

    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.SetUpData(MyPlacesDetails(dictionary: data))
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.IfIsUpdatePlace)}
    }else{
    self.ProgressHud.endRefreshing() {}
    }
    }
    }
    }
    
    func SetUpData(_ data:MyPlacesDetails) {
    if let Area = data.Area {
    PlaceAreaTF.text = "\(Area)"
    }
        
    if let Indoor = data.Indoor {
    IndoorOrOutdoorTF.text = Indoor ? "Yes":"No"
    }
            
    PlaceAddressTF.text = data.Address
    PlaceNameTF.text = data.Name
    PlaceTypeTF.text = data.type

    for item in data.Photo {
    if let Path = item.PhotoPath {
    SDWebImageManager.shared.loadImage(
    with: URL(string: Path),
    options: .highPriority,
    progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
        
    self.imagesUrl.append(Path)
    self.imageArray.append(MyPlacesImage(Path: "PhotoPath", Image: image ?? UIImage(), islocal: false))
    self.CollectionView.reloadData()
    }
    }
    }
        
    self.ProgressHud.endRefreshing() {}
    }
    

}


