//
//  KRTabBar.swift
//  TabBarController
//
//  Created by Kerolles Roshdi on 2/14/20.
//  Copyright © 2020 Kerolles Roshdi. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    @IBInspectable var selectedTab : Int = 0 {
        didSet{
            selectedIndex = selectedTab
        }
    }
    
    private var buttons = [UIButton]()
    private var buttonsColors = [UIColor]()
    private var indexViewCenterXAnchor: NSLayoutConstraint!
    
    private let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 0, height: -1)
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indexView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override var viewControllers: [UIViewController]? {
        didSet {
            createButtonsStack(viewControllers!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupViewController()
        
        addcoustmeTabBarView()
        tabBar.tintColor = .black
        createButtonsStack(viewControllers!)
        self.selectedIndex = self.selectedTab
        autolayout()
        
        indexView.layer.cornerRadius = ControlWidth(10)
        indexView.backgroundColor = buttonsColors[selectedTab]
        
        NotificationCenter.default.addObserver(self, selector: #selector(Profile), name: CheckoutVC.Profile , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PresentMenu), name: HomeController.PresentMenu , object: nil)
    }
        
        fileprivate func setupViewController() {
        let Home = setupNavigationController(HomeController(), "Home", "home")

        let profile = setupNavigationController(ProfileController(), "Profile", "user")

        let Calendar = setupNavigationController(CalendarController(), "Calendar", "calendar2")

        let Menu = setupNavigationController(MenuController(), "Menu", "menu2")

        let Notifications = setupNavigationController(NotificationsController(), "Notifications", "ringing1")

        viewControllers = [Home,profile,Calendar,Menu,Notifications]
        }

        fileprivate func setupNavigationController(_ viewController:UIViewController ,_ title:String ,_ Image:String) -> UINavigationController {
        let ControllerNav = UINavigationController(rootViewController: viewController)
        ControllerNav.navigationBar.isHidden = true
            
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: Image)
        return ControllerNav
        }
    
    
    @objc func PresentMenu() {
        selectedIndex = 3
        selectedTab = 3
        viewDidLayoutSubviews()
        createButtonsStack(viewControllers!)
        autolayout()
    }
    
    @objc func Profile() {
        selectedIndex = 1
        selectedTab = 1
        viewDidLayoutSubviews()
        createButtonsStack(viewControllers!)
        autolayout()
    }
    
    
    private func createButtonsStack(_ viewControllers: [UIViewController]) {
        
        // clean :
        buttons.removeAll()
        buttonsColors.removeAll()
        
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for (index, viewController) in viewControllers.enumerated() {
   
            buttonsColors.append(#colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.2029533127))
            let button = TabBarButton()
            button.tag = index
            button.addTarget(self, action: #selector(didSelectIndex(sender:)), for: .touchUpInside)
            let image = viewController.tabBarItem.image?.withRenderingMode(.alwaysTemplate)
            
            let BackgroundImage = image?.withInset(UIEdgeInsets(top: 10, left: 14, bottom: 18, right: 14))
            button.Label.text = viewController.tabBarItem.title
            button.setBackgroundImage(BackgroundImage, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        view.setNeedsLayout()
    }

    private func autolayout() {
            customTabBarView.rightAnchor.constraint(equalTo: tabBar.rightAnchor).isActive = true
            customTabBarView.leftAnchor.constraint(equalTo: tabBar.leftAnchor).isActive = true
            customTabBarView.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
            if #available(iOS 11.0, *) {
            let bottomInset =  UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
            customTabBarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor,constant: bottomInset == 0 ? 0:ControlX(-20)).isActive = true
            }else{
            customTabBarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
            }
            
            stackView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor).isActive = true
            stackView.topAnchor.constraint(equalTo: customTabBarView.topAnchor).isActive = true
            
            indexView.heightAnchor.constraint(equalToConstant: ControlWidth(56)).isActive = true
            indexView.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
            indexView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        
            indexViewCenterXAnchor = indexView.centerXAnchor.constraint(equalTo: buttons[selectedTab].centerXAnchor)
            indexViewCenterXAnchor.isActive = true
    }
    
    private func addcoustmeTabBarView() {
        tabBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlWidth(70))
        customTabBarView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlWidth(68))
        indexView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlWidth(54))
        
        tabBar.addSubview(customTabBarView)
        customTabBarView.addSubview(indexView)
        customTabBarView.addSubview(stackView)
    }
    
    @objc private func didSelectIndex(sender: UIButton) {
  
//        if defaults.string(forKey: "JWT") == nil {
//        if sender.tag == 1 || sender.tag == 4 {
//        ShowMessageAlert("𝗶", "Log In First", "You are not logged in yet,\nplease login first in order to continue", false, self.ActionLogin, "Login")
//        }else{
        SelectedTab(sender.tag)
//        }
//        }else{
//        SelectedTab(sender.tag)
//        }
    }
    
    
    func SelectedTab(_ sender:Int) {
        self.selectedTab = sender
        self.selectedIndex = sender
        UIView.transition(from: view, to: view, duration: 0.1, options: [.transitionCrossDissolve,.showHideTransitionViews])
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.64, options: [], animations: {
        self.indexView.backgroundColor = self.buttonsColors[sender]

        self.indexViewCenterXAnchor.isActive = false
        self.indexViewCenterXAnchor = nil
        self.indexViewCenterXAnchor = self.indexView.centerXAnchor.constraint(equalTo: self.buttons[sender].centerXAnchor)
        self.indexViewCenterXAnchor.isActive = true
        self.tabBar.layoutIfNeeded()
        })
    }

    @objc func ActionLogin() {
    FirstController(SignInController())
    }
    
    // Delegate:
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard
            let items = tabBar.items,
            let index = items.firstIndex(of: item)
            else {
                print("not found")
                return
        }
    
        self.didSelectIndex(sender: self.buttons[index])
    }
    
    init() {
    super.init(nibName: nil, bundle: nil)
    object_setClass(self.tabBar, WeiTabBar.self)
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    

    
}

class WeiTabBar: UITabBar {
      override func sizeThatFits(_ size: CGSize) -> CGSize {
          var sizeThatFits = super.sizeThatFits(size)
          
          if #available(iOS 11.0, *) {
          let bottomInset = safeAreaInsets.bottom
            sizeThatFits.height = bottomInset == 0 ? ControlWidth(70):ControlWidth(90)
          }else{
            sizeThatFits.height = ControlWidth(70)
          }
        
          self.clipsToBounds = false
          self.layer.masksToBounds = false
          self.backgroundColor = .white
          self.shadowImage = UIImage()
          self.backgroundImage = UIImage()
          return sizeThatFits
      }
  }
  

import UIKit
@IBDesignable
class TabBarButton: UIButton {
    
    lazy var Label : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
    Label.textAlignment = .center
    Label.font = UIFont(name: "Raleway-Bold", size: ControlWidth(9))
    Label.translatesAutoresizingMaskIntoConstraints = false
    return Label
   }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(Label)
        self.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)

        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlY(-6)).isActive = true
        Label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ControlX(5)).isActive = true
        Label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-5)).isActive = true
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


