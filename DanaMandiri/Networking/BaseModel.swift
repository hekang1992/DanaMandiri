//
//  Model.swift
//  BaseModel
//
//  Created by Ethan Johnson on 2025/10/9.
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
    
    init(aboutation: String? = nil, filmably: String? = nil, salin: salinModel? = nil) {
        self.aboutation = aboutation
        self.filmably = filmably
        self.salin = salin
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
    var equize: [equizeModel]?
    /// NEXT_URL
    var singleain: String?
    var etharium: ethariumModel?
    var lessast: [lessastModel]?
    var shake: shakeModel?
    var phobthougharian: phobthougharianModel?
    var feliimportant: feliimportantModel?
    var pachyade: String?
    var segetical: String?
    var polyward: String?
    var clastoon: [clastoonModel]?
}

struct sipirangeularModel: Codable {
    var skillette: String?
    var social: [socialModel]?
    var selendom: String? /// finish
    var westernenne: westernenneModel?
    var vertindustryent: String?///logo
    var alate: String?///name
    var natureivity: String?///pageurl
    var toous: String?
    var indiition: String?
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
    var testnature: Int?
}

struct equizeModel: Codable {
    var ctenitive: String?
    var senselike: String?
    var kilolaughish: String?
}

struct westernenneModel: Codable {
    var formatStatus: String?
    var selendom: String?
    var clysmative: String?
    var threeite: String?
    var lepo: String?
    var testth: String?
    var histriie: String?
    var able: String?
    var multaing: String?
    var staritious: String?
    var itiner: String?
    var indiition: String?
}

struct ethariumModel: Codable {
    var standal: standalModel?
    var miritude: String?
    var tergable: String?
    var vertindustryent: String?
    var coprattack: String?
    var rep: String?
    var presentality: String?
}

struct standalModel: Codable {
    var actionish: actionishModel?
    var bothor: bothorModel?
}

struct actionishModel: Codable {
    var ctenitive: String?
    var evidenceish: String?
}

struct bothorModel: Codable {
    var ctenitive: String?
    var evidenceish: String?
}

struct lessastModel: Codable {
    var ctenitive: String?
    var raptaceous: String?
    /// 是否完成
    var articleit: Int?
    var firmacity: String?
    /// 具体的步骤
    var resourceosity: String?
}

struct shakeModel: Codable {
    var resourceosity: String?
    var ctenitive: String?
}

struct phobthougharianModel: Codable {
    var articleit: Int?
    var singleain: String?
    var fullacity: fullacityModel?
     
}

struct fullacityModel: Codable {
    var pachyade: String?
    var segetical: String?
    var polyward: String?
}

struct feliimportantModel: Codable {
    var articleit: Int?
    var singleain: String?
}

struct clastoonModel: Codable {
    var ctenitive: String?
    var raptaceous: String?
    var aboutation: String?
    /// EMUN
    var uxori: String?
    /// 回血的值
    var prehens: String?
    var skillette: String?
    var uncifear: String?
    var aboveent: [aboveentModel]?
}

struct aboveentModel: Codable {
    var pachyade: String?
    var skillette: Int?
}
