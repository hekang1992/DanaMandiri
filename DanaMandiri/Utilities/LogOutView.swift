//
//  LogOutView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LogOutView: UIView {
    
    let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    
    var exitBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "out_bg_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        oneLabel.textAlignment = .left
        oneLabel.font = UIFont.system(16, weightValue: 600)
        oneLabel.text = LanguageManager.localizedString(for: "Confirm to exit?")
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        twoLabel.textAlignment = .left
        twoLabel.numberOfLines = 0
        twoLabel.font = UIFont.system(14, weightValue: 300)
        twoLabel.text = LanguageManager.localizedString(for: "Are you sure you want to exit the loan app? If you have outstanding loans, you can log in at any time to check your repayment progress.")
        return twoLabel
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Cancel"), for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 600)
        againBtn.layer.cornerRadius = 24
        againBtn.layer.borderWidth = 1
        againBtn.layer.borderColor = UIColor.black.cgColor
        againBtn.backgroundColor = UIColor.init(hexString: "#009F1E")
        againBtn.setTitleColor(.white, for: .normal)
        return againBtn
    }()
    
    lazy var exitBtn: UIButton = {
        let exitBtn = UIButton(type: .custom)
        exitBtn.setTitle(LanguageManager.localizedString(for: "Exit"), for: .normal)
        exitBtn.setTitleColor(UIColor.init(hexString: "#8D8D8D"), for: .normal)
        exitBtn.titleLabel?.font = UIFont.system(16, weightValue: 600)
        return exitBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "candel_gb_ic"), for: .normal)
        return cancelBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(cancelBtn)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(againBtn)
        bgImageView.addSubview(exitBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 263))
        }
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(20)
            make.width.equalTo(300)
        }
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(10)
            make.width.equalTo(247)
            make.centerX.equalToSuperview()
        }
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 239, height: 46))
            make.top.equalTo(twoLabel.snp.bottom).offset(15)
        }
        exitBtn.snp.makeConstraints { make in
            make.top.equalTo(againBtn.snp.bottom)
            make.bottom.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview()
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        cancelBtn.rx.tap.subscribe(onNext: {
            self.cancelBlock?()
        }).disposed(by: disposeBag)
        
        againBtn.rx.tap.subscribe(onNext: {
            self.cancelBlock?()
        }).disposed(by: disposeBag)
        
        exitBtn.rx.tap.subscribe(onNext: {
            self.exitBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
