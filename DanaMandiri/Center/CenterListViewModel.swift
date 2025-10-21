//
//  Untitled.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

class CenterListViewModel {
    
    func getCenterInfo(completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.show()
        NetworkManager.shared.getRequest(url: "/taxile/thatise", responseType: BaseModel.self) { result in
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
