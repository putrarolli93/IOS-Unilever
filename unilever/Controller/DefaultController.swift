//
//  DefaultController.swift
//  unilever
//
//  Created by putra rolli on 18/06/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import SideMenuController

class DefaultController: UINavigationController {
    
    static var indexOftabbar: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
        showHome()
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationController?.defaultStyle()
        //        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(searchIconTapped))
        //-------------------
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func showHome() {
        let sideMenuViewController = SideMenuController()
        
        // create the view controllers for center containment
        let vc1 = HomeVC()
        vc1.view.backgroundColor = UIColor.white
        //        vc1.title = "first"
        //        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        vc1.navigationItem.titleView = UIImageView(image: UIImage(named: "unilever_brand"))
        
        //------------------
        //        let label = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
        ////        label.center = CGPoint(x: 160, y: 285)
        //        label.textColor = UIColor.red
        //        label.textAlignment = .center
        //        label.text = "\(LoginVC.product_count)"
        //        label.backgroundColor = UIColor.cyan
        
        //-------------------
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(searchIconTapped))
        //        vc1.navigationItem.rightBarButtonItem = rightBarButton
        let nc1 = UINavigationController(rootViewController: vc1)
        //        nc1.navigationBar.addSubview(label)
        nc1.navigationBar.backgroundColor = UIColor.white
        nc1.navigationBar.barTintColor = UIColor.white
        nc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"),tag: 1)
        //        vc1.navigationItem.title = "first"
        
        let vc2 = MyOrderVC()
        vc2.view.backgroundColor = UIColor.white
        vc2.navigationItem.titleView = UIImageView(image: UIImage(named: "unilever_brand"))
        vc2.navigationItem.rightBarButtonItem = rightBarButton
        //        vc2.title = "second"
        let nc2 = UINavigationController(rootViewController: vc2)
        nc2.tabBarItem = UITabBarItem(title: "Pesanan", image: UIImage(named: "ic_order"),tag: 1)
        
        let vc3 = InvoiceVC()
        vc3.view.backgroundColor = UIColor.white
        //        vc3.title = "third"
        vc3.navigationItem.titleView = UIImageView(image: UIImage(named: "unilever_brand"))
        vc3.navigationItem.rightBarButtonItem = rightBarButton
        let nc3 = UINavigationController(rootViewController: vc3)
        nc3.tabBarItem = UITabBarItem(title: "Tagihan", image: UIImage(named: "ic_order"),tag: 1)
        
        let vc4 = ProfileVC()
        vc4.view.backgroundColor = UIColor.white
        //        vc4.title = "fourth"
        vc4.navigationItem.titleView = UIImageView(image: UIImage(named: "unilever_brand"))
        vc4.navigationItem.rightBarButtonItem = rightBarButton
        let nc4 = UINavigationController(rootViewController: vc4)
        nc4.tabBarItem = UITabBarItem(title: "Profil", image: UIImage(named: "ic_profile_new"),tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nc1, nc2, nc3, nc4]
        
        // create the side controller
        let sideController = SideMenuBarVC()
        
        // embed the side and center controllers
        sideMenuViewController.embed(sideViewController: sideController)
        sideMenuViewController.embed(centerViewController: tabBarController)
        
        // add the menu button to each view controller embedded in the tab bar controller
        [nc1, nc2, nc3, nc4].forEach({ controller in
            controller.addSideMenuButton()
        })
        
        show(sideMenuViewController, sender: nil)
        tabBarController.selectedIndex = DefaultController.indexOftabbar
        
    }
    
    func searchIconTapped() {
        //        tabBarController?.selectedIndex = 1
    }
}
