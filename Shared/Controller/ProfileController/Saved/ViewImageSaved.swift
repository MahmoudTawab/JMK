//
//  ViewImageSaved.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 27/07/2021.
//

import UIKit

class ViewImageSaved: ViewController, UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout , ViewImageSavedDelegate {
     
    var Saved : SavedVC?
    var SavedFolder : Saved?
    var SavedIndex : IndexPath?
    private let ImageSavedID = "CellImageSaved"
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds

        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlX(25), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: ControlX(15), y: ControlX(90), width: view.frame.width - ControlX(30), height: view.frame.height - ControlWidth(90))
        
        CollectionView.AnimateCollection()
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
        dismiss.TextDismiss = "\(SavedFolder?.Name ?? "Saved Detalis")"
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
        vc.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        vc.dataSource = self
        vc.delegate = self
        vc.register(ViewImageSavedCell.self, forCellWithReuseIdentifier: ImageSavedID)
        return vc
    }()


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SavedFolder?.Detalis.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSavedID, for: indexPath) as! ViewImageSavedCell
        cell.Delegate = self
        cell.ImageView.setImage(urlString: SavedFolder?.Detalis[indexPath.item].Path ?? "" , placeHolderImage: UIImage(named: "group26396")) { _ in}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectIndex = indexPath
        if SavedFolder?.Detalis[indexPath.item].type?.uppercased() == "S" {
        let MenuDataTypeS = HasSubSingleDetails()
        MenuDataTypeS.SavedDetalis = self
        MenuDataTypeS.Dismiss.TextDismiss = "Saved Detalis"
        MenuDataTypeS.ItemId = SavedFolder?.Detalis[indexPath.item].Id
        self.Present(ViewController: self, ToViewController: MenuDataTypeS)
        }else{
        let MenuDataTypeM = HasSubMultipleDetails()
        MenuDataTypeM.SavedDetalis = self
        MenuDataTypeM.Dismiss.TextDismiss = "Saved Detalis"
        MenuDataTypeM.ItemId = SavedFolder?.Detalis[indexPath.item].Id
        self.Present(ViewController: self, ToViewController: MenuDataTypeM)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - ControlWidth(10)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlWidth(8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ControlHeight(8)
    }
    
    var SelectIndex = IndexPath()
    func ImageSelect(cell: ViewImageSavedCell) {
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
    guard let ItemId = SavedFolder?.Detalis[SelectIndex.item].Id else{return}
    Delete(ItemId)
    }
    
    func Delete(_ ItemId:Int) {
   
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let token = defaults.string(forKey: "JWT") else{return}
//    let api = "\(url + DeleteSavedItemFromFolder)"
//                        
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                        "SqlId": SqlId,
//                                        "Platform": "I",
//                                        "ItemId": "\(ItemId)"]

    self.ProgressHud.beginRefreshing()
                        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.SavedFolder?.Detalis.remove(at: self.SelectIndex.item)
            self.CollectionView.deleteItems(at: [self.SelectIndex])
            self.CollectionView.reloadData()
            
            if let Index = self.SavedIndex?.item , let Detalis = self.SavedFolder?.Detalis {
                self.Saved?.SavedFolderOn[Index].Detalis = Detalis
                self.Saved?.CollectionView.reloadData()
            }
            
            self.ProgressHud.endRefreshing() {self.IfNoData()}
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

    func IfNoData() {
        if self.SavedFolder?.Detalis.count == 0 {
        self.navigationController?.popViewController(animated: true)
        }
    }

}
