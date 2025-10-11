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

    enum CodingKeys: String, CodingKey {
        case aboutation
        case filmably
        case salin
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let strValue = try? container.decode(String.self, forKey: .aboutation) {
            aboutation = strValue
        }else if let intValue = try? container.decode(Int.self, forKey: .aboutation) {
            aboutation = String(intValue)
        } else {
            aboutation = nil
        }

        filmably = try? container.decode(String.self, forKey: .filmably)
        salin = try? container.decode(salinModel.self, forKey: .salin)
    }
}


struct salinModel: Codable {
    var cin: String?
    var thatise: String?
    var cast: String?
    var sipirangeular: [sipirangeularModel]?
}

struct sipirangeularModel: Codable {
    var skillette: String?
    var social: [socialModel]?
}

struct socialModel: Codable {
    var alate: String?
    var platyid: String?
    var gnaraster: String?
    var vertindustryent: String?
    var tern: String?
    var multaing: String?
    var able: String?
    var histriie: String?
    var janu: String?
    var minaclike: String?
    var scolieer: String?
    var testth: String?
}
