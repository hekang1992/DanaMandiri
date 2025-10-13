//
//  SchemeManager.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/11.
//

import Foundation
import UIKit

class SchemeManager {
    
    enum SchemeType: String {
        case home
        case setting
        case login
        case order
        case product
        case unknown
    }
    
    let HOME_URL = "home"
    let SETTING_URL = "setting"
    let LOGIN_URL = "login"
    let ORDER_URL = "order"
    let PRODUCT_URL = "product"
    
    static func judgeInsertUrl(url: String) -> SchemeType {
        if url.contains(SCHEME_HOME_URL) {
            return .home
        }else if url.contains(SCHEME_SETTING_URL) {
            return .setting
        }else if url.contains(SCHEME_LOGIN_URL) {
            return .login
        }else if url.contains(SCHEME_ORDER_URL) {
            return .order
        }else if url.contains(SCHEME_PRODUCT_URL) {
            return .product
        }else {
            return .unknown
        }
    }
    
    static func handle(url: String) {
        switch judgeInsertUrl(url: url) {
        case .home:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
            }
            break
        case .setting:
            if let tabBar = UIApplication.shared.windows.first?.rootViewController as? CustomTabBarController {
                if let nav = tabBar.getCurrentViewController() as? UINavigationController {
                    let settingVC = SettingViewController()
                    nav.pushViewController(settingVC, animated: true)
                }
            }
            break
        case .login:
            AuthLoginManager.shared.removeLoginInfo()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
            }
            break
        case .order:
            break
        case .product:
            break
        case .unknown:
            break
        }
    }
    
}
