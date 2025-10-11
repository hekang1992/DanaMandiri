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
