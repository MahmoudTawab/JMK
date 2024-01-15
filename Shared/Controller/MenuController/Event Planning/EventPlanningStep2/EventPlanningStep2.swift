//
//  EventPlanningStep2.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 20/12/2021.
//

import UIKit
import SDWebImage

class EventPlanningStep2: ViewController ,UITextFieldDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(20), width: view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = CGRect(x: 0, y: view.frame.height - ControlWidth(222.5), width: ControlWidth(375), height: ControlWidth(222.5))
        
        // MARK: - Start View1
        view.addSubview(StackView)
        StackView.frame = CGRect(x: ControlX(20), y: ControlX(80), width: ControlWidth(335), height: ControlWidth(572))
        
        EventPlanningStep2.IsNight = false
        EventPlanningStep2.IsClassic = false
        
        EventPlanningStep2.ColorsId = EventPlanningStep1.EventColors[0].Id
        EventPlanningStep2.MusicId = self.Classic.Select == true ? EventPlanningStep1.EventClassic[0].Id : EventPlanningStep1.EventModern[0].Id
    }
    

    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Male")
        return ImageView
    }()
        
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Event Planning"
        dismiss.backgroundColor = .clear
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
    if NextButton.tag == 1 {
    View1.isHidden = false
    View2.isHidden = true
        
    CollectionMusic.reloadData()
    CollectionColors.reloadData()
    UIView.transition(from: View2, to: View1, duration: 0.4, options:[.transitionCrossDissolve,.showHideTransitionViews])
    NextButton.tag = 0
    }else{
    self.navigationController?.popViewController(animated: true)
    }
    }
    
    // MARK: - Start View
    lazy var StackView : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [TitleLabel,ViewStep,View1,View2,NextButton])
    Stack.axis = .vertical
    Stack.spacing = 20
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.text = "Personal Questions"
        Label.textAlignment = .center
        Label.font = UIFont(name: "Raleway-Bold" ,size: ControlWidth(18))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
            
    lazy var ViewStep : StepView = {
        let View = StepView()
        View.Label1.text = "Event\ndetails"
        View.Label2.text = "Event\npreferences"
        View.Label3.text = "Event\nElements"
        View.Label4.text = "Start\nPlanning"
        View.ViewNumber = 1
        View.ViewNumberFour()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        return View
    }()
    
    // MARK: - Start View
    lazy var View1 : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [DayOrNight,StackEstimatedDayAndNight,ClassicOrModern,StackEstimatedClassicAndModern])
    Stack.axis = .vertical
    Stack.spacing = 20
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    Stack.heightAnchor.constraint(equalToConstant: ControlWidth(330)).isActive = true
    return Stack
    }()
    
    
    lazy var DayOrNight : UILabel = {
        let Label = UILabel()
        Label.text = "Day or Night?"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(13))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    lazy var StackEstimatedDayAndNight : UIStackView = {
       let Stack = UIStackView(arrangedSubviews: [Day,Night])
       Stack.axis = .horizontal
       Stack.spacing = 20
       Stack.distribution = .fillEqually
       Stack.alignment = .fill
       Stack.backgroundColor = .clear
       Stack.translatesAutoresizingMaskIntoConstraints = false
       Stack.heightAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
       return Stack
    }()
    
    lazy var Day : ButtonEventPlanning = {
        let Button = ButtonEventPlanning()
        Button.Image = "Day"
        Button.Select = true
        Button.addTarget(self, action: #selector(ActionDay), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionDay() {
    Day.Select = true
    Night.Select = false
    EventPlanningStep2.IsNight = false
    }
    
    static var IsNight : Bool?
    lazy var Night : ButtonEventPlanning = {
        let Button = ButtonEventPlanning()
        Button.Image = "Night"
        Button.Select = false
        Button.addTarget(self, action: #selector(ActionNight), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionNight() {
    Night.Select = true
    Day.Select = false
    EventPlanningStep2.IsNight = true
    }
    
    lazy var ClassicOrModern : UILabel = {
        let Label = UILabel()
        Label.text = "Classic or Modern?"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(13))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    lazy var StackEstimatedClassicAndModern : UIStackView = {
       let Stack = UIStackView(arrangedSubviews: [Classic,Modern])
       Stack.axis = .horizontal
       Stack.spacing = 20
       Stack.distribution = .fillEqually
       Stack.alignment = .fill
       Stack.backgroundColor = .clear
       Stack.translatesAutoresizingMaskIntoConstraints = false
       Stack.heightAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
       return Stack
    }()
    
    static var IsClassic : Bool?
    lazy var Classic : ButtonEventPlanning = {
        let Button = ButtonEventPlanning()
        Button.Image = "Classic"
        Button.Select = false
        Button.addTarget(self, action: #selector(ActionClassic), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionClassic() {
    Classic.Select = true
    Modern.Select = false
    EventPlanningStep2.IsClassic = true
    }
    
    lazy var Modern : ButtonEventPlanning = {
        let Button = ButtonEventPlanning()
        Button.Image = "Modern"
        Button.Select = true
        Button.addTarget(self, action: #selector(ActionModern), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionModern() {
    Modern.Select = true
    Classic.Select = false
    EventPlanningStep2.IsClassic = false
    }
    
    // MARK: - Start View3
    lazy var View2 : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [WhatColors,CollectionColors,WhatIsYourMusic,CollectionMusic])
    Stack.isHidden = true
    Stack.axis = .vertical
    Stack.spacing = 20
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    Stack.heightAnchor.constraint(equalToConstant: ControlWidth(330)).isActive = true
    return Stack
    }()
    
    lazy var WhatColors : UILabel = {
        let Label = UILabel()
        Label.text = "What colors do you like?"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(13))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()

    static var ColorsId : Int?
    private let ColorsID = "ColorsID"
    var indexSelectColor = IndexPath(item: 0, section: 0)
    lazy var CollectionColors: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(ColorsCell.self, forCellWithReuseIdentifier: ColorsID)
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
        return vc
    }()
    
    lazy var WhatIsYourMusic: UILabel = {
        let Label = UILabel()
        Label.text = "What is your favorite music genre?"
        Label.font = UIFont(name: "Raleway-Regular" ,size: ControlWidth(13))
        Label.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    static var MusicId : Int?
    private let MusicID = "MusicID"
    var indexSelectMusic = IndexPath(item: 0, section: 0)
    lazy var CollectionMusic: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(MusicCell.self, forCellWithReuseIdentifier: MusicID)
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
        return vc
    }()
    
    lazy var NextButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Next", for: .normal)
        Button.backgroundColor = UIColor(red: 215 / 255.0, green: 177 / 255.0, blue: 157 / 255.0, alpha: 1.0)
        Button.titleLabel?.font = UIFont.init(name: "Raleway-Bold", size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1), for: .normal)
        Button.addTarget(self, action: #selector(ActionNext(_:)), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Button
    }()
    

    @objc func ActionNext(_ Button:UIButton) {
        if Button.tag == 0 {
        View1.isHidden = true
        View2.isHidden = false
        CollectionMusic.reloadData()
        CollectionColors.reloadData()
        UIView.transition(from: View1, to: View2, duration: 0.4, options:[.transitionCrossDissolve,.showHideTransitionViews])
        Button.tag = 1
        }else{
        Present(ViewController: self, ToViewController: EventPlanningStep3())
        }
    }
    
}


extension EventPlanningStep2: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout ,ColorsCellDelegate ,MusicCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == CollectionColors {
    return EventPlanningStep1.EventColors.count
    }else{
    if Classic.Select {
    return EventPlanningStep1.EventClassic.count
    }else{
    return EventPlanningStep1.EventModern.count
    }
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CollectionColors {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorsID, for: indexPath) as! ColorsCell
        cell.backgroundColor = .clear
            
        cell.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        cell.layer.borderWidth = indexSelectColor == indexPath ? ControlWidth(2):ControlWidth(1)
        cell.ImageSelect.alpha = indexSelectColor == indexPath ? 1:0
        cell.Delegate = self
        cell.Image.sd_setImage(with: URL(string: EventPlanningStep1.EventColors[indexPath.item].IconPath ?? ""))
            
        return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicID, for: indexPath) as! MusicCell
            
        if Classic.Select {
        cell.Image.sd_setImage(with: URL(string: EventPlanningStep1.EventClassic[indexPath.item].IconPath ?? ""))
        cell.Label.text = EventPlanningStep1.EventClassic[indexPath.item].Name
        }else{
        cell.Image.sd_setImage(with: URL(string: EventPlanningStep1.EventModern[indexPath.item].IconPath ?? ""))
        cell.Label.text = EventPlanningStep1.EventModern[indexPath.item].Name
        }
    
        cell.Delegate = self
        cell.image.alpha = indexSelectMusic == indexPath ? 1:0
        cell.backgroundColor = indexSelectMusic == indexPath ? .white : UIColor(red: 250/255, green: 247/255, blue: 245/255, alpha: 1)
        cell.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        cell.layer.borderWidth = indexSelectMusic == indexPath ? ControlWidth(2):0
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ControlWidth(110), height: collectionView.frame.height)
    }
    
    func ActionCell(cell: ColorsCell) {
    if let index = CollectionColors.indexPath(for: cell) {
    UIView.animate(withDuration: 0.1, animations: {
    cell.transform = cell.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.1, animations: {
    cell.transform = .identity
    }, completion: { _ in
    self.indexSelectColor = index
    EventPlanningStep2.ColorsId = EventPlanningStep1.EventColors[index.row].Id
    self.CollectionColors.reloadData()
    })
    })
    }
    }
    
    func ActionCell(cell: MusicCell) {
    if let index = CollectionMusic.indexPath(for: cell) {
    UIView.animate(withDuration: 0.1, animations: {
    cell.transform = cell.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.1, animations: {
    cell.transform = .identity
    }, completion: { _ in
    self.indexSelectMusic = index
    EventPlanningStep2.MusicId = self.Classic.Select == true ? EventPlanningStep1.EventClassic[index.row].Id : EventPlanningStep1.EventModern[index.row].Id
    self.CollectionMusic.reloadData()
    })
    })
    }
    }
}

