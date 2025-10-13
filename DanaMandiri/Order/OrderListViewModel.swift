//
//  OrderListViewModel.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/13.
//

class OrderListViewModel {
    
    func getOrderListInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.show(text: "Loading...")
        NetworkManager.shared.postJsonRequest(url: "/taxile/social", json: json, responseType: BaseModel.self) { result in
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
