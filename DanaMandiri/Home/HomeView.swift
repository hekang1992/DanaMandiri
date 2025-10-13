//
//  HomeView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa
import RxGesture

class HomeView: UIView {
    
    let disposeBag = DisposeBag()
    
    var applyBlock: (() -> Void)?
    
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(16, weightValue: 700)
        return listLabel
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.contentMode = .scaleAspectFit
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        headImageView.image = cin == "460" ? UIImage(named: "sy_banner_yn") : UIImage(named: "sy_banner")
        return headImageView
    }()
    
    /// CLICK_DIJI_INFO
    lazy var bigImageView: UIImageView = {
        let bigImageView = UIImageView()
        bigImageView.image = UIImage(named: "home_bgmi_image")
        bigImageView.isUserInteractionEnabled = true
        return bigImageView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "one_de_bg_image")
        return descImageView
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
        twoLabel.font = UIFont.system(36, weightValue: 900)
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
        fourLabel.numberOfLines = 0
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
        sixLabel.numberOfLines = 0
        return sixLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.backgroundColor = .purple
        return logoImageView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.textAlignment = .center
        applyLabel.font = UIFont.system(16, weightValue: 800)
        applyLabel.layer.cornerRadius = 22
        applyLabel.clipsToBounds = true
        applyLabel.backgroundColor = UIColor.init(hexString: "#009F1E")
        applyLabel.layer.borderWidth = 2
        applyLabel.layer.borderColor = UIColor.black.cgColor
        applyLabel.isUserInteractionEnabled = true
        return applyLabel
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "ima_home_image")
        return threeImageView
    }()
    
    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "cc_yhq_image")
        return fourImageView
    }()
    
    lazy var fiveImageView: UIImageView = {
        let fiveImageView = UIImageView()
        fiveImageView.image = UIImage(named: "foot_b_bg")
        return fiveImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(listLabel)
        addSubview(scrollView)
        scrollView.addSubview(headImageView)
        scrollView.addSubview(bigImageView)
        bigImageView.addSubview(oneLabel)
        bigImageView.addSubview(twoLabel)
        bigImageView.addSubview(threeLabel)
        bigImageView.addSubview(fourLabel)
        bigImageView.addSubview(fiveLabel)
        bigImageView.addSubview(sixLabel)
        bigImageView.addSubview(applyLabel)
        bigImageView.addSubview(logoImageView)
        scrollView.addSubview(descImageView)
        scrollView.addSubview(threeImageView)
        scrollView.addSubview(fourImageView)
        scrollView.addSubview(fiveImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: 200, height: 1))
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(335)
        }
        
        bigImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 335, height: 348))
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(41)
            make.left.equalToSuperview().offset(72)
            make.height.equalTo(26)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel.snp.left)
            make.top.equalTo(oneLabel.snp.bottom).offset(9)
            make.height.equalTo(36)
        }
        threeLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel.snp.left)
            make.top.equalTo(twoLabel.snp.bottom).offset(8)
            make.height.equalTo(26)
        }
        fourLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel.snp.left)
            make.top.equalTo(threeLabel.snp.bottom).offset(8)
            make.width.equalTo(191)
        }
        fiveLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel.snp.left)
            make.top.equalTo(fourLabel.snp.bottom).offset(8)
            make.height.equalTo(26)
        }
        sixLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel.snp.left)
            make.top.equalTo(fiveLabel.snp.bottom).offset(8)
            make.width.equalTo(191)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-29)
            make.size.equalTo(CGSize(width: 51, height: 51))
        }
        applyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(oneLabel.snp.left)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-42)
        }
        
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(bigImageView.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 204, height: 36))
        }
        threeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 335, height: 215))
        }
        fourImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeImageView.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 335, height: 79))
        }
        fiveImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fourImageView.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 335, height: 88))
            make.bottom.equalToSuperview().offset(-10)
        }
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        if cin == "460" {
            descImageView.snp.remakeConstraints { make in
                make.top.equalTo(bigImageView.snp.bottom).offset(0)
                make.left.equalToSuperview()
                make.size.equalTo(CGSize(width: 204, height: 0))
            }
            threeImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(descImageView.snp.bottom).offset(0)
                make.size.equalTo(CGSize(width: 335, height: 0))
            }
            fourImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(threeImageView.snp.bottom).offset(0)
                make.size.equalTo(CGSize(width: 335, height: 0))
            }
            fiveImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(fourImageView.snp.bottom).offset(12)
                make.size.equalTo(CGSize(width: 335, height: 88))
                make.bottom.equalToSuperview().offset(-10)
            }
        }else {
            descImageView.snp.remakeConstraints { make in
                make.top.equalTo(bigImageView.snp.bottom).offset(15)
                make.left.equalToSuperview()
                make.size.equalTo(CGSize(width: 204, height: 36))
            }
            threeImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(descImageView.snp.bottom).offset(15)
                make.size.equalTo(CGSize(width: 335, height: 215))
            }
            fourImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(threeImageView.snp.bottom).offset(12)
                make.size.equalTo(CGSize(width: 335, height: 79))
            }
            fiveImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(fourImageView.snp.bottom).offset(12)
                make.size.equalTo(CGSize(width: 335, height: 88))
                make.bottom.equalToSuperview().offset(-10)
            }
        }
        
        bigImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
            self.applyBlock?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
