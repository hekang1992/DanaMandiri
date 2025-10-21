//
//  CommonBpViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/16.
//

class CommonBpViewModel {
    
    /// GET_BASIC_INFO
    func getCommonBpInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/phone", json: json, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingHUD.hide()
                completion(success)
                break
            case .failure(_):
                LoadingHUD.hide()
                let model = BaseModel()
                completion(model)
                break
            }
        }
    }
    
    func saveCommonBpInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/senselike", json: json, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingHUD.hide()
                completion(success)
                break
            case .failure(_):
                LoadingHUD.hide()
                let model = BaseModel()
                completion(model)
                break
            }
        }
    }
    
    func saveAllPhoneInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        NetworkManager.shared.postJsonRequest(url: "/taxile/platyid", json: json, responseType: BaseModel.self) { result in
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
    
}
