//
//  NetworkService.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/9.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: GET 请求
    func getRequest(url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                completion(response.result)
            }
    }
    
    // MARK: POST JSON 请求
    func postJsonRequest(url: String, json: [String: Any]?, headers: HTTPHeaders? = ["Content-Type": "application/json"], completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
            if let params = json {
                for (key, value) in params {
                    if let str = value as? String, let data = str.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
        }, to: url, headers: headers)
        .validate()
        .responseData { response in
            completion(response.result)
        }
        
    }
    
    // MARK: 图片上传
    func uploadImage(url: String, image: UIImage, parameters: [String: Any]? = nil, imageName: String = "file", headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.25) else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: imageName, fileName: "image.jpg", mimeType: "image/jpeg")
            
            if let params = parameters {
                for (key, value) in params {
                    if let str = value as? String, let data = str.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
        }, to: url, headers: headers)
        .validate()
        .responseData { response in
            completion(response.result)
        }
    }
}
