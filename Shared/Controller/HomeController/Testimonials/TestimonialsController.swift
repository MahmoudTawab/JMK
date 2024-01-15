//
//  TestimonialsController.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 17/07/2021.
//

import UIKit

class TestimonialsController: ViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
        
    private let TestimonialsID = "CellTestimonials"
    var image = ["pp_(1)","pp_(2)"]
    var Rating = [3,4]
    var Title = ["Honey Lee","Honey Lee"]
    var Date = ["3 Days ago","5 Days ago"]
    var Details = ["”Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore”","”Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore”"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(BackgroundImage)
        BackgroundImage.frame = view.bounds

        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width:view.frame.width - ControlWidth(40), height: ControlHeight(50))
        
        view.addSubview(CollectionView)
        CollectionView.frame = CGRect(x: 0, y: ControlX(90), width: view.frame.width, height: view.frame.height - ControlWidth(90))
        

        self.CollectionView.AnimateCollection()
    }

    
    lazy var BackgroundImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        ImageView.alpha = 0.4
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "group31203")
        return ImageView
    }()
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.TextDismiss = "Feedback"
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
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.register(TestimonialsCell.self, forCellWithReuseIdentifier: TestimonialsID)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Title.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestimonialsID, for: indexPath) as! TestimonialsCell
        cell.backgroundColor = .white
        cell.layer.borderWidth = ControlHeight(1)
        cell.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 0.25).cgColor
        cell.LabelTitle.text = Title[indexPath.item]
        cell.LabelDetails.text = Details[indexPath.item]
        cell.LabelDate.text = Date[indexPath.item]
        cell.ImageView.image = UIImage(named: image[indexPath.item])
        cell.ViewRating.SetRating = Rating[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: ControlWidth(145))
    }
    
    

}
