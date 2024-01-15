//
//  Present.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit

class ViewController : UIViewController {
    
    func Present(ViewController:UIViewController,ToViewController:UIViewController) {
        let Controller = ToViewController
        Controller.hidesBottomBarWhenPushed = true
        Controller.modalPresentationStyle = .fullScreen
        Controller.modalTransitionStyle = .coverVertical
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        
        view.addSubview(ViewNoData)
        view.addSubview(ProgressHud)
        view.addSubview(BottomView)
        UpDateShoppingHubCount()
    }

    lazy var ProgressHud : VKProgressHud = {
        let View = VKProgressHud(frame: view.bounds)
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var ViewNoData : ViewIsError = {
        let View = ViewIsError(frame: CGRect(x: ControlWidth(20), y: ControlY(80), width: view.frame.width - ControlWidth(40), height: view.frame.height - ControlWidth(160)))
        View.backgroundColor = .clear
        View.isHidden = true
        View.ImageIcon = "warning-sign"
        View.MessageTitle = "Something went wrong"
        View.TextRefresh = "Refresh"
        View.MessageDetails = "We are sorry no data have been found, please try again"
        return View
    }()
    
    lazy var BottomView : ViewAddedItems = {
    let View = ViewAddedItems(frame: CGRect(x: 0, y: view.frame.maxY - ControlWidth(60), width: view.frame.width, height: ControlWidth(60)))
        View.Items = 1
    return View
    }()
    
    var ShoppingHub: BadgeHub?
    lazy var ShoppingButton: UIImageView = {
        let button = UIImageView()
        ShoppingHub = BadgeHub(view: button)
        ShoppingHub?.setCircleBorderColor(UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1), borderWidth: 1)
        ShoppingHub?.setCircleAtFrame(CGRect(x: 0, y: 0, width: ControlWidth(20), height: ControlWidth(20)))
        ShoppingHub?.setCircleColor(UIColor.white, label: UIColor(red: 99 / 255, green: 87 / 255, blue: 82 / 255, alpha: 1))
        ShoppingHub?.moveCircleBy(x: ControlX(23), y: ControlX(1))
        ShoppingHub?.bump()
            
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.image = UIImage(named: "shopping-cart")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionShopping)))
        return button
    }()
    
    func UpDateShoppingHubCount() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    self.ShoppingHub?.setCount(LaunchScreen.Cart?.CartItemCount ?? 0)
    }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UpDateShoppingHubCount()
    }
    
    
    @objc func ActionShopping() {
    if defaults.string(forKey: "JWT") == nil {
    ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLoginFirst, "Login")
    }else{
    if LaunchScreen.Cart?.CartItemCount == 0 {
    let Successfully = ViewSuccessfully()
    Successfully.TextDismiss = "Cart"
    Successfully.GoText = "Explore"
    Successfully.ImageIcon = "empty-cart"
    Successfully.MessageTitle = "Cart Empty"
    Successfully.MessageDetails = "You haven’t added any items to your cart yet, explore JMK now and start adding items to your cart!"
    Successfully.GoToController.addTarget(self, action: #selector(SuccessfullyCart), for: .touchUpInside)
    Successfully.modalPresentationStyle = .overFullScreen
    Successfully.modalTransitionStyle = .crossDissolve
    present(Successfully, animated: true)
    }else{
    Present(ViewController: self, ToViewController: CartVC())
    }
    }
    }

    @objc func SuccessfullyCart() {
    self.dismiss(animated: true)
    NotificationCenter.default.post(name: HomeController.PresentMenu, object: nil)
    }
    
    @objc func ActionLoginFirst() {
    FirstController(SignInController())
    }
    
}
