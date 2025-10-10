//
//  LoginView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(hexString: "#E7FFEB")
        bgView.layer.cornerRadius = 28
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var liImageView: UIImageView = {
        let liImageView = UIImageView()
        liImageView.contentMode = .scaleAspectFit
        return liImageView
    }()
    
    lazy var phoneListView: PhoneListView = {
        let phoneListView = PhoneListView()
        return phoneListView
    }()
    
    lazy var phoneCodeView: PhoneCodeView = {
        let phoneCodeView = PhoneCodeView()
        return phoneCodeView
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Log In"), for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 700)
        againBtn.setBackgroundImage(UIImage(named: "login_bg_image"), for: .normal)
        return againBtn
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "login_logo_image")
        return footImageView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(16, weightValue: 700)
        listLabel.text = "Dana Mandiri"
        return listLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(scrollView)
        scrollView.addSubview(bgView)
        bgView.addSubview(liImageView)
        bgView.addSubview(phoneListView)
        bgView.addSubview(phoneCodeView)
        bgView.addSubview(againBtn)
        scrollView.addSubview(footImageView)
        scrollView.addSubview(listLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 474))
        }
        liImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(44)
            make.size.equalTo(CGSize(width: 237, height: 52))
        }
        
        phoneListView.snp.makeConstraints { make in
            make.top.equalTo(liImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(76)
        }
        
        phoneCodeView.snp.makeConstraints { make in
            make.top.equalTo(phoneListView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(76)
        }
        
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneCodeView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(50)
        }
        
        footImageView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        listLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(footImageView.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 220, height: 20))
            make.bottom.equalToSuperview().offset(-50)
        }
        
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        if cin == "460" {
            liImageView.image = UIImage(named: "id_desc_image")
        }else {
            liImageView.image = UIImage(named: "in_desc_image")
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
