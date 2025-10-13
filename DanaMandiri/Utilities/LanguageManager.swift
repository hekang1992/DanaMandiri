//
//  LanguageManager.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import Foundation

enum AppLanguage: String {
    case english = "462"
    case indonesian = "460"
    
    var localeIdentifier: String {
        switch self {
        case .english: return "en"
        case .indonesian: return "id"
        }
    }
}

class LanguageManager {
    static var bundle: Bundle = .main
    
    static func setLanguage(_ language: AppLanguage) {
        if let path = Bundle.main.path(forResource: language.localeIdentifier, ofType: "lproj"),
           let langBundle = Bundle(path: path) {
            bundle = langBundle
        } else {
            bundle = .main
        }
    }
    
    static func localizedString(for key: String) -> String {
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
