//
//  SmallOneViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa
import RxGesture

class SmallTwoViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var tapClickBlock: ((UIButton, String) -> Void)?
    
    var smallModel: socialModel? {
        didSet {
            guard let smallModel = smallModel else { return }
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
            
            let minaclike = smallModel.minaclike ?? ""
            applyLabel.text = "\(minaclike) >"
        }
    }

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "sm_little_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton()
        clickBtn.isEnabled = true
        return clickBtn
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
        logoImageView.layer.cornerRadius = 4
        logoImageView.clipsToBounds = true
        return logoImageView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        applyLabel.textAlignment = .center
        applyLabel.font = UIFont.system(16, weightValue: 700)
        applyLabel.layer.cornerRadius = 25
        applyLabel.clipsToBounds = true
        applyLabel.backgroundColor = UIColor.init(hexString: "#0BA334")
        applyLabel.layer.borderWidth = 2
        applyLabel.layer.borderColor = UIColor.black.cgColor
        return applyLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(fourLabel)
        bgImageView.addSubview(fiveLabel)
        bgImageView.addSubview(sixLabel)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(applyLabel)
        bgImageView.addSubview(clickBtn)
    
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 305))
            make.bottom.equalToSuperview().offset(-5)
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
            make.right.equalToSuperview().offset(-31)
            make.size.equalTo(CGSize(width: 51, height: 51))
        }
        applyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-16)
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.tapClickBlock?(self?.clickBtn ?? UIButton(), String(self?.smallModel?.testnature ?? 0))
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

