//
//  DeleteAccountView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DeleteAccountView: UIView {
    
    let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    
    var exitBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "del_bg_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        oneLabel.textAlignment = .left
        oneLabel.numberOfLines = 0
        oneLabel.font = UIFont.system(16, weightValue: 600)
        oneLabel.text = LanguageManager.localizedString(for: "Confirm to cancel account?")
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        twoLabel.textAlignment = .left
        twoLabel.numberOfLines = 0
        twoLabel.font = UIFont.system(14, weightValue: 300)
        twoLabel.text = LanguageManager.localizedString(for: "Once you cancel your account, all your account information (including but not limited to personal information, loan history, and repayment details) will be permanently deleted and cannot be recovered. In addition, any outstanding loans will be terminated. Please confirm that you have no outstanding loans before continuing.")
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
        exitBtn.setTitle(LanguageManager.localizedString(for: "Log out"), for: .normal)
        exitBtn.setTitleColor(UIColor.init(hexString: "#8D8D8D"), for: .normal)
        exitBtn.titleLabel?.font = UIFont.system(16, weightValue: 600)
        return exitBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "candel_gb_ic"), for: .normal)
        return cancelBtn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var cycleBtn: UIButton = {
        let cycleBtn = UIButton(type: .custom)
        cycleBtn.setImage(UIImage(named: "normal_login_x"), for: .normal)
        cycleBtn.setImage(UIImage(named: "sel_login_x"), for: .selected)
        return cycleBtn
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#009F1E")
        listLabel.textAlignment = .left
        listLabel.font = UIFont.system(12, weightValue: 300)
        listLabel.text = LanguageManager.localizedString(for: "I have read and agree to the above")
        listLabel.numberOfLines = 0
        return listLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(cancelBtn)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(stackView)
        stackView.addArrangedSubview(cycleBtn)
        stackView.addArrangedSubview(listLabel)
        bgImageView.addSubview(againBtn)
        bgImageView.addSubview(exitBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 432))
        }
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(300)
        }
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(15)
            make.width.equalTo(247)
            make.centerX.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(12)
            make.width.equalTo(247)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(34)
        }
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 239, height: 46))
            make.top.equalTo(stackView.snp.bottom).offset(12)
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
        
        cycleBtn.rx.tap.subscribe(onNext: {
            self.cycleBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
