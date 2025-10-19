//
//  AppDelegate.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/9.
//

import UIKit
import FBSDKCoreKit
import IQKeyboardManagerSwift
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var tabbarVc: CustomTabBarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initRootVc()
        initKeyBord()
        initWindow()
        return true
    }
}

extension AppDelegate {
    
    func initRootVc() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(switchRootVc(_:)),
            name: NSNotification.Name("switchRootVc"),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(toSecondVc(_:)),
            name: NSNotification.Name("toSecondVc"),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(aTTracking(_:)),
            name: NSNotification.Name("aTTracking"),
            object: nil
        )
    }
    
    @objc func switchRootVc(_ noti: Notification) {
        if AuthLoginManager.shared.isLoggedIn {
            tabbarVc = CustomTabBarController()
            self.window?.rootViewController = tabbarVc
        } else {
            self.window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
    @objc func toSecondVc(_ noti: Notification) {
        tabbarVc?.select(index: 1)
    }
    
    @objc func aTTracking(_ noti: Notification) {
        let json = noti.userInfo as? [String: String] ?? ["type": "0"]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .notDetermined, .denied:
                        self.uploadInfo(with: json)
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
    
    private func uploadInfo(with roctJson: [String: String]) {
        let centrten = IDFVManager.shared.getPersistentIDFV() ?? ""
        let coldlike = IDFAManager.getIDFA() ?? ""
        let json = ["centrten": centrten, "coldlike": coldlike]
        uoinfo(json: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                Settings.shared.appID = model.terrtrialistic?.cystence ?? ""
                Settings.shared.clientToken = model.terrtrialistic?.capite ?? ""
                Settings.shared.displayName = model.terrtrialistic?.genperiod ?? ""
                Settings.shared.appURLSchemeSuffix = model.terrtrialistic?.xylant ?? ""
                ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
            }
            if roctJson["type"] == "0" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                }
            }
        }
    }
    
    func uoinfo(json: [String: Any],
                completion: @escaping (BaseModel) -> Void) {
        NetworkManager.shared.postJsonRequest(
            url: "/taxile/minaclike",
            json: json,
            responseType: BaseModel.self) { result in
                switch result {
                case .success(let success):
                    completion(success)
                    break
                case .failure(_):
                    let model = BaseModel()
                    completion(model)
                    break
                }
            }
    }
    
    func initKeyBord() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 2
    }
    
    func initWindow() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = StartViewController()
        window?.makeKeyAndVisible()
    }
}
