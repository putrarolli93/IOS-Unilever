//
//  NoLogin.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import SideMenuController

class NoLogin: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewPhotoAction()
    }
    
    func getNewPhotoAction() {
        let sideMenuViewController = SideMenuController()
        
        // create the view controllers for center containment
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.red
        vc1.title = "first"
        let nc1 = UINavigationController(rootViewController: vc1)
        vc1.navigationItem.title = "first"
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.yellow
        vc2.title = "second"
        let nc2 = UINavigationController(rootViewController: vc2)
        vc2.navigationItem.title = "second"
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.blue
        vc3.title = "third"
        let nc3 = UINavigationController(rootViewController: vc3)
        vc3.navigationItem.title = "third"
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nc1, nc2, nc3]
        
        // create the side controller
        let sideController = UITableViewController()
        
        // embed the side and center controllers
        sideMenuViewController.embed(sideViewController: sideController)
        sideMenuViewController.embed(centerViewController: tabBarController)
        
        // add the menu button to each view controller embedded in the tab bar controller
        [nc1, nc2, nc3].forEach({ controller in
            controller.addSideMenuButton()
        })
    }
}
