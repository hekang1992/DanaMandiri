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
    
    init(aboutation: String? = nil,
         filmably: String? = nil,
         salin: salinModel? = nil,
         terrtrialistic: terrtrialisticModel? = nil) {
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
    var toughel: toughelModel?
    var recordenne: recordenneModel?
    var terrtrialistic: terrtrialisticModel?
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
    /// PROVICE_INFO
    var pachyade: String?
    var lampetic: [lampeticModel]?
    var evidenceish: String?
    var lepsie: String?
    var significant: String?
    var fluxous: String?
    var legment: String?
    var fallacy: String?
    var merilet: String?
    var phytfew: String?/// 1 2
    var archile: [aboveentModel]?
    var clastoon: String?
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
    var ctenitive: String?
    var filmably: String?
    var singleain: String?
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
    var tentsure: Int?
    
    enum CodingKeys: String, CodingKey {
        case standal, miritude, tergable, vertindustryent, coprattack, rep, presentality, tentsure
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        miritude = try? container.decode(String.self, forKey: .miritude)
        vertindustryent = try? container.decode(String.self, forKey: .vertindustryent)
        coprattack = try? container.decode(String.self, forKey: .coprattack)
        rep = try? container.decode(String.self, forKey: .rep)
        presentality = try? container.decode(String.self, forKey: .presentality)
        tentsure = try? container.decode(Int.self, forKey: .tentsure)
        standal = try? container.decode(standalModel.self, forKey: .standal)

        if let intValue = try? container.decode(Int.self, forKey: .tergable) {
            tergable = String(intValue)
        } else if let strValue = try? container.decode(String.self, forKey: .tergable) {
            tergable = strValue
        } else {
            tergable = nil
        }
    }
    
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
    var uxori: String?
    var prehens: String?
    var skillette: String?
    var uncifear: String?
    var aboveent: [aboveentModel]?

    enum CodingKeys: String, CodingKey {
        case ctenitive, raptaceous, aboutation, uxori, prehens, skillette, uncifear, aboveent
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ctenitive = try? container.decode(String.self, forKey: .ctenitive)
        raptaceous = try? container.decode(String.self, forKey: .raptaceous)
        aboutation = try? container.decode(String.self, forKey: .aboutation)
        uxori = try? container.decode(String.self, forKey: .uxori)
        prehens = try? container.decode(String.self, forKey: .prehens)
        skillette = try? container.decode(String.self, forKey: .skillette)
        aboveent = try? container.decode([aboveentModel].self, forKey: .aboveent)

        if let intValue = try? container.decode(Int.self, forKey: .uncifear) {
            uncifear = String(intValue)
        } else if let strValue = try? container.decode(String.self, forKey: .uncifear) {
            uncifear = strValue
        } else {
            uncifear = nil
        }
    }
}

struct aboveentModel: Codable {
    var pachyade: String?
    var skillette: String?
    
    enum CodingKeys: String, CodingKey {
        case pachyade, skillette
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pachyade = try container.decodeIfPresent(String.self, forKey: .pachyade)
        if let intValue = try? container.decode(Int.self, forKey: .skillette) {
            skillette = String(intValue)
        } else if let stringValue = try? container.decode(String.self, forKey: .skillette) {
            skillette = stringValue
        } else {
            skillette = nil
        }
    }
}

struct lampeticModel: Codable {
    /// CITY_INFO
    var pachyade: String?
    var lampetic: [lampeticModel]?
}

struct toughelModel: Codable {
    var sipirangeular: [sipirangeularModel]?
}

struct terrtrialisticModel: Codable {
    var cystence: String?
    var capite: String?
    var genperiod: String?
    var xylant: String?
}

struct recordenneModel: Codable {
    var anteaneity: [anteaneityModel]?
}

struct anteaneityModel: Codable {
    var veracitoption: String?
    var singleain: String?
}
