//
//  AppDelegate.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/9.
//

import UIKit
import FBSDKCoreKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

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
    }
    
    @objc func switchRootVc(_ noti: Notification) {
        if AuthLoginManager.shared.isLoggedIn {
            self.window?.rootViewController = BaseTabBarController()
        } else {
            self.window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
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
