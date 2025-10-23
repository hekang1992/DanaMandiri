//
//  ProductViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

class ProductViewModel {
    
    func getProductDetailInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/determine", json: json, responseType: BaseModel.self) { result in
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
    
    func orderInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/skillette", json: json, responseType: BaseModel.self) { result in
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
