//
//  LoginVC.swift
//  unilever
//
//  Created by Programmer5 on 5/4/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import SideMenuController
import FTIndicator
import CoreData

class LoginVC: UIViewController,LoginDelegate,IsLoginDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var launcScreen: UIView!
    @IBOutlet weak var version: UILabel!
    static let screenSize = UIScreen.main.bounds
    
    var _request: LoginRequest = LoginRequest()
    var _check: CheckLogin = CheckLogin()
    static var product_count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self._check.delegate = self
        username.delegate = self
        password.delegate = self
        version.text = "V.\(_version())"
        self._check.req()
        LoginVC.getData()
    }
    
    func _version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return "\(version)"
    }
    
    @IBAction func loginAct(_ sender: Any) {
        FTIndicator.showProgress(withMessage: "Loading")
        self._request.delegate = self
        self._request.username = self.username.text!
        self._request.password = self.password.text!
        self._request.req()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let forgot = ForgotPasswordVC()
        let navCon = UINavigationController()
        navCon.viewControllers = [forgot]
        self.present(navCon, animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        let regis = RegisterVC()
        let navCon = UINavigationController()
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
    }
    
    func searchIconTapped() {
//        tabBarController?.selectedIndex = 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    }
    //MARK: LoginDelegate
    func loginSuccess(data: LoginModel) {
        print(data)
        if data.response_code == "00" {
            UserDefaults.standard.set(["\(data.data.outlet_id)","\(data.data.outlet_name)","\(data.data.username)"], forKey: "session")
            self.showHome()
        }else{
            let alert = UIAlertController(title: "Alert", message: "Username or Password incorrect", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        FTIndicator.dismissProgress()
    }
    
    func loginError(data: String) {
       
    }
    
    //MARK: CheckLogin
    func isLogin(data: String) {
        self.showHome()
    }
    
    func isNotlogin(data: String) {
        launcScreen.isHidden = true
    }
    
    static func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if result.count == 0 {
                LoginVC.product_count = 0
            }
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "product_id") as! String)
                LoginVC.product_count = result.count
            }
            
        } catch {
            print("Failed")
        }
    }
    
}
