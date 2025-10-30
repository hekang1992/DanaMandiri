//
//  HomeViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

class HomeViewModel {
    
    func getHomeInfo(completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager
            .shared
            .getRequest(url: "/taxile/filmably",
                        responseType: BaseModel.self) { result in
                switch result {
                case .success(let success):
                    completion(success)
                    LoadingHUD.shared.hide()
                    break
                case .failure(_):
                    LoadingHUD.shared.hide()
                    let model = BaseModel()
                    completion(model)
                    break
                }
            }
    }
    
    func applyProductInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/himselfform", json: json, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                completion(success)
                LoadingHUD.shared.hide()
                break
            case .failure(_):
                let model = BaseModel()
                completion(model)
                LoadingHUD.shared.hide()
                break
            }
        }
    }
    
    func getAdressInfo(completion: @escaping (BaseModel) -> Void) {
        NetworkManager.shared.getRequest(url: "/taxile/mercveryitious", responseType: BaseModel.self) { result in
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
    
    func uploadSbInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        NetworkManager.shared.postJsonRequest(url: "/taxile/vertindustryent", json: json, responseType: BaseModel.self) { result in
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
