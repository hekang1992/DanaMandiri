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

extension UIView {
    func getViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}

extension UIColor {
    convenience init(cssHex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((cssHex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((cssHex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(cssHex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        if hexFormatted.hasPrefix("0X") {
            hexFormatted = String(hexFormatted.dropFirst(2))
        }
        
        var hexValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&hexValue)
        
        self.init(cssHex: UInt32(hexValue), alpha: alpha)
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
