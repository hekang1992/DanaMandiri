//
//  PersonalImageView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture
import RxCocoa

class PersonalImageView: UIView {
    
    let disposeBag = DisposeBag()
    
    var uploadBlock: ((BaseModel) -> Void)?
    
    var nextBlock: ((BaseModel) -> Void)?
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            let idArticleit = model.salin?.phobthougharian?.articleit ?? 0
            if idArticleit == 1 {
                listLabel.text = "✓" + " " + "\(LanguageManager.localizedString(for: "Uploaded"))"
            }else {
                listLabel.text = LanguageManager.localizedString(for: "Click to upload")
            }
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
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        bgImageView.image = cin == "460" ? UIImage(named: "sfz_t_yn") : UIImage(named: "sfz_t_yn")
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        typeImageView.image = cin == "460" ? UIImage(named: "id_one_image") : UIImage(named: "en_one_image")
        return typeImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "no_cli_pe_image")
        return logoImageView
    }()
    
    lazy var listLabel: PaddedLabel = {
        let listLabel = PaddedLabel()
        listLabel.textColor = UIColor.init(hexString: "#009F1E")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(14, weightValue: 500)
        listLabel.layer.borderWidth = 1
        listLabel.layer.borderColor = UIColor.init(hexString: "#009F1E").cgColor
        listLabel.clipsToBounds = true
        listLabel.layer.cornerRadius = 19
        listLabel.padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return listLabel
    }()
    
    lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        errorLabel.textAlignment = .left
        errorLabel.font = UIFont.system(14, weightValue: 400)
        errorLabel.text = LanguageManager.localizedString(for: "Error example")
        return errorLabel
    }()
    
    lazy var errorImageView: UIImageView = {
        let errorImageView = UIImageView()
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        errorImageView.image = cin == "460" ? UIImage(named: "erros_id_image_bg") : UIImage(named: "erros_image_bg")
        return errorImageView
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Next Step"), for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 600)
        againBtn.layer.cornerRadius = 25
        againBtn.backgroundColor = UIColor.init(hexString: "#009F1E")
        return againBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(bgView)
        bgView.addSubview(typeImageView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(listLabel)
        bgView.addSubview(errorLabel)
        bgView.addSubview(errorImageView)
        bgView.addSubview(againBtn)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 60))
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(11)
            make.size.equalTo(CGSize(width: 335, height: 570))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        typeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(282)
            make.top.equalToSuperview().offset(24)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(typeImageView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 240, height: 164))
        }
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
        }
        errorLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(listLabel.snp.bottom).offset(20)
            make.height.equalTo(14)
        }
        errorImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(errorLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 305, height: 101))
        }
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 305, height: 50))
            make.top.equalTo(errorImageView.snp.bottom).offset(31)
        }
        
        listLabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self, let model = model else { return }
            self.uploadBlock?(model)
        }).disposed(by: disposeBag)
        
        againBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let model = model else { return }
            self.nextBlock?(model)
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
