//
//  NetworkStatusManager.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/17.
//

import Alamofire

class NetworkStatusManager {
    
    static let shared = NetworkStatusManager()
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    private init() {}
    
    func startListening(completion: @escaping (String) -> Void) {
        reachabilityManager?.startListening { status in
            var statusString = "unknown"
            switch status {
            case .notReachable:
                statusString = "none"
            case .unknown:
                statusString = "unknown"
            case .reachable(.ethernetOrWiFi):
                statusString = "WIFI"
            case .reachable(.cellular):
                statusString = "5G"
            }
            UserDefaults.standard.set(statusString, forKey: "network")
            UserDefaults.standard.synchronize()
            completion(statusString)
        }
    }
    
    func stopListening() {
        reachabilityManager?.stopListening()
    }
}
