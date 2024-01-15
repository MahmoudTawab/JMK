//
//  MenuHasSubVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 16/08/2021.
//

import UIKit

class MenuHasSubVC: ViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

//    var type : String?
    var MenuData : Menu?
    var SubPackagesController : MenuSubObject?
    let MenuHasSubCellID = "CellID"
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds

        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))

        view.addSubview(ShoppingButton)
        ShoppingButton.frame = CGRect(x: view.frame.maxX - ControlX(55), y: ControlY(35), width: ControlWidth(38), height: ControlWidth(38))

        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))

        ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSubPackagesNone), for: .touchUpInside)
        
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
        vc.register(MenuHasSubCell.self, forCellWithReuseIdentifier: MenuHasSubCellID)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlX(15), bottom: ControlY(20), right: ControlX(15))
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SubPackagesController?.SubCategory.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuHasSubCellID, for: indexPath) as! MenuHasSubCell
        cell.LabelTitle.text = SubPackagesController?.SubCategory[indexPath.item].Name
        cell.ImageView.sd_setImage(with: URL(string: SubPackagesController?.SubCategory[indexPath.item].Icon ?? ""))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ControlWidth(167), height: ControlWidth(177))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlHeight(15)
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = SubPackagesController?.SubCategory[indexPath.item] {
        self.GetSubPackages(data, true)
        }
    }

    @objc func GetSubPackagesNone() {
    if let data = MenuData {
    Dismiss.TextDismiss = data.Name ?? "Menu Items"
    self.GetSubPackages(data, false)
    }
    }


    func GetSubPackages(_ data:Menu ,_ boll :Bool)  {
        let Name = data.Name ?? "Menu Items"
        guard let HasSub = data.HasSub else{return}
//        guard let PackageId = data.PackageId else{return}

        if HasSub {

        if boll {
        let Instance = MenuHasSubInstanceVC()
        Instance.MenuDataInstance = data
        Instance.DismissInstance.TextDismiss = Name
        Instance.GetSubPackagesNoneInstance()
        self.Present(ViewController: self, ToViewController: Instance)
        }else{
//
//        guard let url = defaults.string(forKey: "API") else{return}
//        let api = "\(url + GetSubCategory)"
//
//        let SqlId = LaunchScreen.User?.SqlId as Any
//        let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                        "Platform": "I",
//                                        "SqlId": SqlId,
//                                        "SubCategoryId" : PackageId,
//                                        "Token": "n-1viayRP1bWAF6EUelvBchx5Xbf9DRpv8_FXldSEH8"]


        self.ProgressHud.beginRefreshing()

//        PostAPI(api: api, token: nil, parameters: parameters) { _ in
//        } DictionaryData: { data in
            
        let data = [
            "SubCategory":[
                
                
                ["PackageId" : "1","Name" : "SubCategory 1","Icon" : "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_640.jpg","HasSub" : false,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[]],
                
                ["PackageId" : "2","Name" : "SubCategory 2","Icon" : "https://cdn.pixabay.com/photo/2015/01/28/20/15/rose-615282_640.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"
                           ,"SubPackages":[]
                ],
                
                ["PackageId" : "3","Name" : "SubCategory 3","Icon" : "https://img.freepik.com/photos-premium/il-y-rose-gouttelettes-eau-dessus-au-soleil-ai-generative_958138-6180.jpg","HasSub" : true,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[
                ["PackageId" : "3","Name" : "Test 1","Icon" : "https://img.freepik.com/photos-premium/belle-rose-eau-pluie_846390-75.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 2 ","Icon" : "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_640.jpg","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 3","Icon" : "https://cdn.pixabay.com/photo/2015/01/28/20/15/rose-615282_640.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 4","Icon" : "https://img.freepik.com/photos-premium/il-y-rose-gouttelettes-eau-dessus-au-soleil-ai-generative_958138-6180.jpg","HasSub" : false,"Type" : "S","FatherId" : "1"],
                ["PackageId" : "3","Name" : "Test 5","Icon" : "https://img.freepik.com/photos-premium/fleur-rose-uhd-photo_773230-2005.jpg?w=2000","HasSub" : false,"Type" : "D","FatherId" : "1"]]
                ],
                
                ["PackageId" : "4","Name" : "SubCategory 4","Icon" : "https://img.freepik.com/photos-premium/fleur-rose-uhd-photo_773230-2005.jpg?w=2000","HasSub" : false,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[]
                ],
                
                ["PackageId" : "5","Name" : "SubCategory 5","Icon" : "https://img.freepik.com/photos-premium/belle-rose-eau-pluie_846390-75.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"
                           ,"SubPackages":[]
                ],
                
                ["PackageId" : "6","Name" : "SubCategory 6","Icon" : "https://img.freepik.com/premium-photo/frozen-magic-red-rose-snow-romantic-background_88188-2965.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1702598400&semt=ais","HasSub" : false,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[]
                ],
                
                ["PackageId" : "7","Name" : "SubCategory 7","Icon" : "https://img.freepik.com/premium-photo/photo-frozen-magic-red-rose-snow-romantic-background_939992-523.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"
                           ,"SubPackages":[]
                ],
                
                ["PackageId" : "8","Name" : "SubCategory 8","Icon" : "https://img.freepik.com/premium-photo/frozen-magic-red-rose-snow-romantic-background-ai-generation_976564-463.jpg","HasSub" : false,"Type" : "S","FatherId" : "1"
                           ,"SubPackages":[]
                ]
                         
        ]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.SubPackagesController = MenuSubObject(dictionary: data)
            self.CollectionView.AnimateCollection()
                
            self.CollectionView.isHidden = self.SubPackagesController?.SubCategory.count == 0 ? false:true
            self.ViewNoData.isHidden = self.SubPackagesController?.SubCategory.count == 0 ? false:true
            self.ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSubPackagesNone), for: .touchUpInside)
            self.ProgressHud.endRefreshing() {}
                
//            LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate:self.SubPackagesController?.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
        }

//        } ArrayOfDictionary: { _ in
//        } Err: { error in
//        if  error != "" {
//        self.ViewNoData.isHidden = false
//        self.CollectionView.isHidden = true
//        self.ProgressHud.endRefreshing(error, .error) {}
//        }
//        }
        }
//
        }else{
        guard let Type = data.type else{return}
        if Type == "S" {
        let MenuDataTypeS = HasSubSingleVC()
        MenuDataTypeS.MenuData = data
        self.Present(ViewController: self, ToViewController: MenuDataTypeS)
        }else{
        let MenuDataTypeM = HasSubMultipleVC()
        MenuDataTypeM.MenuData = data
        self.Present(ViewController: self, ToViewController: MenuDataTypeM)
        }
        }
    }
}


class MenuHasSubInstanceVC: MenuHasSubVC {

    var MenuDataInstance : Menu?
    var SubPackagesInstance : MenuSubObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(DismissInstance)
        DismissInstance.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(90), height: ControlHeight(50))
        GetSubPackagesNoneInstance()
    }

    lazy var DismissInstance : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismissInstance)))
        return dismiss
    }()

    @objc func ActionDismissInstance() {
    self.navigationController?.popViewController(animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SubPackagesInstance?.SubCategory.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuHasSubCellID, for: indexPath) as! MenuHasSubCell
        cell.LabelTitle.text = SubPackagesInstance?.SubCategory[indexPath.item].Name
        cell.ImageView.sd_setImage(with: URL(string: SubPackagesInstance?.SubCategory[indexPath.item].Icon ?? ""))
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = SubPackagesInstance?.SubCategory[indexPath.item] {
        self.GetSubPackagesInstance(data, true)
        }
    }

    @objc func GetSubPackagesNoneInstance() {
    if let data = MenuDataInstance {
    Dismiss.TextDismiss = data.Name ?? "Menu Items"
    self.GetSubPackagesInstance(data, false)
    }
    }


    func GetSubPackagesInstance(_ data:Menu ,_ boll :Bool)  {
        let Name = data.Name ?? "Menu Items"
        guard let HasSub = data.HasSub else{return}
//        guard let PackageId = data.PackageId else{return}

        if HasSub {
        if boll {
        let MenuHasSub = MenuHasSubVC()
        MenuHasSub.Dismiss.TextDismiss = Name
        MenuHasSub.MenuData = data
        MenuHasSub.GetSubPackagesNone()
        self.Present(ViewController: self, ToViewController: MenuHasSub)
        }else{
//        guard let url = defaults.string(forKey: "API") else{return}
//        let api = "\(url + GetSubCategory)"
//
//        let SqlId = LaunchScreen.User?.SqlId as Any
//        let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                        "Platform": "I",
//                                        "SqlId": SqlId,
//                                        "SubCategoryId" : PackageId,
//                                        "Token": "n-1viayRP1bWAF6EUelvBchx5Xbf9DRpv8_FXldSEH8"]


        self.ProgressHud.beginRefreshing()
//        PostAPI(api: api, token: nil, parameters: parameters) { _ in
//        } DictionaryData: { data in
            
            let data = [
                "SubCategory":[
                    
                    
                    ["PackageId" : "1","Name" : "SubCategory 1","Icon" : "https://previews.123rf.com/images/posinote/posinote1703/posinote170300227/73529487-red-roses-and-snow-on-wooden-background-for-wallpaper.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"
                               ,"SubPackages":[]],
                    
                    ["PackageId" : "2","Name" : "SubCategory 2","Icon" : "https://previews.123rf.com/images/valentinacarpin85/valentinacarpin851302/valentinacarpin85130200010/17855616-beatiful-red-rose-in-snow-with-crystal-heart-in-a-winter-day.jpg","HasSub" : false,"Type" : "S","FatherId" : "1"
                               ,"SubPackages":[]
                    ],
                    
                    ["PackageId" : "3","Name" : "SubCategory 3","Icon" : "https://previews.123rf.com/images/posinote/posinote1703/posinote170300227/73529487-red-roses-and-snow-on-wooden-background-for-wallpaper.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"
                               ,"SubPackages":[]
                    ],
                    
                    ["PackageId" : "4","Name" : "SubCategory 4","Icon" : "https://wallpapercave.com/wp/wp5431628.jpg","HasSub" : false,"Type" : "S","FatherId" : "1"
                               ,"SubPackages":[]
                    ],
                    
                    ["PackageId" : "5","Name" : "SubCategory 5","Icon" : "https://images.fineartamerica.com/images-medium-large-5/double-red-roses-and-ice-tina-wenger.jpg","HasSub" : false,"Type" : "D","FatherId" : "1"
                               ,"SubPackages":[]
                    ],
                    
                    ["PackageId" : "6","Name" : "SubCategory 6","Icon" : "https://img.freepik.com/premium-photo/red-roses-bushes-covered-with-snow-winter-park-green-bushes-dark-red-roses-flowers-layer-white-snow_243724-491.jpg?w=2000","HasSub" : false,"Type" : "S","FatherId" : "1"
                               ,"SubPackages":[]
                    ],
                    
                    ["PackageId" : "7","Name" : "SubCategory 7","Icon" : "https://images.squarespace-cdn.com/content/v1/59e51767ccc5c5f1c5762e04/1536844925462-BZCCVTIX78HSUDYUU7F7/winter+rose+copy.jpeg?format=1500w","HasSub" : false,"Type" : "D","FatherId" : "1"
                               ,"SubPackages":[]
                    ],
                    
                    ["PackageId" : "8","Name" : "SubCategory 8","Icon" : "https://st2.depositphotos.com/5667516/9618/i/450/depositphotos_96181062-stock-photo-rose-on-a-tree.jpg","HasSub" : false,"Type" : "S","FatherId" : "1"
                               ,"SubPackages":[]
                    ]
                             
            ]
            ]
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
                
                self.SubPackagesInstance = MenuSubObject(dictionary: data)
                self.CollectionView.AnimateCollection()
                self.ViewNoData.isHidden = self.SubPackagesInstance?.SubCategory.count == 0 ? false:true
                self.ViewNoData.RefreshButton.addTarget(self, action: #selector(self.GetSubPackagesNoneInstance), for: .touchUpInside)
                
                self.ProgressHud.endRefreshing() {}
//                LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: self.SubPackagesInstance?.Cart ?? [String:Any]()){self.UpDateShoppingHubCount()}
            }
            
//        } ArrayOfDictionary: { _ in
//        } Err: { error in
//        if  error != "" {
//        self.ViewNoData.isHidden = false
//        self.ProgressHud.endRefreshing(error, .error) {}
//        }
//        }
        }
        }else{
        guard let Type = data.type else{return}
        if Type == "S" {
        let MenuDataTypeS = HasSubSingleVC()
        MenuDataTypeS.MenuData = data
        self.Present(ViewController: self, ToViewController: MenuDataTypeS)
        }else{
        let MenuDataTypeM = HasSubMultipleVC()
        MenuDataTypeM.MenuData = data
        self.Present(ViewController: self, ToViewController: MenuDataTypeM)
        }
            
        }
    }

}


