//
//  LoginViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/9.
//

class LoginViewModel {
    
    func getCode(json: [String: Any],
                 completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(
            url: "/taxile/leaderad",
            json: json,
            responseType: BaseModel.self) { result in
                switch result {
                case .success(let success):
                    completion(success)
                    ToastProgressHUD.showToastText(message: success.filmably ?? "")
                    LoadingHUD.shared.hide()
                    break
                case .failure(_):
                    LoadingHUD.shared.hide()
                    break
                }
            }
    }
    
    func toLogin(json: [String: Any],
                 completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(
            url: "/taxile/thalam",
            json: json,
            responseType: BaseModel.self) { result in
                switch result {
                case .success(let success):
                    completion(success)
                    ToastProgressHUD.showToastText(message: success.filmably ?? "")
                    LoadingHUD.shared.hide()
                    break
                case .failure(_):
                    LoadingHUD.shared.hide()
                    break
                }
            }
    }
    
}

