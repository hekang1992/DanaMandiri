//
//  Model.swift
//  BaseModel
//
//  Created by hekang on 2025/10/9.
//

struct BaseModel: Codable {
    var aboutation: String?
    var filmably: String?
    var salin: salinModel?
}

struct salinModel: Codable {
    var cin: String?
}
