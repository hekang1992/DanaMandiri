//
//  Untitled.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/11.
//

class CenterListViewModel {
    
    func getCenterInfo(completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.show(text: "Loading...")
        NetworkManager.shared.getRequest(url: "/taxile/thatise", responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingHUD.hide()
                completion(success)
                break
            case .failure(let failure):
                LoadingHUD.hide()
                break
            }
        }
    }
    
}
