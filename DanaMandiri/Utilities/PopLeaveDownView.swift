//
//  PopLeaveDownView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopLeaveDownView: UIView {
    
    let disposeBag = DisposeBag()
    
    var leaveBlock: (() -> Void)?
    
    var cancelBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        bgImageView.image = cin == "460" ? UIImage(named: "leave_bg_id_image") : UIImage(named: "leave_bg_en_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "candel_gb_ic"), for: .normal)
        return cancelBtn
    }()
    
    lazy var headBtn: UIButton = {
        let headBtn = UIButton(type: .custom)
        return headBtn
    }()
    
    lazy var footBtn: UIButton = {
        let footBtn = UIButton(type: .custom)
        return footBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(headBtn)
        bgImageView.addSubview(footBtn)
        addSubview(cancelBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 322))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        footBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(46)
        }
        
        headBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(footBtn.snp.top)
            make.height.equalTo(46)
        }
        
        cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.leaveBlock?()
        }).disposed(by: disposeBag)
        
        footBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.cancelBlock?()
        }).disposed(by: disposeBag)
        
        headBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.leaveBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
