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

internal protocol GetProfileAfterLoginDelegate {
    func getProfileAfterLogin(_ data: String)
}

class LoginVC: UIViewController,LoginDelegate,IsLoginDelegate,UITextFieldDelegate,GetProfileDelegate,SideMenuControllerDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var launcScreen: UIView!
    @IBOutlet weak var version: UILabel!
    static let screenSize = UIScreen.main.bounds
    
    var _request: LoginRequest = LoginRequest()
    var _request_profile: GetProfileRequest = GetProfileRequest()
    var _check: CheckLogin = CheckLogin()
    static var product_count: Int = 0
    var login_model: LoginModel!
    var delegate: GetProfileAfterLoginDelegate!
    var isFromLogin: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._check.delegate = self
        username.delegate = self
        password.delegate = self
        version.text = "V.\(_version())"
        _request_profile.delegate = self
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
        sideMenuViewController.delegate = self
        // create the view controllers for center containment
        let vc1 = HomeVC()
        vc1.view.backgroundColor = UIColor.white
        //        vc1.title = "first"
        //        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        vc1.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_500x500"))
        
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
        vc2.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_500x500"))
        vc2.navigationItem.rightBarButtonItem = rightBarButton
        //        vc2.title = "second"
        let nc2 = UINavigationController(rootViewController: vc2)
        nc2.tabBarItem = UITabBarItem(title: "Pesanan", image: UIImage(named: "ic_order"),tag: 1)
        
        let vc3 = InvoiceVC()
        vc3.view.backgroundColor = UIColor.white
        //        vc3.title = "third"
        vc3.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_500x500"))
        vc3.navigationItem.rightBarButtonItem = rightBarButton
        let nc3 = UINavigationController(rootViewController: vc3)
        nc3.tabBarItem = UITabBarItem(title: "Tagihan", image: UIImage(named: "ic_order"),tag: 1)
        
        let vc4 = ProfileVC()
        vc4.view.backgroundColor = UIColor.white
        //        vc4.title = "fourth"
        vc4.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_500x500"))
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
        self.login_model = data
        if data.response_code == "00" {
            UserDefaults.standard.set(["\(data.data.outlet_id)","\(data.data.outlet_name)","\(data.data.username)"], forKey: "session")
            _request_profile.username = data.data.username
            _request_profile.outlet_id = data.data.outlet_id
            _request_profile.req()
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
        isFromLogin = false
        _request_profile.username = "\(UserDefaults.standard.array(forKey: "session")![2])"
        _request_profile.outlet_id = "\(UserDefaults.standard.array(forKey: "session")![0])"
        _request_profile.req()
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
    
    //MARK: GET PROFILE
    func getProfileSuccess(data: GetProfileModel) {
        var image: String = ""
        if isFromLogin {
            image = "\(BaseUrl.baseUrl)commerce/unilever-middleware/uploads/\(login_model.data.outlet_id)/\(data.data.outlet_photo)"
        }else{
            image = "\(BaseUrl.baseUrl)commerce/unilever-middleware/uploads/\(UserDefaults.standard.array(forKey: "session")![0])/\(data.data.outlet_photo)"
        }
        ProfileVC.image_photo = image
        UserDefaults.standard.set("\(image)", forKey: "image")
      showHome()
    }
    
    func getProfileError(data: String) {
        showHome()
    }
    
    //MARK: SIDEMENU
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        
    }
    
}
