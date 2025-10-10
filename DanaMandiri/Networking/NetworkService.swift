//
//  NetworkService.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/9.
//

import Foundation
import Alamofire
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return Session(configuration: configuration)
    }()
    
    // MARK: GET
    func getRequest(url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        session.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                completion(response.result)
            }
    }
    
    // MARK: POST JSON
    func postJsonRequest(url: String, json: [String: Any]?, headers: HTTPHeaders? = ["Content-Type": "application/json"], completion: @escaping (Result<Data, AFError>) -> Void) {
        session.upload(multipartFormData: { multipartFormData in
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
    
    // MARK: IMAGE
    func uploadImage(url: String, image: UIImage, parameters: [String: Any]? = nil, imageName: String = "file", headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.25) else {
            return
        }
        
        session.upload(multipartFormData: { multipartFormData in
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
