//
//  PopSelectTimeInfoView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopSelectTimeInfoView: UIView {
    
    let disposeBag = DisposeBag()
    
    var confirmBlock: ((String) -> Void)?
    
    var defaultDateString: String? {
        didSet {
            applyDefaultDate()
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
        nameLabel.textColor = UIColor(hexString: "#0E0F0F")
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.system(16, weightValue: 600)
        nameLabel.text = LanguageManager.localizedString(for: "Select Date")
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
        againBtn.backgroundColor = UIColor(hexString: "#009F1E")
        return againBtn
    }()
    
    lazy var selectLabel: UILabel = {
        let selectLabel = UILabel()
        selectLabel.textColor = UIColor(hexString: "#0E0F0F")
        selectLabel.textAlignment = .center
        selectLabel.font = UIFont.system(14, weightValue: 400)
        return selectLabel
    }()
    
    let pickerView: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .date
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "id_ID")
        pickerView.calendar = Calendar(identifier: .gregorian)
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
        applyDefaultDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
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
        
        selectLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(18)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(selectLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(againBtn.snp.top).offset(-10)
        }
        
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 239, height: 48))
            make.bottom.equalToSuperview().offset(-23)
        }
    }
    
    private func setupActions() {
        pickerView.rx.date
            .subscribe(onNext: { [weak self] date in
                guard let self = self else { return }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.selectLabel.text = formatter.string(from: date)
            })
            .disposed(by: disposeBag)
        
        againBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let dateString = formatter.string(from: self.pickerView.date)
                self.confirmBlock?(dateString)
            })
            .disposed(by: disposeBag)
    }
    
    private func applyDefaultDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        
        if defaultDateString == "//" {
            defaultDateString = "25/12/1970"
        }
        
        let dateStr = (defaultDateString?.isEmpty == false) ? defaultDateString! : "25/12/1970"
        if let date = formatter.date(from: dateStr) {
            pickerView.setDate(date, animated: false)
            selectLabel.text = formatter.string(from: date)
        } else {
            let defaultDate = formatter.date(from: "25/12/1970")!
            pickerView.setDate(defaultDate, animated: false)
            selectLabel.text = formatter.string(from: defaultDate)
        }
    }
}

