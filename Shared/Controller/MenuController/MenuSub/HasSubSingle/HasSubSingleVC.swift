//
//  HasSubSingleVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 16/08/2021.
//

import UIKit

class HasSubSingleVC: ViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,HasSubSingleDelegate {
       

    var MenuData : Menu?
    private let HasSubSingleCellID = "CellEventVenues"
    var DataItems : MenuPackagesItemsObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds

        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(30), height: ControlHeight(50))
        
        view.addSubview(ShoppingButton)
        ShoppingButton.frame = CGRect(x: view.frame.maxX - ControlX(55), y: ControlY(35), width: ControlWidth(38), height: ControlWidth(38))
        
        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: ControlX(90), width: view.frame.width - ControlWidth(30), height: view.frame.height - ControlWidth(90))
        
        NotificationCenter.default.addObserver(self, selector: #selector(IsFavorite), name: SaveView.SuccessSaved , object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
        refreshControl.addTarget(self, action: #selector(GetSubPackagesItems), for: .valueChanged)
        CollectionView.refreshControl = refreshControl
        GetSubPackagesItems()
        
        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSubPackagesItems), for: .touchUpInside)
    }
    
    @objc func GetSubPackagesItems()  {
        guard let Menudata = MenuData else{return}
        guard let Name = Menudata.Name else{return}
        Dismiss.TextDismiss = Name
//        
//        let CartId = LaunchScreen.Cart?.CartId ?? 0
//        let SqlId = LaunchScreen.User?.SqlId as Any
//        guard let PackageId = data.PackageId else{return}
//        guard let url = defaults.string(forKey: "API") else{return}
//        let api = "\(url + GetCategoryItems)"
//
//
//        let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                        "Platform": "I",
//                                        "SqlId": SqlId,
//                                        "SubCategoryId":PackageId,
//                                        "CartId": "\(CartId)",
//                                        "Token": "euIA1Ug_jZk6UxKKqbUr8C06-XXxU_MejmIRSva6q6w"]

        self.ProgressHud.beginRefreshing()
//        PostAPI(api: api, token: nil, parameters: parameters) { _ in
//        } DictionaryData: { data in
        
        let data = ["Items":[
                        
            ["Id" : 1,"Name" : "Packages 1","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 70.000,"MainPhoto" : "https://www.gettyimages.com/gi-resources/images/500px/983794168.jpg","InCart" : false,"Count" : 0,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "P",
         "Gallery":[
        ["PhotoPath":"https://www.gettyimages.com/gi-resources/images/500px/983794168.jpg"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]]
        ],
        
        ["Id" : 1,"Name" : "Packages 2","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 90.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv5Dwa2Pi0SMi6zmv-ifcJZnPXR5vonEiZ0pFfNDbPvFzEte2xsjopVX30gEruxdOon3Y&usqp=CAU","InCart" : true,"Count" : 1,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "C",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv5Dwa2Pi0SMi6zmv-ifcJZnPXR5vonEiZ0pFfNDbPvFzEte2xsjopVX30gEruxdOon3Y&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]]
        ],
        
        ["Id" : 1,"Name" : "Packages 3","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 60.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU","InCart" : false,"Count" : 0,"Favorite" : false,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "A",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"]]
        ],
        
        ["Id" : 1,"Name" : "Packages 4","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 30.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU","InCart" : false,"Count" : 0,"Favorite" : true,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "P",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPVZcimdrCadEmVeVr2CZglZ_ZWBt2C_fP9bgclzU5AkJ_V8OAj1GpwTkjP_Wfjiuiabw&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE3lNVhDRrEwiqdTQwhQknaxEk9NmrjE9QBsQa6bCKPgCRz2NAP70U0mzSwFuzKXI5mY0&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ],
        
        
        ["Id" : 1,"Name" : "Packages 5","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 10.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSN6h0sqtw58awIJXftCQlkkUOB0Sh8aOb2SuShB8rEZ-pzVQqyZa8lg-3hC6HsubtR66U&usqp=CAU","InCart" : false,"Count" : 0,"Favorite" : false,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "C",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-GRnNz3EkMLRJbhkCUsTZHQagYEun3iB4yYmzDqPykosRMIFUDH9S_jXX_fzLogNmd8&usqp=CAU"]]
        ],
        
        
        ["Id" : 1,"Name" : "Packages 6","Description" : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore","Price" : 50.000,"MainPhoto" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU","InCart" : false,"Count" : 0,"Favorite" : false,"GalleryId" : 1,"Capacity" : 1,"ClassName" : "A",
         "Gallery":[
        ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtPUXGu1d7DzpNOgvwV7le7kCixOq5t2DYFQbSW--jCesbCozkL-sCNetmu8Nm6nSf19Q&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCFDiVowQuR7p2s64Whaa3VNBTOzdJICRVm4JB65umt6zUM01Px-wRpTfcARAYyvRMJco&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqh_vK3RqkWrO0hB1s9VN1Rp5NCy8WG-uWsaesYImLms6JZ969odzau7gtWdoMUuC8a4&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYrbTHSrsSDvYGjb0Ty1PLuDXy1bCCR7lMVI0lhiuy1jplRHehIXU761P8c7TitAtLruI&usqp=CAU"],
         ["PhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl42wb7bWAublLJlayoYz4aQa5J2fVOjqC6V2hfHiz7qx4prIccts3IhW7lY3HymMybg&usqp=CAU"]]
        ]
        
        ]
        ]
        
            
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.DataItems = MenuPackagesItemsObject(dictionary: data)
            self.CollectionView.AnimateCollection()
            self.CollectionView.refreshControl?.endRefreshing()
            
            self.CollectionView.isHidden = self.DataItems?.MenuItems.count != 0 ? false:true
            self.ViewNoData.isHidden = self.DataItems?.MenuItems.count == 0 ? false:true
            self.ProgressHud.endRefreshing() {}
        }
//        } ArrayOfDictionary: { _ in
//        } Err: { error in
//        self.CollectionView.refreshControl?.endRefreshing()
//        if  error != "" {
//        self.ViewNoData.isHidden = false
//        self.CollectionView.isHidden = true
//        self.ProgressHud.endRefreshing(error, .error) {}
//        }
//        }
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
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    
    @objc func ActionDismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    lazy var CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.register(HasSubSingleCell.self, forCellWithReuseIdentifier: HasSubSingleCellID)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return vc
    }()


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataItems?.MenuItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HasSubSingleCellID, for: indexPath) as! HasSubSingleCell
        
        
        if let Items = DataItems?.MenuItems[indexPath.item] {
        cell.LabelTitle.text = Items.Name
        cell.ImageView.setImage(urlString: Items.MainPhoto ?? "", placeHolderImage: UIImage(named: "group26396")) { _ in}
        cell.heart.image = Items.Favorite == false ? UIImage(named: "heart") : UIImage(named: "heartSelect")
        
        cell.ImageView.layer.borderColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1).cgColor
        cell.ImageView.layer.borderWidth = Items.InCart == true ? ControlHeight(2):0
        cell.SelectImage.alpha = Items.InCart == true ? 1:0
        cell.Delegate = self
        }
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ControlWidth(167), height: ControlWidth(177))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlWidth(15)
    }
    
    
    let ViewSave = SaveView()
    var indexSelect : IndexPath?
    func ImageSelect(cell: HasSubSingleCell) {
    if let indexPath = CollectionView.indexPath(for: cell) {
    indexSelect = indexPath
    if cell.heart.image == UIImage(named: "heart") {
    Favorite = true
    ViewSave.currentState = .open
    ViewSave.ItemId = DataItems?.MenuItems[indexPath.item].Id
    ViewSave.modalPresentationStyle = .overFullScreen
    ViewSave.modalTransitionStyle = .coverVertical
    present(ViewSave, animated: true)
    }else{
    Favorite = false
    ShowMessageAlert("𝗶", "Delete Favorite", "Do you really want to delete this item from your favourites", false, self.ActionDeleteFavorite, "Delete")
    }
    }
    }

    @objc func ActionDeleteFavorite() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + DeleteSavedItemFromFolder)"
//        
//    guard let index = indexSelect?.item else{return}
//    guard let Id = DataItems?.MenuItems[index].Id else{return}
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                    "SqlId": SqlId,
//                                    "Platform": "I",
//                                    "ItemId": "\(Id)"]

    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ProgressHud.endRefreshing("Success Delete To Favorite", .success) {self.IsFavorite()}
        }
        
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.ActionDeleteFavorite)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    indexSelect = indexPath
    let Details = HasSubSingleDetails()
    Details.HasSubSingle = self
    Details.Dismiss.TextDismiss = Dismiss.TextDismiss
    Details.ItemId = DataItems?.MenuItems[indexPath.item].Id
    Present(ViewController: self, ToViewController: Details)
    }
    
    var Favorite = Bool()
    @objc func IsFavorite() {
    if let index = indexSelect {
    DataItems?.MenuItems[index.item].Favorite = Favorite
    CollectionView.reloadItems(at: [index])
    }
    }

}

