//
//  SideMenuBarVC.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class SideMenuBarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let myArray: NSArray = ["First","Second","Third"]
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIApplication.shared.statusBarStyle = .lightContent
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        myTableView = UITableView(frame: CGRect(x: 0, y: -20, width: displayWidth, height: displayHeight + barHeight))
        //myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "header")
        myTableView.register(UINib(nibName: "MenuListCell", bundle: nil), forCellReuseIdentifier: "menuList")
        self.view.addSubview(myTableView)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            myTableView.deselectRow(at: indexPath, animated: true)
            let regis = HomeVC()
            let navCon = DefaultController()
            DefaultController.indexOftabbar = 0
            navCon.viewControllers = [regis]
            self.present(navCon, animated: true, completion: nil)
        }
        else if indexPath.row == 2 {
            myTableView.deselectRow(at: indexPath, animated: true)
            let regis = MyOrderVC()
            let navCon = DefaultController()
            DefaultController.indexOftabbar = 1
            navCon.viewControllers = [regis]
            self.present(navCon, animated: true, completion: nil)
        }else if indexPath.row == 3 {
            myTableView.deselectRow(at: indexPath, animated: true)
            
            let regis = InvoiceVC()
            let navCon = DefaultController()
            DefaultController.indexOftabbar = 2
            navCon.viewControllers = [regis]
            self.present(navCon, animated: true, completion: nil)
        }else if indexPath.row == 4 {
            myTableView.deselectRow(at: indexPath, animated: true)
            let regis = ProfileVC()
            let navCon = DefaultController()
            DefaultController.indexOftabbar = 3
            navCon.viewControllers = [regis]
            self.present(navCon, animated: true, completion: nil)
        }else if indexPath.row == 5 {
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey:"session")
            self.present(LoginVC(), animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! HeaderCell
            if UserDefaults.standard.array(forKey: "session") != nil {
                cell.store_name.text = "\(UserDefaults.standard.array(forKey: "session")![1])"
                cell.info_name.text = "\(UserDefaults.standard.array(forKey: "session")![2])"
                if let image_photo: String = ProfileVC.image_photo {
                     cell.user_image.sd_setImage(with: URL(string: image_photo), placeholderImage: UIImage(named: "placeholder.png"))
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuList", for: indexPath) as! MenuListCell
            if indexPath.row == 3 {
                cell.view_line.isHidden = false
            }
            myTableView.separatorStyle = .none
            cell.loadView(indexPath.row)
            return cell
        }
        
    }
}
