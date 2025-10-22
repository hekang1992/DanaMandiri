//
//  LoginUntitled.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/22.
//

import KeychainAccess

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
        removeAuthToken()
        UserDefaults.standard.set("", forKey: "entertime")
        UserDefaults.standard.set("", forKey: "leavetime")
        UserDefaults.standard.synchronize()
    }
    
    func getPhoneNumber() -> String? {
        return UserDefaults.standard.string(forKey: phoneKey)
    }
}
