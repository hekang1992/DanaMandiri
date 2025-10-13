//
//  SmallThreeCollectionViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

import UIKit
import SnapKit
import FSPagerView

class SmallThreeCollectionViewCell: FSPagerViewCell {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pa_l_image")
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 71))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
