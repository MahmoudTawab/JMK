//
//  LatestUpdatesController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 18/07/2021.
//

import UIKit
import SDWebImage

class LatestUpdatesController: ViewController ,MediaBrowserDelegate {
    
    var Id : Int?
    var UpdatesLatest : LatestUpdatesDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
    
        LodLatestUpdatesDetails()
    }
 
    fileprivate func SetUp() {
        
    view.addSubview(Dismiss)
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(30), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
    
    ViewNoData.RefreshButton.addTarget(self, action: #selector(self.LodLatestUpdatesDetails), for: .touchUpInside)
    }
    
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Latest Updates"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
        self.navigationController?.popViewController(animated: true)
    }


    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.showsVerticalScrollIndicator = false
        Scroll.bounces = true
        return Scroll
    }()
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.backgroundColor = .black
        ImageView.clipsToBounds = true
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DidSelect)))
        return ImageView
    }()
    
    @objc func DidSelect() {
        let browser = MediaBrowser(delegate: self)
        browser.enableGrid = false
        browser.title = "Latest Updates Detail"
        let nc = UINavigationController(rootViewController: browser)
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .coverVertical
        present(nc, animated: true)
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return 1
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: ImageView.image ?? UIImage())
    return photo
    }

    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1417151988, green: 0.1417151988, blue: 0.1417151988, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(16))
        return Label
    }()
    
    lazy var LabelTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
        return label
    }()


    lazy var DetailLabel : UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.numberOfLines = 0
    label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(15))
    return label
    }()

    @objc func LodLatestUpdatesDetails() {
//    guard let ID = Id else{return}
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetLastUpdateDetails)"
//        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                     "Id": "\(ID)"]
//
    self.ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: nil, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["Id" : 1,"Title" : "Test String 1","Body" : "We offer competitive remuneration and a comprehensive benefits package that includes worldwide medical insurance cover for staff and dependents, life and disability insurance, leave, benefits for contingent events, and retirement benefits. Additional benefits may be provided to international staff if they meet the eligibility criteria for the particular benefit. Initial staff appointments to ADB under a standard fixed term appointment are usually for 3 years, which may be extended or converted to regular employment given satisfactory performance and the continued need for particular skills. Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments.","Photo" : "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D","Date" : "12/23"] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            self.ViewNoData.isHidden = true
            
            self.UpdatesLatest = LatestUpdatesDetails(dictionary: data)
            self.SetUpData(self.UpdatesLatest?.Photo ?? "", self.UpdatesLatest?.Date ?? "", self.UpdatesLatest?.Title ?? "", self.UpdatesLatest?.Body ?? "")
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ProgressHud.endRefreshing() {}
//        
//    if error != "" {
//    self.ViewNoData.isHidden = false
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.LodLatestUpdatesDetails)}
//    }
//    }
    }
    
    
    func SetUpData(_ PhotoPath :String ,_ Date:String, _ Title:String ,_ Detail:String) {

    guard let TitleHeight = Title.heightWithConstrainedWidth(view.frame.width - ControlWidth(30), font: UIFont.boldSystemFont(ofSize: ControlWidth(15)), Spacing: ControlWidth(5)) else{return}
        
    guard let DetailHeight = Detail.heightWithConstrainedWidth(view.frame.width - ControlWidth(30), font: UIFont.boldSystemFont(ofSize: ControlWidth(15)), Spacing: ControlWidth(5)) else{return}
    
    ViewScroll.addSubview(ImageView)
    ViewScroll.addSubview(LabelDate)
    ViewScroll.addSubview(LabelTitle)
    ViewScroll.addSubview(DetailLabel)
    
    ImageView.frame = CGRect(x: ControlX(15), y: ControlY(10), width: view.frame.width - ControlWidth(30), height: ControlWidth(300))
        
    LabelDate.frame = CGRect(x: ControlX(15), y: ImageView.frame.maxY + ControlX(20), width: view.frame.width - ControlWidth(30), height: ControlWidth(30))
        
    LabelTitle.frame = CGRect(x: ControlX(15), y: LabelDate.frame.maxY + ControlX(10), width: view.frame.width - ControlWidth(30), height: TitleHeight)
        
    DetailLabel.frame = CGRect(x: ControlX(15), y: LabelTitle.frame.maxY, width: view.frame.width - ControlWidth(30), height: DetailHeight)
        
    // MARK: - ViewScroll contentSize height
    let contentRect: CGRect = ViewScroll.subviews.reduce(into: .zero) { rect, view in
    rect = rect.union(view.frame)
    }
    ViewScroll.contentSize = CGSize(width: view.frame.width, height: contentRect.height + ControlWidth(20))
        
        
    SDWebImageManager.shared.loadImage(
    with: URL(string: PhotoPath),
    options: .highPriority,
    progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
            
    self.ImageView.image = image
    }
          
    LabelDate.text = Date.Formatter().Formatter("MMMM dd, yyyy , HH : mm")
    LabelTitle.text = Title
    DetailLabel.text = Detail
        
    LabelTitle.spasing = ControlWidth(5)
    DetailLabel.spasing = ControlWidth(5)
        
    self.ProgressHud.endRefreshing() {}
    }

}


