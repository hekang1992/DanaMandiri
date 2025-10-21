//
//  NetworkService.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/9.
//

import Foundation
import Alamofire
import UIKit
import DeviceKit

let H5_URL = "http://8.215.85.208:9003"
let BASE_URL = "\(H5_URL)/limacit"

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
    func getRequest<T: Decodable>(
        url: String,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            let apiNormalUrl = BASE_URL + url
            
            let para = APIQueryBuilder.getParameters()
            
            let apiUrl = URLQueryBuilder.appendingQueryParameters(to: apiNormalUrl, parameters: para) ?? ""
            
            session.request(apiUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    // MARK: POST JSON
    func postJsonRequest<T: Decodable>(
        url: String,
        json: [String: Any]?,
        headers: HTTPHeaders? = ["Content-Type": "application/json"],
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            let apiNormalUrl = BASE_URL + url
            
            let para = APIQueryBuilder.getParameters()
            
            let apiUrl = URLQueryBuilder.appendingQueryParameters(to: apiNormalUrl, parameters: para) ?? ""
            
            session.upload(multipartFormData: { multipartFormData in
                if let params = json {
                    for (key, value) in params {
                        if let str = value as? String, let data = str.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                }
            }, to: apiUrl, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    // MARK: IMAGE
    func uploadImage<T: Decodable>(
        url: String,
        image: UIImage,
        parameters: [String: Any]? = nil,
        imageName: String = "habitetic",
        headers: HTTPHeaders? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            guard let imageData = image.jpegData(compressionQuality: 0.25) else {
                return
            }
            
            let apiNormalUrl = BASE_URL + url
            
            let para = APIQueryBuilder.getParameters()
            
            let apiUrl = URLQueryBuilder.appendingQueryParameters(to: apiNormalUrl, parameters: para) ?? ""
            
            session.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: imageName, fileName: "image.jpg", mimeType: "image/jpeg")
                
                if let params = parameters {
                    for (key, value) in params {
                        if let str = value as? String, let data = str.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                }
            }, to: apiUrl, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

struct APIQueryBuilder {
    
    struct Parameters {
        let platform: String = "ios"
        let version: String = "1.0.0"
        let deviceName: String = Device.current.description
        let idfv: String = IDFVManager.shared.getPersistentIDFV() ?? ""
        let systemVersion: String = Device.current.systemVersion ?? ""
        let appID: String = "dana" + "-" + "mandiri"
        let authToken: String = AuthLoginManager.shared.getAuthToken() ?? ""
        let cin: String = CinInfoModel.shared.cinModel?.cin ?? ""
        
        func asDictionary() -> [String: String] {
            var dict: [String: String] = [:]
            dict["lent"] = platform
            dict["amicculture"] = version
            dict["alongability"] = deviceName
            dict["asate"] = idfv
            dict["andency"] = systemVersion
            dict["lapidation"] = appID
            dict["cast"] = authToken
            dict["consumereer"] = idfv
            dict["cin"] = cin
            return dict.filter { !$0.value.isEmpty }
        }
    }
    
    static func getParameters() -> [String: String] {
        return Parameters().asDictionary()
    }
}

struct URLQueryBuilder {
    
    static func appendingQueryParameters(to urlString: String,
                                         parameters: [String: String?]) -> String? {
        guard var components = URLComponents(string: urlString) else { return nil }
        
        let existingItems = components.queryItems ?? []
        
        let newItems = parameters.compactMap { key, value -> URLQueryItem? in
            guard let value = value, !value.isEmpty else { return nil }
            return URLQueryItem(name: key, value: value)
        }
        
        components.queryItems = existingItems + newItems
        
        return components.url?.absoluteString
    }
}
