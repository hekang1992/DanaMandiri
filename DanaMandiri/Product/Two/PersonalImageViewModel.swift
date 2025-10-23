//
//  PersonalImageViewModel.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/14.
//

import UIKit

class PersonalImageViewModel {
    
    /// 获取身份信息
    func getPersonalInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.getRequest(url: "/taxile/spatishowee", parameters: json, responseType: BaseModel.self) { result in
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
    
    /// UPLOAD_IMAGE_INFO
    func uploadPersonalImageInfo(with json: [String: Any], image: UIImage, completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.uploadImage(url: "/taxile/collegeety", image: image, parameters: json, responseType: BaseModel.self) { result in
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
    
    /// SAVE_IMAGE_INFO
    func savePersonalInfo(with json: [String: Any], completion: @escaping (BaseModel) -> Void) {
        LoadingHUD.shared.show()
        NetworkManager.shared.postJsonRequest(url: "/taxile/articleit", json: json, responseType: BaseModel.self) { result in
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
