//
//  ProductViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

class ProductViewModel {
    
    func getProductDetailInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.show(text: "Loading...")
        NetworkManager.shared.postJsonRequest(url: "/taxile/determine", json: json, responseType: BaseModel.self) { result in
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
    
}
