//
//  BothComleteView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture
import RxCocoa
import Kingfisher

class BothComleteView: UIView {
    
    let disposeBag = DisposeBag()
    
    var uploadBlock: ((BaseModel) -> Void)?
    
    var nextBlock: ((BaseModel) -> Void)?
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            leftImageView.kf.setImage(with: URL(string: model.salin?.phobthougharian?.singleain ?? ""))
            rightImageView.kf.setImage(with: URL(string: model.salin?.feliimportant?.singleain ?? ""))
            nameTx.text = model.salin?.phobthougharian?.fullacity?.pachyade ?? ""
            idNumberTx.text = model.salin?.phobthougharian?.fullacity?.segetical ?? ""
            timeLabel.text = model.salin?.phobthougharian?.fullacity?.polyward ?? ""
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
        typeImageView.image = cin == "460" ? UIImage(named: "btio_image_id_bg") : UIImage(named: "btio_image_en_bg")
        return typeImageView
    }()
    
    lazy var leftImageView: UIImageView = {
        let leftImageView = UIImageView()
        return leftImageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
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
        nameTx.isEnabled = false
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
        idNumberTx.isEnabled = false
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
    
    lazy var coverView: UIView = {
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
    
    lazy var grayView: UIView = {
        let grayView = UIView()
        grayView.backgroundColor = UIColor.init(hexString: "#EDF0F2")
        grayView.layer.cornerRadius = 12
        grayView.layer.masksToBounds = true
        return grayView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(bgView)
        bgView.addSubview(typeImageView)
        bgView.addSubview(leftImageView)
        bgView.addSubview(rightImageView)
        bgView.addSubview(grayView)
        
        grayView.addSubview(oneLabel)
        grayView.addSubview(twoLabel)
        grayView.addSubview(threeLabel)
        grayView.addSubview(nameTx)
        grayView.addSubview(idNumberTx)
        grayView.addSubview(coverView)
        coverView.addSubview(timeLabel)
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
        
        leftImageView.snp.makeConstraints { make in
            make.top.equalTo(typeImageView.snp.bottom).offset(18)
            make.size.equalTo(CGSize(width: 104, height: 69))
            make.left.equalToSuperview().offset(50)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(typeImageView.snp.bottom).offset(18)
            make.size.equalTo(CGSize(width: 104, height: 69))
            make.right.equalToSuperview().offset(-50)
        }
        
        grayView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 295, height: 282))
            make.centerX.equalToSuperview()
            make.top.equalTo(rightImageView.snp.bottom).offset(25)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalToSuperview().offset(15)
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
        
        coverView.snp.makeConstraints { make in
            make.top.equalTo(threeLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 285, height: 46))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 240, height: 48))
            make.top.equalTo(grayView.snp.bottom).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
