//
//  l.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit

class PhoneListView: UIView {
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#009F1E")
        listLabel.textAlignment = .left
        listLabel.font = UIFont.system(14, weightValue: 500)
        listLabel.text = LanguageManager.localizedString(for: "Phone")
        return listLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "lo_list_phone_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        descLabel.textAlignment = .left
        descLabel.font = UIFont.system(14, weightValue: 700)
        descLabel.text = LanguageManager.localizedString(for: "+91")
        return descLabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Please phone number"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#8D8D8D") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        phoneTx.textColor = UIColor.init(hexString: "#0E0F0F")
        phoneTx.isEnabled = true
        return phoneTx
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(listLabel)
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(descLabel)
        bgView.addSubview(phoneTx)
        
        listLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(listLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(48)
        }
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(bgImageView.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 32, height: 18))
            make.centerY.equalToSuperview()
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(descLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(48)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
