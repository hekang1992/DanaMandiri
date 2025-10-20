//
//  CommonBpViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CommonBpViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var tapClickBlock: (() -> Void)?
    
    var tapPhoneClickBlock: (() -> Void)?

    var model: sipirangeularModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.evidenceish ?? ""
            
            nameLabel.text = model.lepsie ?? ""
            nameTx.placeholder = model.significant ?? ""
            nameTx.text = model.clastoon ?? ""
            
            phoneLabel.text = model.fluxous ?? ""
            phoneTx.placeholder = model.legment ?? ""
            
            let pachyade = model.pachyade ?? ""
            let merilet = model.merilet ?? ""
            let pn = "\(pachyade)-\(merilet)"
            phoneTx.text = pn == "-" ? "" : pn
            
        }
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(hexString: "#009F1E")
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.system(16, weightValue: 500)
        return titleLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.system(14, weightValue: 500)
        return nameLabel
    }()
    
    lazy var nameTx: UITextField = {
        let nameTx = UITextField()
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Real Name"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#8D8D8D") as Any,
            .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(300))
        ])
        nameTx.attributedPlaceholder = attrString
        nameTx.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        nameTx.textColor = UIColor.init(hexString: "#009F1E")
        nameTx.backgroundColor = .white
        nameTx.layer.cornerRadius = 14
        nameTx.clipsToBounds = true
        nameTx.leftView = UIView(frame: CGRectMake(0, 0, 10, 10))
        nameTx.leftViewMode = .always
        nameTx.isUserInteractionEnabled = false
        nameTx.backgroundColor = UIColor.init(hexString: "#EDF0F2")
        nameTx.rightView = UIView(frame: CGRectMake(0, 0, 40, 40))
        nameTx.rightViewMode = .always
        return nameTx
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "ril_li_image_c")
        return rightImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        phoneLabel.textAlignment = .left
        phoneLabel.font = UIFont.system(14, weightValue: 500)
        return phoneLabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Real Name"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#8D8D8D") as Any,
            .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(300))
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        phoneTx.textColor = UIColor.init(hexString: "#009F1E")
        phoneTx.backgroundColor = .white
        phoneTx.layer.cornerRadius = 14
        phoneTx.clipsToBounds = true
        phoneTx.leftView = UIView(frame: CGRectMake(0, 0, 10, 10))
        phoneTx.leftViewMode = .always
        phoneTx.isUserInteractionEnabled = false
        phoneTx.backgroundColor = UIColor.init(hexString: "#EDF0F2")
        phoneTx.rightView = UIView(frame: CGRectMake(0, 0, 40, 40))
        phoneTx.rightViewMode = .always
        return phoneTx
    }()
    
    lazy var clicPhonekBtn: UIButton = {
        let clicPhonekBtn = UIButton(type: .custom)
        return clicPhonekBtn
    }()
    
    lazy var rightPhoneImageView: UIImageView = {
        let rightPhoneImageView = UIImageView()
        rightPhoneImageView.image = UIImage(named: "ril_li_image_c")
        return rightPhoneImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTx)
        nameTx.addSubview(rightImageView)
        contentView.addSubview(clickBtn)
        
        contentView.addSubview(phoneLabel)
        contentView.addSubview(phoneTx)
        phoneTx.addSubview(rightPhoneImageView)
        contentView.addSubview(clicPhonekBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(18)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        nameTx.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 305, height: 46))
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameTx.snp.centerY)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        clickBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 305, height: 46))
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalTo(nameTx.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
        }
        
        phoneTx.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 305, height: 46))
            make.bottom.equalToSuperview()
        }
        
        rightPhoneImageView.snp.makeConstraints { make in
            make.centerY.equalTo(phoneTx.snp.centerY)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        clicPhonekBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 305, height: 46))
        }
        
        clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.tapClickBlock?()
        }).disposed(by: disposeBag)
        
        clicPhonekBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.tapPhoneClickBlock?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
