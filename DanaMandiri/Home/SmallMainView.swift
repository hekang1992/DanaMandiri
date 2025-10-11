//
//  SmallMainView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit
import Kingfisher

class SmallMainView: UIView {
    
    var smallModel: socialModel? {
        didSet {
            guard let smallModel = smallModel else { return }
            listLabel.text = smallModel.alate ?? ""
            oneLabel.text = smallModel.tern ?? ""
            twoLabel.text = smallModel.platyid ?? ""
            threeLabel.text = smallModel.multaing ?? ""
            let able = smallModel.able ?? ""
            let fullText = LanguageManager.localizedString(for: "The daily interest rate is as low as") + " " + able
            let attributedString = NSMutableAttributedString(string: fullText)
            if let range = fullText.range(of: able) {
                let nsRange = NSRange(range, in: fullText)
                attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#0C9C35"), range: nsRange)
            }
            fourLabel.attributedText = attributedString
            
            fiveLabel.text = smallModel.histriie ?? ""
            let janu = smallModel.janu ?? ""
            let full1Text = LanguageManager.localizedString(for: "The term is long") + " " + janu
            let attributed1String = NSMutableAttributedString(string: full1Text)
            if let range = full1Text.range(of: janu) {
                let nsRange = NSRange(range, in: full1Text)
                attributed1String.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#0C9C35"), range: nsRange)
            }
            sixLabel.attributedText = attributed1String
            let logoUrl = smallModel.vertindustryent ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(16, weightValue: 700)
        return listLabel
    }()
    
    lazy var bgmImageView: UIImageView = {
        let bgmImageView = UIImageView()
        bgmImageView.image = UIImage(named: "dl_bg")
        return bgmImageView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "sm_little_image")
        return bgImageView
    }()
    
    lazy var oneLabel: PaddedLabel = {
        let oneLabel = PaddedLabel()
        oneLabel.textColor = UIColor.init(hexString: "#01040C")
        oneLabel.textAlignment = .center
        oneLabel.font = UIFont.system(12, weightValue: 500)
        oneLabel.backgroundColor = UIColor.init(hexString: "#ECDF14")
        oneLabel.layer.borderWidth = 1
        oneLabel.layer.borderColor = UIColor.init(hexString: "#0E0F0F").cgColor
        oneLabel.layer.cornerRadius = 13
        oneLabel.clipsToBounds = true
        oneLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return oneLabel
    }()
    
    lazy var twoLabel: PaddedLabel = {
        let twoLabel = PaddedLabel()
        twoLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        twoLabel.textAlignment = .left
        twoLabel.font = UIFont.system(18, weightValue: 900)
        return twoLabel
    }()
    
    lazy var threeLabel: PaddedLabel = {
        let threeLabel = PaddedLabel()
        threeLabel.textColor = UIColor.init(hexString: "#01040C")
        threeLabel.textAlignment = .center
        threeLabel.font = UIFont.system(12, weightValue: 500)
        threeLabel.backgroundColor = UIColor.init(hexString: "#ECDF14")
        threeLabel.layer.borderWidth = 1
        threeLabel.layer.borderColor = UIColor.init(hexString: "#0E0F0F").cgColor
        threeLabel.layer.cornerRadius = 13
        threeLabel.clipsToBounds = true
        threeLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return threeLabel
    }()
    
    lazy var fourLabel: PaddedLabel = {
        let fourLabel = PaddedLabel()
        fourLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        fourLabel.textAlignment = .left
        fourLabel.font = UIFont.system(12, weightValue: 400)
        return fourLabel
    }()
    
    lazy var fiveLabel: PaddedLabel = {
        let fiveLabel = PaddedLabel()
        fiveLabel.textColor = UIColor.init(hexString: "#01040C")
        fiveLabel.textAlignment = .center
        fiveLabel.font = UIFont.system(12, weightValue: 500)
        fiveLabel.backgroundColor = UIColor.init(hexString: "#ECDF14")
        fiveLabel.layer.borderWidth = 1
        fiveLabel.layer.borderColor = UIColor.init(hexString: "#0E0F0F").cgColor
        fiveLabel.layer.cornerRadius = 13
        fiveLabel.clipsToBounds = true
        fiveLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return fiveLabel
    }()
    
    lazy var sixLabel: PaddedLabel = {
        let sixLabel = PaddedLabel()
        sixLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        sixLabel.textAlignment = .left
        sixLabel.font = UIFont.system(12, weightValue: 400)
        return sixLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgmImageView)
        addSubview(listLabel)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(fourLabel)
        bgImageView.addSubview(fiveLabel)
        bgImageView.addSubview(sixLabel)
        bgImageView.addSubview(logoImageView)
        
        bgmImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: 200, height: 16))
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 305))
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.left.equalToSuperview().offset(31)
            make.height.equalTo(26)
        }
        twoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(oneLabel.snp.bottom).offset(5)
            make.height.equalTo(36)
        }
        threeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(twoLabel.snp.bottom).offset(8)
            make.height.equalTo(26)
        }
        fourLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(threeLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        fiveLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(fourLabel.snp.bottom).offset(8)
            make.height.equalTo(26)
        }
        sixLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(fiveLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.right.equalToSuperview().offset(31)
            make.size.equalTo(CGSize(width: 51, height: 51))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
