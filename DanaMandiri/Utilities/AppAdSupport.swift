//
//  Untitled.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit
import AdSupport
import Foundation
import KRProgressHUD
import KeychainAccess
import AppTrackingTransparency

class IDFVManager {
    static let shared = IDFVManager()
    
    private let serviceIdentifier = "com.diri.app"
    private let idfvKey = "deviceIDFV"
    private let keychain: Keychain
    
    private init() {
        keychain = Keychain(service: serviceIdentifier)
    }
    
    func getPersistentIDFV() -> String? {
        if let storedIDFV = try? keychain.getString(idfvKey),
            !storedIDFV.isEmpty {
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
    
    static func getIDFA() -> String? {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier
        return idfa.uuidString != "00000000000" ? idfa.uuidString : nil
    }
}

class ToastProgressHUD {
    static func showToastText(message: String) {
        KRProgressHUD.showMessage(message)
    }
}


class CityAddressModel{
    static let shared = CityAddressModel()
    private init() {}
    var cityModel: salinModel?
}
