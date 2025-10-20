//
//  PopSelectCityInfoView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopSelectCityInfoView: UIView {
    
    let disposeBag = DisposeBag()
    
    var confirmBlock: ((String) -> Void)?
    
    var model: clastoonModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.ctenitive ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pop_info_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "candel_gb_ic"), for: .normal)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.system(16, weightValue: 600)
        return nameLabel
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
    
    lazy var selectLabel: UILabel = {
        let selectLabel = UILabel()
        selectLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        selectLabel.textAlignment = .center
        selectLabel.font = UIFont.system(14, weightValue: 400)
        return selectLabel
    }()
    
    lazy var pickerView: AddressPickerView = {
        let modelArray = CityAddressModel.shared.cityModel?.sipirangeular ?? []
        let pickerView = AddressPickerView(data: modelArray)
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(cancelBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(againBtn)
        bgImageView.addSubview(selectLabel)
        bgImageView.addSubview(pickerView)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 325, height: 395))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(23)
            make.height.equalTo(20)
        }
        
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 239, height: 48))
            make.bottom.equalToSuperview().offset(-23)
        }
        
        selectLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(14)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(selectLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(againBtn.snp.top).offset(-5)
        }
        
        pickerView.onSelectionChanged = { [weak self] province, city, district in
            let selectName = "\(province ?? "") | \(city ?? "") | \(district ?? "")"
            self?.selectLabel.text = selectName
        }
        
        againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.confirmBlock?(self?.selectLabel.text ?? "")
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
