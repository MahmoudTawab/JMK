
//
//  HomeController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 11/07/2021.
//

import UIKit
import CoreMedia
import SDWebImage

class HomeController: ViewController {

    var Story = [IGStory]()
    var ModelData : Model?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        refresh()
        SetUp()
        LodData()
        LodStories()
        SetUpUpcomingEvent()
        ScheduledTimer()
        HowItWorksGet()
        OfferGet()
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(ScheduledTimer), userInfo: nil, repeats: true)
    }
    
    func SetUp() {
        
    view.addSubview(LogoImage)
    view.addSubview(msgButton)
    view.addSubview(ShoppingButton)
    view.addSubview(ViewScroll)
    LogoImage.frame = CGRect(x: ControlX(15), y: ControlY(40), width: ControlWidth(50), height:ControlHeight(50))

    msgButton.frame = CGRect(x: view.frame.maxX - ControlX(50), y: ControlY(45), width: ControlWidth(33), height: ControlHeight(33))

    ShoppingButton.frame = CGRect(x: msgButton.frame.minX - ControlX(50), y: ControlY(45), width: ControlWidth(38), height: ControlHeight(38))

    ViewScroll.frame = CGRect(x: 0, y: ControlX(110) , width: view.frame.width, height: view.frame.height - ControlWidth(150))

        
    // MARK: - Start collectionView View
    ViewScroll.addSubview(CollectionView)
    CollectionView.frame = CGRect(x: ControlX(15) , y: 0, width: ControlWidth(345), height: ControlWidth(80))
    NotificationCenter.default.addObserver(self, selector: #selector(StoryNumber), name: IGStoryPreviewCell.StoryNumber , object: nil)

    ViewScroll.addSubview(StartEventView)
    ViewScroll.addSubview(UpcomingEventView)
    ViewScroll.addSubview(NewInvitationView)
    ViewScroll.addSubview(HowItWorkstView)
    ViewScroll.addSubview(StackOurStoryAndFeedback)
    ViewScroll.addSubview(OfferView)
        
    ViewScroll.addSubview(LatestUpdatesLabel)
    ViewScroll.addSubview(LatestUpdatesView)
    ViewScroll.addSubview(pageControl)
        
    // MARK: - Start StartEventView View
    StartEventView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    StartEventView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    StartEventView.topAnchor.constraint(equalTo: CollectionView.bottomAnchor, constant: ControlX(15)).isActive = true
    StartEventHeightAnchor = StartEventView.heightAnchor.constraint(equalToConstant: ControlWidth(115))
    StartEventHeightAnchor?.isActive = true

    // MARK: - Start UpcomingEventView View
    UpcomingEventView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    UpcomingEventView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    UpcomingEventView.topAnchor.constraint(equalTo: StartEventView.bottomAnchor, constant: ControlX(15)).isActive = true
    UpcomingEventHeightAnchor = UpcomingEventView.heightAnchor.constraint(equalToConstant: ControlWidth(130))
    UpcomingEventHeightAnchor?.isActive = true

    // MARK: - Start NewInvitationView View
    NewInvitationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    NewInvitationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    NewInvitationBottomAnchor = NewInvitationView.topAnchor.constraint(equalTo: UpcomingEventView.bottomAnchor, constant: ControlX(15))
    NewInvitationBottomAnchor?.isActive = true
    NewInvitationHeightAnchor = NewInvitationView.heightAnchor.constraint(equalToConstant: ControlWidth(90))
    NewInvitationHeightAnchor?.isActive = true
 
    // MARK: - Start HowItWorkstView View
    HowItWorkstView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    HowItWorkstView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    HowItWorkstView.heightAnchor.constraint(equalToConstant: ControlWidth(130)).isActive = true
    HowItWorkstYAnchor = HowItWorkstView.topAnchor.constraint(equalTo: NewInvitationView.bottomAnchor, constant: ControlY(15))
    HowItWorkstYAnchor?.isActive = true

    // MARK: - Start StackVertical
    StackOurStoryAndFeedback.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    StackOurStoryAndFeedback.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    StackOurStoryAndFeedback.heightAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
    StackOurStoryAndFeedback.topAnchor.constraint(equalTo: HowItWorkstView.bottomAnchor, constant: ControlY(15)).isActive = true
        
    // MARK: - Start OfferView View
    OfferView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    OfferView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    OfferView.topAnchor.constraint(equalTo: StackOurStoryAndFeedback.bottomAnchor, constant: ControlX(15)).isActive = true
    OfferView.heightAnchor.constraint(equalToConstant: ControlWidth(130)).isActive = true
        
    // MARK: - Start EventVenues View
    LatestUpdatesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    LatestUpdatesLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    LatestUpdatesLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    LatestUpdatesLabel.topAnchor.constraint(equalTo: OfferView.bottomAnchor, constant: ControlY(15)).isActive = true
        
    LatestUpdatesView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    LatestUpdatesView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    LatestUpdatesView.topAnchor.constraint(equalTo: LatestUpdatesLabel.bottomAnchor, constant: ControlX(15)).isActive = true
    LatestUpdatesView.heightAnchor.constraint(equalToConstant: ControlWidth(240)).isActive = true
                
    pageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ControlX(15)).isActive = true
    pageControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: ControlX(-15)).isActive = true
    pageControl.topAnchor.constraint(equalTo: LatestUpdatesView.bottomAnchor, constant: ControlX(15)).isActive = true
    pageControl.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    
    // MARK: - ViewScroll contentSize height
        
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = #colorLiteral(red: 0.9211552739, green: 0.8061267138, blue: 0.8055545688, alpha: 1)
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    ViewScroll.refreshControl = refreshControl
        
    
    self.UpdateContent()
    }

    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .white
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()
    
    @objc func refresh() {
//    if defaults.string(forKey: "JWT") != nil {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let api = "\(url + GetMainScreen)"
//                      
//    guard let SqlId = LaunchScreen.User?.SqlId else{return}
//    guard let Uid = LaunchScreen.User?.Uid else{return}
//        
//    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
//                                     "Platform": "I",
//                                     "SqlId": SqlId,
//                                      "Uid": Uid]
          
    ProgressHud.beginRefreshing()
//    PostAPI(api: api, token: nil, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["user":
                        
                        ["Uid": "","SqlId": "","fName": "Mahmoud","lName": "Tawab","gender": 1,"Email": "Mahmoud@mail.com"
                                    ,"phone": "01204474410"
                                     ,"Photo": "https://pixlr.com/images/index/ai-image-generator-two.webp"
                                     ,"ReceiveNotifications": true
                                     ,"ReceiveEmail": true],
                     
                     "Stories":[
                        
                        ["Id":1,"Title":"Stories1","Icon":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSW8eNtDOIR79pMR5Mxz7G57JBaBez2bjKgTFSzuefFvnAwB4higIBIxwyHEvL5dEjXjqo&usqp=CAU"
                         
                         ,"Details":[["Id":"","MediaType":"image","Text":"Test Stories1","Path":"https://img.freepik.com/premium-photo/cartoon-character-city_777078-63812.jpg","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories1","Path":"https://img.freepik.com/photos-premium/renard-aux-yeux-verts-est-assis-dans-champ_876023-628.jpg","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                            
                            ["Id":"","MediaType":"image","Text":"Test Stories1","Path":"https://img.freepik.com/photos-premium/renard-couronne-fleurs-tete_902338-13264.jpg?w=2000","Timer":2,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"video","Text":"Test Stories1","Path":"https://player.vimeo.com/external/371817283.sd.mp4?s=56639e00db07ad3f26d837314e3da531bad01b1b&profile_id=164&oauth2_token_id=57447761","Timer":20,"CreatedIn":"23/10"]]],
                        
                        ["Id":4,"Title":"Stories1","Icon":"https://storage.googleapis.com/turbo-math.appspot.com/user-assets/gzMWmegNKSUlh64nFjBAIuqhqGr2/04-23-2023/image-to-image/image-to-image__5f419cc4305219bba97ae735b799a45d_1682284222619_1_1682284234.png"
                         
                         ,"Details":[["Id":"","MediaType":"image","Text":"Test Stories1","Path":"https://storage.googleapis.com/turbo-math.appspot.com/user-assets/gzMWmegNKSUlh64nFjBAIuqhqGr2/04-23-2023/image-to-image/image-to-image__5f419cc4305219bba97ae735b799a45d_1682284222619_1_1682284234.png","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"video","Text":"Test Stories1","Path":"https://player.vimeo.com/external/392040372.hd.mp4?s=1675468c44692b5d9eae60ac813aab887d3b4620&profile_id=174&oauth2_token_id=57447761","Timer":20,"CreatedIn":"23/10"],
                                                                                                                                                                                                            
                            ["Id":"","MediaType":"image","Text":"Test Stories1","Path":"https://storage.googleapis.com/turbo-math.appspot.com/user-assets/gzMWmegNKSUlh64nFjBAIuqhqGr2/04-23-2023/image-to-image/image-to-image__5f419cc4305219bba97ae735b799a45d_1682284222619_1_1682284234.png","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories1","Path":"https://storage.googleapis.com/turbo-math.appspot.com/user-assets/gzMWmegNKSUlh64nFjBAIuqhqGr2/04-23-2023/image-to-image/image-to-image__5f419cc4305219bba97ae735b799a45d_1682284222619_1_1682284234.png","Timer":3,"CreatedIn":"23/10"]]],
                     
                        
                        ["Id":2,"Title":"Stories2","Icon":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR6xKpr7hPko36n-AuUqc3we-vGCaVBPNcQstmn14xHgbaoPHrwJ5TcOenqxscUIun39U&usqp=CAU"
                         
                         ,"Details":[["Id":"","MediaType":"image","Text":"Test Stories2","Path":"https://theultralinx.com/.image/t_share/MTQxOTUxNzg4ODkwNDAwNDUy/212iphoneiphone-wallpaperswallpapers1jpg.jpg","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories2","Path":"https://hdqwalls.com/download/8-bit-pixel-art-city-2o-1280x2120.jpg","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                            
                            ["Id":"","MediaType":"image","Text":"Test Stories2","Path":"https://i-cdn.phonearena.com/images/articles/257597-image/boom.jpg","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories2","Path":"http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg","Timer":3,"CreatedIn":"23/10"]]],
                     
                        ["Id":3,"Title":"Stories3","Icon":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU"
                         
                         ,"Details":[["Id":"","MediaType":"image","Text":"Test Stories3","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories3","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                            
                            ["Id":"","MediaType":"image","Text":"Test Stories3","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories3","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"]]],
                     
                        ["Id":5,"Title":"Stories5","Icon":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU"
                         
                         ,"Details":[["Id":"","MediaType":"image","Text":"Test Stories5","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories5","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                            
                            ["Id":"","MediaType":"image","Text":"Test Stories5","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories5","Path":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1j5rUi3m3NTevHGvmEEqW2HUN08LkjvUv_Gwfw_2QyBSBsu7iKb29ySE-1ci-dPgVZW4&usqp=CAU","Timer":3,"CreatedIn":"23/10"]]],
                     
                        ["Id":6,"Title":"Stories6","Icon":"https://slp-statics.astockcdn.net/static_assets/staging/24winter/home/curated-collections/card-2.jpg?width=580"
                         
                         ,"Details":[["Id":"","MediaType":"image","Text":"Test Stories6","Path":"https://slp-statics.astockcdn.net/static_assets/staging/24winter/home/curated-collections/card-2.jpg?width=580","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                
                            ["Id":"","MediaType":"image","Text":"Test Stories6","Path":"https://slp-statics.astockcdn.net/static_assets/staging/24winter/home/curated-collections/card-2.jpg?width=580","Timer":3,"CreatedIn":"23/10"],
                                                                                                                                                                                                            
                            ["Id":"","MediaType":"image","Text":"Test Stories6","Path":"https://slp-statics.astockcdn.net/static_assets/staging/24winter/home/curated-collections/card-2.jpg?width=580","Timer":3,"CreatedIn":"23/10"]]]],
                     
                     "UpcomingEvent":["Id" : 1,"Title" : "Test String","Date" : "2024-01-29T05:10:30","ServerTime" : "2024-01-23T10:30:00"],
                     
                     
                     "LatestUpdates":[["Id" : 1,"Title" : "Test String 1","Body" : "Test Body String","Photo" : "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D","Date" : "12/23"],
                        ["Id" : 1,"Title" : "Test String 2","Body" : "Test Body String","Photo" : "https://miro.medium.com/v2/resize:fit:1024/1*T505OJvjtLwCa8soWr_zRw.jpeg","Date" : "11/23"],
                        ["Id" : 1,"Title" : "Test String 3","Body" : "Test Body String","Photo" : "https://images.pexels.com/photos/1545980/pexels-photo-1545980.jpeg","Date" : "10/23"]],
                     
                     "HowItWorks": ["id" : "","title" : "Test Title 1","body" : "Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments.","icon" : "https://cdn-icons-png.flaticon.com/512/3417/3417915.png"]
                     
                     ,"WhatWeOffer":["id" : "","title" : "Test Title 1","body" : "We offer competitive remuneration and a comprehensive benefits package that includes worldwide medical insurance cover for staff and dependents, life and disability insurance, leave, benefits for contingent events, and retirement benefits. Additional benefits may be provided to international staff if they meet the eligibility criteria for the particular benefit. Initial staff appointments to ADB under a standard fixed term appointment are usually for 3 years, which may be extended or converted to regular employment given satisfactory performance and the continued need for particular skills. Other types of appointments such as the fixed term appointment for International Staff at Levels 7 to 10, and special fixed term appointment are not converted to regular appointments."]
        
        ] as [String : Any]
        
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
    self.ModelData = Model(dictionary: data)
    self.ViewScroll.refreshControl?.endRefreshing()
        LaunchScreen.LoadingSaveData(UserUpdate: nil, CartUpdate: nil){}
        self.ProgressHud.endRefreshing() {}
    }
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ViewScroll.refreshControl?.endRefreshing()
//    if error != "" {
//    self.ProgressHud.endRefreshing() {ShowMessageAlert("𝗶", "Error", error, false, self.refresh)}
//    }else{
//    self.ProgressHud.endRefreshing() {}
//    }
//    }
//    }
    }

    lazy var LogoImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "logo")
        ImageView.MotionEffect()
        return ImageView
    }()

    lazy var msgButton: UIImageView = {
        let button = UIImageView()
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.image = UIImage(named: "Group 31783")?.withInset(UIEdgeInsets(top: ControlY(2), left: ControlX(2), bottom: ControlY(2), right: ControlX(2)))
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionMsg)))
        return button
    }()
    
    
    @objc func ActionMsg() {
    let phone = defaults.string(forKey: "WhatsApp") ?? ""
    guard let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phone)&text=_Good%20Job%20Tawab_") else {return}
    if UIApplication.shared.canOpenURL(whatsappURL) {
    if #available(iOS 10.0, *) {
    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
    }else {
    UIApplication.shared.openURL(whatsappURL)
    }
    }
    }

    static let PresentMenu = NSNotification.Name(rawValue: "PresentMenu")
    lazy var CollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.showsHorizontalScrollIndicator = false
        vc.register(HomeStoriesCell.self, forCellWithReuseIdentifier: HomeStoriesCell.reuseIdentifier)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        return vc
    }()

    // MARK: - Start StartEventView View
    var StartEventHeightAnchor:NSLayoutConstraint?
    lazy var StartEventView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245 / 255.0, green: 240 / 255.0, blue: 237 / 255.0, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false

        View.addSubview(StartEventLabel)
        View.addSubview(TouchImage)
        View.addSubview(StartPlanning)
        NSLayoutConstraint.activate([
            StartEventLabel.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlY(4)),
            StartEventLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            StartEventLabel.widthAnchor.constraint(equalToConstant: ControlWidth(230)),
            StartEventLabel.heightAnchor.constraint(equalToConstant: ControlWidth(57.5)),

            TouchImage.centerYAnchor.constraint(equalTo: View.centerYAnchor),
            TouchImage.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlX(-15)),
            TouchImage.widthAnchor.constraint(equalToConstant: ControlWidth(48)),
            TouchImage.heightAnchor.constraint(equalToConstant: ControlWidth(68)),

            StartPlanning.topAnchor.constraint(equalTo: StartEventLabel.bottomAnchor,constant: ControlY(5)),
            StartPlanning.leftAnchor.constraint(equalTo: StartEventLabel.leftAnchor),
            StartPlanning.widthAnchor.constraint(equalToConstant: ControlWidth(115.0)),
            StartPlanning.heightAnchor.constraint(equalToConstant: ControlWidth(32)),
        ])
        
        View.addSubview(NameWeddingLabel)
        View.addSubview(ProgressView)
        View.addSubview(GoInProgress)
        NSLayoutConstraint.activate([
            NameWeddingLabel.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlY(6)),
            NameWeddingLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            NameWeddingLabel.rightAnchor.constraint(equalTo: View.rightAnchor, constant: ControlX(-40)),
            NameWeddingLabel.heightAnchor.constraint(equalToConstant: ControlWidth(57.5)),

            ProgressView.topAnchor.constraint(equalTo: NameWeddingLabel.bottomAnchor ,constant: ControlX(12)),
            ProgressView.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            ProgressView.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlX(-10)),
            ProgressView.heightAnchor.constraint(equalToConstant: ControlWidth(5)),

            GoInProgress.topAnchor.constraint(equalTo: NameWeddingLabel.topAnchor),
            GoInProgress.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlX(-5)),
            GoInProgress.widthAnchor.constraint(equalToConstant: ControlWidth(37)),
            GoInProgress.heightAnchor.constraint(equalToConstant: ControlWidth(30))
            ])
        return View
    }()


    lazy var StartEventLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlHeight(10)
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        let attributedString = NSMutableAttributedString(string: "Start your event \n", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ])
        attributedString.append(NSAttributedString(string: "Start planning and working on your event now", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(10)) ?? UIFont.systemFont(ofSize: ControlWidth(10)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ]))
        Label.numberOfLines = 2
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var TouchImage:UIImageView = {
        let IV = UIImageView()
        IV.contentMode = .scaleAspectFit
        IV.backgroundColor = .clear
        IV.image = UIImage(named: "touch")
        IV.translatesAutoresizingMaskIntoConstraints = false
        return IV
    }()

    lazy var StartPlanning : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Start Planning", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionStartPlanning), for: .touchUpInside)
        return Button
    }()

    @objc func ActionStartPlanning() {
    if defaults.string(forKey: "JWT") == nil {
    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
    }else{
    Present(ViewController: self, ToViewController: EventPlanningStep1())
    }
    }

    lazy var NameWeddingLabel : UILabel = {
        let Label = UILabel()
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    func ProgressAndNameEvent(_ Progress:Float, _ NameEvent:String) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlHeight(9)
        let attributedString = NSMutableAttributedString(string: "\(NameEvent)\n", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style

        ])
        attributedString.append(NSAttributedString(string: "In Progress  ", attributes: [
            .font: UIFont(name: "Raleway-Regular", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
            .paragraphStyle:style
        ]))

        attributedString.append(NSAttributedString(string: "( \(Progress)% )", attributes: [
            .font: UIFont(name: "Raleway-Bold", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.5) ,
            .paragraphStyle:style
        ]))
        NameWeddingLabel.numberOfLines = 2
        NameWeddingLabel.attributedText = attributedString
        NameWeddingLabel.backgroundColor = .clear
        ProgressView.setProgress(Progress / 100, animated: false)
    }

    lazy var ProgressView : UIProgressView = {
    let Prog = UIProgressView()
    Prog.tintColor = UIColor(red: 214 / 255, green: 176 / 255, blue: 156 / 255, alpha: 1)
    Prog.trackTintColor = UIColor(red: 102 / 255, green: 90 / 255, blue: 86 / 255, alpha: 1)
    Prog.translatesAutoresizingMaskIntoConstraints = false
    return Prog
    }()


    lazy var GoInProgress : UIButton = {
        let Button = UIButton(type: .system)
        let image = UIImage(named: "right-arrow")?.withInset(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        Button.setBackgroundImage(image, for: .normal)
        Button.transform = CGAffineTransform(rotationAngle: .pi)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Button.addTarget(self, action: #selector(ActionGoInProgress), for: .touchUpInside)
        return Button
    }()

    @objc func ActionGoInProgress() {
    NotificationCenter.default.post(name: HomeController.PresentMenu, object: nil)
    }


    // MARK: - Start UpcomingEventView View
    var UpcomingEventHeightAnchor:NSLayoutConstraint?
    lazy var UpcomingEventView : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = 10
        View.translatesAutoresizingMaskIntoConstraints = false
          
        let StackTop = UIStackView(arrangedSubviews: [DaysData,DaysSpace,HoursData,HoursSpace,MinutesData] )
        StackTop.axis = .horizontal
        StackTop.distribution = .fillEqually
        StackTop.alignment = .fill
        StackTop.backgroundColor = .clear
        
        let StackBottom = UIStackView(arrangedSubviews: [DaysTit,UIView(),HoursTit,UIView(),MinutesTit])
        StackBottom.axis = .horizontal
        StackBottom.distribution = .fillEqually
        StackBottom.alignment = .fill
        StackBottom.backgroundColor = .clear
        
        let Stack = UIStackView(arrangedSubviews: [StackTop,StackBottom])
        Stack.axis = .vertical
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false

        let Viewborder = UIView()
        Viewborder.layer.borderColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0).cgColor
        Viewborder.layer.borderWidth = ControlHeight(1)
        Viewborder.backgroundColor = .clear
        Viewborder.translatesAutoresizingMaskIntoConstraints = false

        View.addSubview(UpcomingEventLabel)
        View.addSubview(Viewborder)
        Viewborder.addSubview(Stack)

        NSLayoutConstraint.activate([
            UpcomingEventLabel.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlY(10)),
            UpcomingEventLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            UpcomingEventLabel.rightAnchor.constraint(equalTo: View.rightAnchor, constant: ControlX(-10)),
            UpcomingEventLabel.heightAnchor.constraint(equalToConstant: ControlWidth(25)),

            Viewborder.topAnchor.constraint(equalTo: UpcomingEventLabel.bottomAnchor ,constant: ControlY(5)),
            Viewborder.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            Viewborder.rightAnchor.constraint(equalTo: View.rightAnchor, constant: ControlX(-10)),
            Viewborder.bottomAnchor.constraint(equalTo: View.bottomAnchor, constant: ControlY(-15)),

            Stack.topAnchor.constraint(equalTo: Viewborder.topAnchor , constant: ControlY(8)),
            Stack.leftAnchor.constraint(equalTo: Viewborder.leftAnchor, constant: ControlX(40)),
            Stack.rightAnchor.constraint(equalTo: Viewborder.rightAnchor, constant: ControlX(-40)),
            Stack.bottomAnchor.constraint(equalTo: Viewborder.bottomAnchor, constant: ControlY(-8)),
        ])
        return View
    }()

    lazy var UpcomingEventLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var DaysTit : UILabel = {
        let Label = UILabel()
        Label.text = "Days"
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(13))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var DaysData : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(24))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var DaysSpace : UILabel = {
        let Label = UILabel()
        Label.text = ":"
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(24))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var HoursTit : UILabel = {
        let Label = UILabel()
        Label.text = "Hours"
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(13))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var HoursData : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(24))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var HoursSpace : UILabel = {
        let Label = UILabel()
        Label.text = ":"
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(24))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var MinutesTit : UILabel = {
        let Label = UILabel()
        Label.text = "Minutes"
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Regular", size: ControlWidth(13))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
        
    lazy var MinutesData : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(24))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    var timer = Timer()
    var EventUpcoming : UpcomingEvent?
    func SetUpUpcomingEvent() {
    if let data = defaults.object(forKey: "UpcomingEvent") as? Data {
    guard let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:Any]  else{return}
    UpcomingEventHeightAnchor?.constant = ControlWidth(130)
    NewInvitationBottomAnchor?.constant = ControlY(15)
    EventUpcoming = UpcomingEvent(dictionary: decodedPeople)
    guard let Title = EventUpcoming?.Title else{return}
            
    let attributedString = NSMutableAttributedString(string: "Upcoming Event:  ", attributes: [
    .font: UIFont(name: "Raleway-Bold", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
    .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
    ])
            
    attributedString.append(NSAttributedString(string: "\(Title)", attributes: [
    .font: UIFont(name: "Raleway-Regular", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
    .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
    ]))
    UpcomingEventLabel.attributedText = attributedString
    }else{
    UpcomingEventHeightAnchor?.constant = 0
    NewInvitationBottomAnchor?.constant = 0
    }
    view.layoutIfNeeded()
    }
    
    
    @objc func ScheduledTimer() {
    guard let Date = EventUpcoming?.Date else{return}
    guard let ServerTime = EventUpcoming?.ServerTime else{return}
        
    let currentDate = Date.Formatter().Formatter("yyyy-MM-dd HH:mm")
    let previousDate = ServerTime.Formatter().Formatter("yyyy-MM-dd HH:mm")
    timeGapBetweenDates(previousDate: previousDate, currentDate: currentDate)
    }

    @objc func timeGapBetweenDates(previousDate : String,currentDate : String) {
        let dateString1 = previousDate
        let dateString2 = currentDate

        let Dateformatter = DateFormatter()
        Dateformatter.dateFormat = "yyyy-MM-dd HH:mm"

        let date1 = Dateformatter.date(from: dateString1)
        let date2 = Dateformatter.date(from: dateString2)
        
        if let distanceBetweenDates: TimeInterval = date2?.timeIntervalSince(date1!) {
        let days = Int(distanceBetweenDates / 86400)
        let Hour = Int(distanceBetweenDates / 3600)-Int(days*24)
        let Min = Int(distanceBetweenDates / 60)-Int(Hour*60)-Int(days*24*60)
            
        DaysData.text = "\(days)"
        HoursData.text = "\(Hour)"
        MinutesData.text = "\(Min)"
            
        if days == 0 && Hour == 0 && Min == 0 {
        timer.invalidate()
        }
        }
    }
    

    // MARK: - Start NewInvitation View
    var NewInvitationHeightAnchor:NSLayoutConstraint?
    var NewInvitationBottomAnchor:NSLayoutConstraint?
    lazy var NewInvitationView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245 / 255, green: 240 / 255, blue:237 / 255, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false

        let StackVertical = UIStackView(arrangedSubviews: [InvitationName,ButtonNo,ButtonYes])
        StackVertical.axis = .horizontal
        StackVertical.spacing = ControlHeight(10)
        StackVertical.distribution = .fill
        StackVertical.alignment = .fill
        StackVertical.backgroundColor = .clear
        StackVertical.translatesAutoresizingMaskIntoConstraints = false

        View.addSubview(NewInvitationLabel)
        View.addSubview(StackVertical)
        View.addSubview(CloseInvitation)
        NSLayoutConstraint.activate([
            NewInvitationLabel.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlY(5)),
            NewInvitationLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            NewInvitationLabel.rightAnchor.constraint(equalTo: View.rightAnchor, constant: ControlX(-40)),
            NewInvitationLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30.5)),

            StackVertical.arrangedSubviews[1].widthAnchor.constraint(equalToConstant: ControlWidth(65.5)),
            StackVertical.arrangedSubviews[2].widthAnchor.constraint(equalToConstant: ControlWidth(65.5)),
            StackVertical.topAnchor.constraint(equalTo: NewInvitationLabel.bottomAnchor ,constant: ControlY(5)),
            StackVertical.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            StackVertical.widthAnchor.constraint(equalTo: NewInvitationLabel.widthAnchor),
            StackVertical.heightAnchor.constraint(equalTo: NewInvitationLabel.heightAnchor),

            CloseInvitation.centerYAnchor.constraint(equalTo: NewInvitationLabel.centerYAnchor),
            CloseInvitation.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlX(-2)),
            CloseInvitation.widthAnchor.constraint(equalToConstant: ControlWidth(22)),
            CloseInvitation.heightAnchor.constraint(equalTo: CloseInvitation.widthAnchor)
        ])
            
        return View
    }()

    lazy var NewInvitationLabel : UILabel = {
        let Label = UILabel()
        Label.text = "You have a new pending invitation"
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(15))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var InvitationName : UILabel = {
        let Label = UILabel()
        Label.text = "Sarah & Emad Wedding"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(13))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var ButtonNo : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("No", for: .normal)
        Button.backgroundColor = .clear
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(12))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.layer.borderColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0).cgColor
        Button.layer.borderWidth = ControlHeight(1)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionNo), for: .touchUpInside)
        return Button
    }()

    @objc func ActionNo() {
        CloseNewInvitation()
    }

    lazy var ButtonYes : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Yes", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionYes), for: .touchUpInside)
        return Button
    }()

    @objc func ActionYes() {
        CloseNewInvitation()
    }

    lazy var CloseInvitation : UIButton = {
        let Button = UIButton(type: .system)
        let Image = UIImage(named: "ic_close")?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setBackgroundImage(Image, for: .normal)
        Button.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Button.addTarget(self, action: #selector(ActionCloseInvitation), for: .touchUpInside)
        return Button
    }()

    @objc func ActionCloseInvitation() {
        CloseNewInvitation()
    }
    
    
    func CloseNewInvitation() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: []) {
        self.NewInvitationView.alpha = 0
        self.HowItWorkstYAnchor?.constant = 0
        self.NewInvitationHeightAnchor?.constant = 0
        self.UpdateContent()
        }
    }
    
    func ShowNewInvitation() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: []) {
        self.NewInvitationView.alpha = 1
        self.HowItWorkstYAnchor?.constant = ControlY(15)
        self.NewInvitationHeightAnchor?.constant = ControlWidth(85)
        self.UpdateContent()
        }
    }
    
    func UpdateContent() {
    self.ViewScroll.updateContentViewSize(ControlWidth(30))
    self.view.layoutIfNeeded()
    }

    // MARK: - Start HowItWorkstView View
    var HowItWorkstYAnchor:NSLayoutConstraint?
    lazy var HowItWorkstView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245 / 255, green: 240 / 255, blue:237 / 255, alpha: 1)
        View.isUserInteractionEnabled = true
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionMoreWorkst)))

        View.addSubview(HowItWorkstLabel)
        View.addSubview(HowItWorkstImage)
        View.addSubview(ViewMoreWorkst)
        NSLayoutConstraint.activate([
            HowItWorkstLabel.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlY(10)),
            HowItWorkstLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            HowItWorkstLabel.widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: ControlWidth(1/1.5)),
            HowItWorkstLabel.bottomAnchor.constraint(equalTo: View.bottomAnchor ,constant: ControlY(-40)),

            HowItWorkstImage.centerYAnchor.constraint(equalTo: View.centerYAnchor),
            HowItWorkstImage.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlX(-15)),
            HowItWorkstImage.widthAnchor.constraint(equalToConstant: ControlWidth(44)),
            HowItWorkstImage.heightAnchor.constraint(equalToConstant: ControlWidth(44)),

            ViewMoreWorkst.topAnchor.constraint(equalTo: HowItWorkstLabel.bottomAnchor,constant: ControlY(10)),
            ViewMoreWorkst.leftAnchor.constraint(equalTo: HowItWorkstLabel.leftAnchor),
            ViewMoreWorkst.rightAnchor.constraint(equalTo: HowItWorkstLabel.rightAnchor),
            ViewMoreWorkst.bottomAnchor.constraint(equalTo: View.bottomAnchor , constant: ControlY(-15)),
        ])
        return View
    }()

    var HowItWorksData : HowItWorks?
    lazy var HowItWorkstLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 4
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var HowItWorkstImage:UIImageView = {
        let IV = UIImageView()
        IV.contentMode = .scaleAspectFit
        IV.backgroundColor = .clear
        IV.translatesAutoresizingMaskIntoConstraints = false
        return IV
    }()

    lazy var ViewMoreWorkst : UIButton = {
        let Button = UIButton(type: .system)
        Button.setImage(UIImage(named: "right-arrow"), for: .normal)
        Button.imageView?.contentMode = .scaleAspectFit
        Button.setTitle("View more  ", for: .normal)
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .left
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
        Button.semanticContentAttribute = .forceRightToLeft
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionMoreWorkst), for: .touchUpInside)
        Button.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Button.setTitleColor(UIColor(red:99 / 255, green:87 / 255, blue:82 / 255, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionMoreWorkst() {
    Present(ViewController: self, ToViewController: HowItWorksController())
    }
    
    @objc func HowItWorksGet() {
    if let data = defaults.object(forKey: "HowItWorks") as? Data {
    if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:Any] {
    HowItWorksData = HowItWorks(dictionary: decodedPeople)
    SetDataHowItWorks()
    }
    }
    }

    func SetDataHowItWorks() {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = ControlHeight(10)
    let styleAppend = NSMutableParagraphStyle()
    styleAppend.lineSpacing = ControlHeight(7)
    let body = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut. "
        let attributedString = NSMutableAttributedString(string: "\(HowItWorksData?.title ?? "How it works")? \n", attributes: [
    .font: UIFont(name: "Raleway-Bold", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
    .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
    .paragraphStyle:style
    ])
    attributedString.append(NSAttributedString(string: "\(HowItWorksData?.body ?? body)" , attributes: [
    .font: UIFont(name: "Raleway-Regular", size: ControlWidth(11)) ?? UIFont.systemFont(ofSize: ControlWidth(11)),
    .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
    .paragraphStyle:styleAppend
    ]))
    HowItWorkstLabel.attributedText = attributedString
        
    if let icon = HowItWorksData?.icon {
    HowItWorkstImage.sd_setImage(with: URL(string: icon))
    }
    }

    // MARK: - Start StackVertical OurStoryView And TestimonialsView
    lazy var StackOurStoryAndFeedback : UIView = {
    let StackVertical = UIStackView(arrangedSubviews: [OurStoryView,TestimonialsView])
    StackVertical.axis = .horizontal
    StackVertical.spacing = ControlHeight(10)
    StackVertical.distribution = .fillEqually
    StackVertical.alignment = .fill
    StackVertical.backgroundColor = .clear
    StackVertical.translatesAutoresizingMaskIntoConstraints = false
    return StackVertical
    }()

    // MARK: - Start OurStoryView View
    lazy var OurStoryView : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = 10
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionOurStory)))

        View.addSubview(OurStoryImage)
        View.addSubview(OurStoryLabel)
        NSLayoutConstraint.activate([
            OurStoryImage.topAnchor.constraint(equalTo: View.topAnchor),
            OurStoryImage.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            OurStoryImage.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlX(-10)),
            OurStoryImage.bottomAnchor.constraint(equalTo: View.bottomAnchor,constant: ControlY(-20)),

            OurStoryLabel.heightAnchor.constraint(equalToConstant: ControlWidth(25)),
            OurStoryLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            OurStoryLabel.rightAnchor.constraint(equalTo: View.rightAnchor),
            OurStoryLabel.bottomAnchor.constraint(equalTo: View.bottomAnchor,constant: ControlY(-5))
        ])
        return View
    }()

    @objc func ActionOurStory() {
    Present(ViewController: self, ToViewController: OurStoryController())
    }

    lazy var OurStoryLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Our story"
        Label.font = UIFont(name: "Raleway-Medium" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 155 / 255, green: 155 / 255, blue: 155 / 255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()


    lazy var OurStoryImage:UIImageView = {
        let IV = UIImageView()
        IV.backgroundColor = .clear
        IV.contentMode = .scaleAspectFit
        IV.image = UIImage(named: "OurStory")
        IV.translatesAutoresizingMaskIntoConstraints = false
        return IV
    }()


    // MARK: - Start TestimonialsView View
    lazy var TestimonialsView : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = 10
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionTestimonials)))

        View.addSubview(TestimonialsImage)
        View.addSubview(TestimonialsLabel)
        NSLayoutConstraint.activate([
            TestimonialsImage.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlY(20)),
            TestimonialsImage.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            TestimonialsImage.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlX(-10)),
            TestimonialsImage.bottomAnchor.constraint(equalTo: View.bottomAnchor , constant: ControlY(-5)),

            TestimonialsLabel.heightAnchor.constraint(equalToConstant: ControlWidth(25)),
            TestimonialsLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            TestimonialsLabel.rightAnchor.constraint(equalTo: View.rightAnchor),
            TestimonialsLabel.topAnchor.constraint(equalTo: View.topAnchor,constant: ControlY(5))
        ])
        return View
    }()

    @objc func ActionTestimonials() {
    Present(ViewController: self, ToViewController: TestimonialsController())
    }

    lazy var TestimonialsLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Feedback"
        Label.font = UIFont(name: "Raleway-Medium" ,size: ControlWidth(16))
        Label.textColor = UIColor(red: 155 / 255, green: 155 / 255, blue: 155 / 255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()


    lazy var TestimonialsImage:UIImageView = {
        let IV = UIImageView()
        IV.contentMode = .scaleAspectFit
        IV.backgroundColor = .clear
        IV.image = UIImage(named: "Testimonials")
        IV.translatesAutoresizingMaskIntoConstraints = false
        return IV
    }()


    // MARK: - Start OfferView View
    lazy var OfferView : UIView = {
        let View = UIView()
        View.backgroundColor = UIColor(red: 245 / 255, green: 240 / 255, blue:237 / 255, alpha: 1)
        View.isUserInteractionEnabled = true
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionOffer)))
        
        View.addSubview(OfferLabel)
        View.addSubview(OfferImage)
        View.addSubview(ViewMoreOffer)
        NSLayoutConstraint.activate([
            OfferLabel.topAnchor.constraint(equalTo: View.topAnchor ,constant: ControlY(10)),
            OfferLabel.leftAnchor.constraint(equalTo: View.leftAnchor,constant: ControlX(10)),
            OfferLabel.widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: ControlWidth(1/1.5)),
            OfferLabel.bottomAnchor.constraint(equalTo: View.bottomAnchor ,constant: ControlY(-40)),

            OfferImage.centerYAnchor.constraint(equalTo: View.centerYAnchor),
            OfferImage.rightAnchor.constraint(equalTo: View.rightAnchor,constant: ControlY(-15)),
            OfferImage.widthAnchor.constraint(equalToConstant: ControlWidth(44)),
            OfferImage.heightAnchor.constraint(equalToConstant: ControlWidth(44)),

            ViewMoreOffer.topAnchor.constraint(equalTo: OfferLabel.bottomAnchor,constant: ControlY(10)),
            ViewMoreOffer.leftAnchor.constraint(equalTo: OfferLabel.leftAnchor),
            ViewMoreOffer.rightAnchor.constraint(equalTo: OfferLabel.rightAnchor),
            ViewMoreOffer.bottomAnchor.constraint(equalTo: View.bottomAnchor , constant: ControlY(-15)),
        ])
        return View
    }()

    var OfferData : WhatWeOffer?
    lazy var OfferLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 4
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var OfferImage:UIImageView = {
        let IV = UIImageView()
        IV.backgroundColor = .clear
        IV.image = UIImage(named: "gift")
        IV.contentMode = .scaleAspectFit
        IV.translatesAutoresizingMaskIntoConstraints = false
        return IV
    }()
    
    lazy var ViewMoreOffer : UIButton = {
        let Button = UIButton(type: .system)
        Button.setImage(UIImage(named: "right-arrow"), for: .normal)
        Button.imageView?.contentMode = .scaleAspectFit
        Button.setTitle("View more  ", for: .normal)
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .left
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(15))
        Button.semanticContentAttribute = .forceRightToLeft
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionOffer), for: .touchUpInside)
        Button.tintColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Button.setTitleColor(UIColor(red:99 / 255, green:87 / 255, blue:82 / 255, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionOffer() {
    let Offer = OfferController()
    Offer.Offer = OfferData
    Present(ViewController: self, ToViewController: Offer)
    }
    

    @objc func OfferGet() {
    if let data = defaults.object(forKey: "WhatWeOffer") as? Data {
    if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:Any] {
    OfferData = WhatWeOffer(dictionary: decodedPeople)
    SetDataOffer()
    }
    }
    }

    func SetDataOffer() {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = ControlHeight(10)
    let styleAppend = NSMutableParagraphStyle()
    styleAppend.lineSpacing = ControlHeight(7)
    let body = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut. "
    let attributedString = NSMutableAttributedString(string: "\(OfferData?.title ?? "What do we offer")? \n", attributes: [
    .font: UIFont(name: "Raleway-Bold", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
    .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
    .paragraphStyle:style
    ])
    attributedString.append(NSAttributedString(string: OfferData?.body ?? body , attributes: [
    .font: UIFont(name: "Raleway-Regular", size: ControlWidth(11)) ?? UIFont.systemFont(ofSize: ControlWidth(11)),
    .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1) ,
    .paragraphStyle:styleAppend
    ]))
    OfferLabel.attributedText = attributedString
    }

    // MARK: - Start Latest Updates View
    lazy var LatestUpdatesLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Latest Updates"
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(17))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    let collectionMargin = ControlWidth(16)
    let itemSpacing = ControlWidth(10)
    let itemHeight = ControlWidth(240)
    var itemWidth = CGFloat(0)
    
    lazy var LatestUpdatesView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.delegate = self
        vc.dataSource = self
        vc.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        vc.collectionViewLayout = layout
        vc.showsHorizontalScrollIndicator = false
        vc.decelerationRate = UIScrollView.DecelerationRate.fast
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(LatestUpdatesCell.self, forCellWithReuseIdentifier: "EventCell")
        return vc
    }()

    lazy var pageControl:CHIPageControlPuya = {
        let pc = CHIPageControlPuya(frame: CGRect(x: 0, y:0, width: 100, height: 10))
        pc.delegate = self
        pc.tintColor = .black
        pc.enableTouchEvents = true
        pc.backgroundColor = .white
        pc.currentPageTintColor = #colorLiteral(red: 0.8610321879, green: 0.7267792821, blue: 0.6523330212, alpha: 1)
        pc.radius = ControlWidth(5)
        pc.padding = ControlWidth(10)
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.transform = CGAffineTransform(scaleX: ControlWidth(1), y: ControlWidth(1))
        return pc
    }()

    var UpdatesLatest = [LatestUpdates]()
    func LodData() {
    if let data = defaults.object(forKey: "LatestUpdates") as? Data {
    if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[String:Any]] {

    UpdatesLatest.removeAll()
    for data in decodedPeople {
    UpdatesLatest.append(LatestUpdates(dictionary: data))
    pageControl.numberOfPages = UpdatesLatest.count
    LatestUpdatesView.reloadData()
    }
    }
    }
        
        
    let Progress = Float(LaunchScreen.Cart?.CompletedRat ?? 0)
    let NameEvent = LaunchScreen.Cart?.Title ?? ""
    self.ProgressAndNameEvent(Progress, "Name Event")
            
    self.StartEventHeightAnchor?.constant = Progress == 0 ? ControlWidth(115) : ControlWidth(95)
    self.StartEventLabel.alpha = Progress == 0 ? 1 : 0
    self.TouchImage.alpha = Progress == 0 ? 1 : 0
    self.StartPlanning.alpha = Progress == 0 ? 1 : 0

    self.NameWeddingLabel.alpha = Progress == 0 ? 0 : 1
    self.ProgressView.alpha = Progress == 0 ? 0 : 1
    self.GoInProgress.alpha = Progress == 0 ? 0 : 1
    
    self.view.layoutIfNeeded()
    }

}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , CHIBasePageControlDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == LatestUpdatesView {
        return UpdatesLatest.count
        }else{
        return Story.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == LatestUpdatesView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell",for: indexPath) as! LatestUpdatesCell
        cell.ImageView.sd_setImage(with: URL(string: UpdatesLatest[indexPath.item].Photo ?? ""), placeholderImage: UIImage(named: "group26396"))
        cell.LabelTitle.text = UpdatesLatest[indexPath.item].Title
        cell.LabelDate.text = UpdatesLatest[indexPath.item].Date?.Formatter().Formatter("MMMM dd, yyyy , HH : mm")
        cell.LabelTitle.spasing = ControlHeight(5)
            
        return cell
        }else{
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoriesCell.reuseIdentifier,for: indexPath) as! HomeStoriesCell
        
        let decoded = Story[indexPath.row]
        cell.StoryLabel.text = decoded.Title
        cell.ImageView.setImage(urlString: decoded.Icon, placeHolderImage: UIImage(named: "group26396")?.withInset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))) { _ in}
            
        if indexPath.item == 0 {
        cell.gradient.colors = [#colorLiteral(red: 0.9215835929, green: 0.9215835929, blue: 0.9215835929, alpha: 1).cgColor, #colorLiteral(red: 0.9215835929, green: 0.9215835929, blue: 0.9215835929, alpha: 1).cgColor]
        }else{
        cell.gradient.colors = [#colorLiteral(red: 0.9772900939, green: 0.0192484688, blue: 0.5276048779, alpha: 1).cgColor, #colorLiteral(red: 0.5354557633, green: 0.1480901837, blue: 0.7097425461, alpha: 1).cgColor]
        }
            
        return cell
        }
    }
    
    
    func LodStories() {
        guard let data = defaults.object(forKey: "Stories") as? Data else{return}
        guard let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[String:Any]] else{return}
        
        Story.removeAll()
        for decoded in decodedPeople {
        Story.append(IGStory(dictionary: decoded))
        Story.removeAll { story in
        story._snaps.isEmpty == true
        }
            
        CollectionView.AnimateCollection()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == LatestUpdatesView {
        return CGSize(width: itemWidth, height: itemHeight)
        }else{
        return CGSize(width: ControlWidth(80), height: ControlWidth(80))
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == LatestUpdatesView {
    let LatestUpdates = LatestUpdatesController()
    LatestUpdates.Id = UpdatesLatest[indexPath.item].Id
    Present(ViewController: self, ToViewController: LatestUpdates)
    }else{
        
    if Reachability.isConnectedToNetwork() {
    let storyPreviewScene = IGStoryPreviewController.init(stories: Story, handPickedStoryIndex:  indexPath.row, handPickedSnapIndex: 0)
    storyPreviewScene.modalPresentationStyle = .overFullScreen
    self.present(storyPreviewScene, animated: true)
    }else{
    ProgressHud.endRefreshing("Sorry, You is Not Connected To Network internet", .error) {}
    }
        
    }
    }

    @objc func StoryNumber() {
    guard let token = defaults.string(forKey: "JWT") else{return}
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + SetViewStory)"
                

    let SqlId = LaunchScreen.User?.SqlId as Any
    let StoryId = Story[IGStoryPreviewController.nStoryIndex].internalIdentifier
    
    let parameters:[String : Any] = ["AppId": "05c10698-8d71-4ea2-aee2-f00de9d68910",
                                    "SqlId": SqlId,
                                    "Platform": "I" ,
                                    "StoryId": "\(StoryId)"]
        
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { _ in
    }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == LatestUpdatesView {
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(LatestUpdatesView.contentSize.width)
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
    }
    

    func didTouch(pager: CHIBasePageControl, index: Int) {
    pageControl.set(progress: index, animated: true)
    LatestUpdatesView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}


