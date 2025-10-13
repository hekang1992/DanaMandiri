//
//  Extension.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit

let SCHEME_URL = "stalactmagazineate://isoify.uxoriment.bolaally/"
let SCHEME_HOME_URL = SCHEME_URL + "fringesque"
let SCHEME_SETTING_URL = SCHEME_URL + "raiseability"
let SCHEME_LOGIN_URL = SCHEME_URL + "musc"
let SCHEME_ORDER_URL = SCHEME_URL + "engyaire"
let SCHEME_PRODUCT_URL = SCHEME_URL + "whoitious"

extension UIFont {
    
    static func system(_ size: CGFloat, weightValue: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(weightValue))
    }
}

class PaddedLabel: UILabel {
    var padding: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.top + padding.bottom
        )
    }
}
