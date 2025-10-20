//
//  Untitled.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/18.
//

import Foundation

struct JailbreakDetector {
    static func isJailbroken() -> Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        let jailbreakPaths = [
            "/Applications/Cydia.app",
            "/etc/apt",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd"
        ]
        for path in jailbreakPaths where FileManager.default.fileExists(atPath: path) {
            return true
        }

        let testPath = "/private/" + UUID().uuidString
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testPath)
            return true
        } catch { }

        return false
        #endif
    }
}

struct DeinfoVoipInfo {
    
    enum ConnectionStatus: Int {
        case inactive = 0
        case active = 1
    }
    
    static var proxyStatus: ConnectionStatus {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any] else {
            return .inactive
        }
        
        let hasProxy = ["HTTPProxy", "HTTPSProxy"].contains { key in
            !(proxySettings[key] as? String ?? "").isEmpty
        }
        
        return hasProxy ? .active : .inactive
    }
    
    static var vpnStatus: ConnectionStatus {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scopes = settings["__SCOPED__"] as? [String: Any] else {
            return .inactive
        }
        
        let vpnInterfaces = ["tap", "tun", "ppp", "ipsec", "utun"]
        let hasVPN = scopes.keys.contains { key in
            vpnInterfaces.contains { key.contains($0) }
        }
        return hasVPN ? .active : .inactive
    }
}
