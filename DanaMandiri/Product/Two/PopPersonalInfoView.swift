//
//  PopPersonalInfoView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture

class PopPersonalInfoView: UIView {
    
    var timeBlock: ((String) -> Void)?
    
    let disposeBag = DisposeBag()
    
    var model: salinModel? {
        didSet {
            guard let model = model else { return }
            nameTx.text = model.pachyade ?? ""
            idNumberTx.text = model.segetical ?? ""
            timeLabel.text = model.polyward ?? ""
        }
    }

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "su_person_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "candel_gb_ic"), for: .normal)
        return cancelBtn
    }()
    
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
        listLabel.font = UIFont.system(16, weightValue: 600)
        listLabel.text = LanguageManager.localizedString(for: "Confirm Information")
        return listLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hexString: "#009F1E")
        oneLabel.textAlignment = .left
        oneLabel.font = UIFont.system(14, weightValue: 500)
        oneLabel.text = LanguageManager.localizedString(for: "Real Name")
        return oneLabel
    }()
    
    lazy var nameTx: UITextField = {
        let nameTx = UITextField()
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Real Name"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#8D8D8D") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        ])
        nameTx.attributedPlaceholder = attrString
        nameTx.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        nameTx.textColor = UIColor.init(hexString: "#0E0F0F")
        nameTx.backgroundColor = .white
        nameTx.layer.cornerRadius = 14
        nameTx.clipsToBounds = true
        nameTx.leftView = UIView(frame: CGRectMake(0, 0, 10, 10))
        nameTx.leftViewMode = .always
        return nameTx
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hexString: "#009F1E")
        twoLabel.textAlignment = .left
        twoLabel.font = UIFont.system(14, weightValue: 500)
        twoLabel.text = LanguageManager.localizedString(for: "ID Number")
        return twoLabel
    }()
    
    lazy var idNumberTx: UITextField = {
        let idNumberTx = UITextField()
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "ID Number"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#8D8D8D") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        ])
        idNumberTx.attributedPlaceholder = attrString
        idNumberTx.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        idNumberTx.textColor = UIColor.init(hexString: "#0E0F0F")
        idNumberTx.backgroundColor = .white
        idNumberTx.layer.cornerRadius = 14
        idNumberTx.clipsToBounds = true
        idNumberTx.leftView = UIView(frame: CGRectMake(0, 0, 10, 10))
        idNumberTx.leftViewMode = .always
        return idNumberTx
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textColor = UIColor.init(hexString: "#009F1E")
        threeLabel.textAlignment = .left
        threeLabel.font = UIFont.system(14, weightValue: 500)
        threeLabel.text = LanguageManager.localizedString(for: "Birthday")
        return threeLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        timeLabel.textAlignment = .left
        timeLabel.font = UIFont.system(13, weightValue: 500)
        return timeLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "ril_li_image_c")
        return rightImageView
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Confirming"), for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 700)
        againBtn.layer.cornerRadius = 24
        againBtn.layer.borderWidth = 1
        againBtn.layer.borderColor = UIColor.black.cgColor
        againBtn.backgroundColor = UIColor.init(hexString: "#009F1E")
        return againBtn
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(hexString: "#EC1812")
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.system(10, weightValue: 300)
        descLabel.text = LanguageManager.localizedString(for: "*Please check your lD information correctly, oncesubmitted it is not changed again")
        return descLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(cancelBtn)
        bgImageView.addSubview(listLabel)
        bgImageView.addSubview(scrollView)
        scrollView.addSubview(oneLabel)
        scrollView.addSubview(twoLabel)
        scrollView.addSubview(threeLabel)
        scrollView.addSubview(nameTx)
        scrollView.addSubview(idNumberTx)
        scrollView.addSubview(bgView)
        bgView.addSubview(timeLabel)
        bgView.addSubview(rightImageView)
        scrollView.addSubview(againBtn)
        scrollView.addSubview(descLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 325, height: 452))
            make.center.equalToSuperview()
        }
        
        listLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(23)
            make.height.equalTo(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        oneLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        nameTx.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 285, height: 46))
        }
        
        twoLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalTo(nameTx.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        idNumberTx.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 285, height: 46))
        }
        
        threeLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalTo(idNumberTx.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(threeLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 285, height: 46))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-10)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(16, 16))
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 240, height: 48))
            make.top.equalTo(bgView.snp.bottom).offset(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(289)
            make.top.equalTo(againBtn.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        timeLabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.timeBlock?(self?.timeLabel.text ?? "")
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

