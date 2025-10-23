//
//  BasicViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/14.
//

final class BasicViewModel {
    
    /// GET_BASIC_INFO
    func getBasicInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/fancmuchion", json: json, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingHUD.shared.hide()
                completion(success)
                break
            case .failure(_):
                LoadingHUD.shared.hide()
                let model = BaseModel()
                completion(model)
                break
            }
        }
    }
    
    func saveBasicInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/nihilics", json: json, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingHUD.shared.hide()
                completion(success)
                break
            case .failure(_):
                LoadingHUD.shared.hide()
                let model = BaseModel()
                completion(model)
                break
            }
        }
    }
    
    /// GET_BANK_INFO
    func getBankInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/kilolaughish", json: json, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingHUD.shared.hide()
                completion(success)
                break
            case .failure(_):
                LoadingHUD.shared.hide()
                let model = BaseModel()
                completion(model)
                break
            }
        }
    }
    
    func saveBankInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/sipirangeular", json: json, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingHUD.shared.hide()
                completion(success)
                break
            case .failure(_):
                LoadingHUD.shared.hide()
                let model = BaseModel()
                completion(model)
                break
            }
        }
    }
    
}
