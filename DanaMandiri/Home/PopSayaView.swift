//
//  PopSayaView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopSayaView: UIView {
    
    var oneBlock: ((String) -> Void)?
    var twoBlock: ((String) -> Void)?
    
    var modelArray: [anteaneityModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            oneBtn.setTitle(modelArray.first?.veracitoption ?? "", for: .normal)
            twoBtn.setTitle(modelArray.last?.veracitoption ?? "", for: .normal)
        }
    }
    
    let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "out_bg_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.backgroundColor = UIColor.init(hexString: "#009F1E")
        oneBtn.layer.borderWidth = 1.5
        oneBtn.layer.borderColor = UIColor.init(hexString: "#0E0F0F").cgColor
        oneBtn.layer.cornerRadius = 23
        oneBtn.setTitleColor(UIColor.white, for: .normal)
        oneBtn.titleLabel?.font = UIFont.system(16, weightValue: 700)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.backgroundColor = UIColor.clear
        twoBtn.layer.borderWidth = 1.5
        twoBtn.layer.borderColor = UIColor.init(hexString: "#009F1E").cgColor
        twoBtn.layer.cornerRadius = 23
        twoBtn.setTitleColor(UIColor.init(hexString: "#009F1E"), for: .normal)
        twoBtn.titleLabel?.font = UIFont.system(16, weightValue: 700)
        return twoBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "candel_gb_ic"), for: .normal)
        return cancelBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        addSubview(cancelBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 263))
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        oneBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 239, height: 46))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-65)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 239, height: 46))
        }
        
        cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.cancelBlock?()
        }).disposed(by: disposeBag)
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.oneBlock?(self?.modelArray?.first?.singleain ?? "")
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.twoBlock?(self?.modelArray?.last?.singleain ?? "")
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
