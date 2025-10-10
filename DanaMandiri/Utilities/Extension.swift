//
//  Extension.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit

extension UIFont {
    
    static func system(_ size: CGFloat, weightValue: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(weightValue))
    }
}
