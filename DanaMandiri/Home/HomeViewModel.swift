//
//  HomeViewModel.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

class HomeViewModel {
    
    func getHomeInfo(completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.show(text: "Loading...")
        NetworkManager
            .shared
            .getRequest(url: "/taxile/filmably",
                        responseType: BaseModel.self) { result in
                switch result {
                case .success(let success):
                    completion(success)
                    LoadingHUD.hide()
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
