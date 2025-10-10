//
//  Untitled.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import AdSupport
import KeychainAccess
import AppTrackingTransparency
import KRProgressHUD

class IDFVManager {
    static let shared = IDFVManager()
    
    private let serviceIdentifier = "com.diri.app"
    private let idfvKey = "deviceIDFV"
    private let keychain: Keychain
    
    private init() {
        keychain = Keychain(service: serviceIdentifier)
    }
    
    func getPersistentIDFV() -> String? {
        if let storedIDFV = try? keychain.getString(idfvKey), !storedIDFV.isEmpty {
            return storedIDFV
        }
        
        guard let newIDFV = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        
        do {
            try keychain.set(newIDFV, key: idfvKey)
        } catch {
            print("Failed to save IDFV to Keychain: \(error)")
        }
        
        return newIDFV
    }
}

class IDFAManager {
    
    static func requestIDFA(completion: @escaping (String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            if #available(iOS 14, *) {
                let status = ATTrackingManager.trackingAuthorizationStatus
                switch status {
                case .authorized:
                    completion(getIDFA())
                case .notDetermined:
                    ATTrackingManager.requestTrackingAuthorization { newStatus in
                        DispatchQueue.main.async {
                            completion(newStatus == .authorized ? getIDFA() : nil)
                        }
                    }
                default:
                    completion(nil)
                }
            } else {
                completion(ASIdentifierManager.shared().isAdvertisingTrackingEnabled ? getIDFA() : nil)
            }
        }
    }
    
    static func getIDFA() -> String? {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier
        return idfa.uuidString != "00000000-0000-0000-0000-000000000000" ? idfa.uuidString : nil
    }
}

class AuthLoginManager {
    static let shared = AuthLoginManager()
    
    private let phoneKey = "phoneNumber"
    
    private let tokenKey = "authToken"
    
    private let keychain: Keychain
    
    private init() {
        keychain = Keychain(service: "com.diri.app.auth")
    }
    
    var isLoggedIn: Bool {
        guard let phone = UserDefaults.standard.string(forKey: phoneKey),
              let token = getAuthToken(),
              !phone.isEmpty,
              !token.isEmpty else {
            return false
        }
        return true
    }
    
    func getAuthToken() -> String? {
        return try? keychain.get(tokenKey)
    }
    
    private func saveAuthToken(_ token: String) {
        do {
            try keychain.set(token, key: tokenKey)
        } catch {
            print("Failed to save token to Keychain: \(error)")
        }
    }
    
    private func removeAuthToken() {
        do {
            try keychain.remove(tokenKey)
        } catch {
            print("Failed to remove token from Keychain: \(error)")
        }
    }
    
    func saveLoginInfo(phone: String, token: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
        saveAuthToken(token)
    }
    
    func removeLoginInfo() {
        UserDefaults.standard.removeObject(forKey: phoneKey)
        removeAuthToken()
    }
    
    func getPhoneNumber() -> String? {
        return UserDefaults.standard.string(forKey: phoneKey)
    }
}

enum ProxyStatus {
    static var isEnabled: Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any],
              let httpProxyEnabled = proxySettings[kCFNetworkProxiesHTTPEnable as String] as? Bool else {
            return false
        }
        return httpProxyEnabled
    }
    
    static var connectionState: Int {
        return isEnabled ? 1 : 0
    }
    
}

enum VPNStatus {
    static var isConnected: Bool {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scopedSettings = settings["__SCOPED__"] as? [String: Any] else {
            return false
        }
        
        let vpnInterfaces = ["tap", "tun", "ppp", "ipsec", "utun"]
        return scopedSettings.keys.contains { key in
            vpnInterfaces.contains { interface in
                key.lowercased().contains(interface)
            }
        }
    }
    
    static var connectionState: Int {
        return isConnected ? 1 : 0
    }
}

class ToastHUD {
    static func showToastText(form view: UIView, message: String) {
        KRProgressHUD.showMessage(message)
    }
}
