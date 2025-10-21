//
//  ColsomeManager.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/17.
//

import Foundation

class ColsomeManager {
    
    static func colsomeInfo(with json: [String: String], leavetime: String) {
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        if cin == "460" {
            let cerebracle = IDFVManager.shared.getPersistentIDFV() ?? ""
            let performivity = IDFAManager.getIDFA() ?? ""
            var colJson = ["ideaence": leavetime,
                           "cerebracle": cerebracle,
                           "performivity": performivity]
            
            colJson = colJson.merging(json) { (current, new) in
                return new
            }
            NetworkManager.shared.postJsonRequest(url: "/taxile/colsome", json: colJson, responseType: BaseModel.self) { reslut in
                switch reslut {
                case .success(_):
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
}

class LocationManagerModel {
    
    func uoAddressinfo(json: [String: Any],
                completion: @escaping (BaseModel) -> Void) {
        NetworkManager.shared.postJsonRequest(
            url: "/taxile/alate",
            json: json,
            responseType: BaseModel.self) { result in
                switch result {
                case .success(let success):
                    completion(success)
                    break
                case .failure(_):
                    break
                }
            }
    }
    
}
