//
//  l.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit
import SnapKit

class PhoneCodeView: UIView {
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#009F1E")
        listLabel.textAlignment = .left
        listLabel.font = UIFont.system(14, weightValue: 500)
        listLabel.text = LanguageManager.localizedString(for: "Verification code")
        return listLabel
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Code"), for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.system(14, weightValue: 600)
        againBtn.setBackgroundImage(UIImage(named: "code_bg_image"), for: .normal)
        return againBtn
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
        bgImageView.image = UIImage(named: "li_list_code_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Please Verification code"), attributes: [
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
        addSubview(againBtn)
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(phoneTx)
        
        listLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        againBtn.snp.makeConstraints { make in
            make.centerY.equalTo(listLabel.snp.centerY)
            make.right.equalToSuperview().offset(-24)
            make.size.equalTo(CGSize(width: 64, height: 28))
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
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(bgImageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(48)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
