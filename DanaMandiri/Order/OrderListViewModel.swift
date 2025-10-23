//
//  OrderListViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

class OrderListViewModel {
    
    func getOrderListInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/social", json: json, responseType: BaseModel.self) { result in
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
