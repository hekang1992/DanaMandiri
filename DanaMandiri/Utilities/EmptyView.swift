//
//  EmptyView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

import UIKit
import SnapKit

class EmptyView: UIView {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ko_image_ic")
        return bgImageView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(14, weightValue: 400)
        listLabel.text = LanguageManager.localizedString(for: "No order yet")
        return listLabel
    }()
    
    lazy var borrowLabel: UILabel = {
        let borrowLabel = UILabel()
        borrowLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        borrowLabel.textAlignment = .center
        borrowLabel.font = UIFont.system(14, weightValue: 600)
        borrowLabel.text = LanguageManager.localizedString(for: "Borrow")
        borrowLabel.layer.cornerRadius = 19
        borrowLabel.layer.borderWidth = 1
        borrowLabel.layer.borderColor = UIColor.white.cgColor
        return borrowLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(listLabel)
        addSubview(borrowLabel)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.size.equalTo(CGSize(width: 162, height: 102))
            make.centerX.equalToSuperview()
        }
        listLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView.snp.bottom).offset(14)
            make.height.equalTo(14)
        }
        borrowLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(listLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 100, height: 38))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
