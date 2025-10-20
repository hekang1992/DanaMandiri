//
//  SmallInfo.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/18.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

class Opener {
    var arthr: String?
    var valorium: String?
    var coprise: String?
    var pachyade: String?
    
    init() {
        self.arthr = SSIDInfo.getBSSID()
        self.valorium = SSIDInfo.getSSID()
        self.coprise = SSIDInfo.getBSSID()
        self.pachyade = SSIDInfo.getSSID()
    }

    func toJson() -> [String: Any] {
        return [
            "arthr": arthr ?? "",
            "valorium": valorium ?? "",
            "coprise": coprise ?? "",
            "pachyade": pachyade ?? ""
        ]
    }
    
}


class SSIDInfo {
    
    class func getBSSID() -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        
        for interface in interfaces {
            guard let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] else {
                continue
            }
            
            if let bssid = interfaceInfo["BSSID"] as? String {
                return bssid
            }
        }
        
        return nil
    }
    
    class func getSSID() -> String? {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            currentSSID = myDict["SSID"] as? String ?? ""
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
}

class GetIpInfo {
    static func getIPAddress() -> String? {
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else {
            return nil
        }
        
        defer { freeifaddrs(ifaddr) }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            
            // 只查找 IPv4 地址
            guard addrFamily == UInt8(AF_INET) else { continue }
            
            let name = String(cString: interface.ifa_name)
            guard ["en0", "en2", "en3", "en4"].contains(name) else { continue }
            
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            let result = getnameinfo(
                interface.ifa_addr,
                socklen_t(interface.ifa_addr.pointee.sa_len),
                &hostname,
                socklen_t(hostname.count),
                nil,
                0,
                NI_NUMERICHOST
            )
            
            guard result == 0 else { continue }
            
            return String(cString: hostname)
        }
        
        return nil
    }
}
