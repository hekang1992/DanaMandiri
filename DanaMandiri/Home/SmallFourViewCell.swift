//
//  SmallFourViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Kingfisher

class SmallFourViewCell: UITableViewCell {
    
    private static var isProcessingTap = false
    
    let disposeBag = DisposeBag()
    
    var cellTapClick: ((UIButton, String) -> Void)?
    
    var smallModel: socialModel? {
        didSet {
            guard let smallModel = smallModel else { return }
            nameLabel.text = smallModel.alate ?? ""
            let multaing = smallModel.multaing ?? ""
            let testth = smallModel.testth ?? ""
            descLabel.text = "\(multaing)\(" ") | \(" ")\(testth)"
            
            oneLabel.text = smallModel.tern ?? ""
            twoLabel.text = smallModel.platyid ?? ""
            threeLabel.text = smallModel.minaclike ?? ""
            
            let logoUrl = smallModel.vertindustryent ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 4
        logoImageView.clipsToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.system(14, weightValue: 600)
        return nameLabel
    }()
    
    lazy var descLabel: PaddedLabel = {
        let descLabel = PaddedLabel()
        descLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        descLabel.backgroundColor = UIColor.init(hexString: "#009F1E").withAlphaComponent(0.12)
        descLabel.textAlignment = .center
        descLabel.font = UIFont.system(13, weightValue: 500)
        descLabel.textColor = UIColor.init(hexString: "#009F1E")
        descLabel.layer.cornerRadius = 6
        descLabel.clipsToBounds = true
        return descLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        oneLabel.textAlignment = .left
        oneLabel.font = UIFont.system(14, weightValue: 400)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        twoLabel.textAlignment = .left
        twoLabel.font = UIFont.system(16, weightValue: 700)
        return twoLabel
    }()
    
    lazy var threeLabel: PaddedLabel = {
        let threeLabel = PaddedLabel()
        threeLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        threeLabel.backgroundColor = UIColor.init(hexString: "#009F1E")
        threeLabel.textAlignment = .center
        threeLabel.font = UIFont.system(14, weightValue: 600)
        threeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        threeLabel.layer.cornerRadius = 19
        threeLabel.clipsToBounds = true
        return threeLabel
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.isEnabled = true
        return clickBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        bgView.addSubview(threeLabel)
        bgView.addSubview(clickBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(116)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 26, height: 26))
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(16)
        }
        
        descLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(28)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(logoImageView.snp.bottom).offset(15)
            make.height.equalTo(14)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(oneLabel.snp.bottom).offset(8)
            make.height.equalTo(14)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(38)
        }
        
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clickBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self, let smallModel = self.smallModel else { return }
                
                guard !SmallFourViewCell.isProcessingTap else { return }
                
                SmallFourViewCell.isProcessingTap = true
                self.clickBtn.isEnabled = false
                
                self.cellTapClick?(self.clickBtn, String(smallModel.testnature ?? 0))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    SmallFourViewCell.isProcessingTap = false
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
