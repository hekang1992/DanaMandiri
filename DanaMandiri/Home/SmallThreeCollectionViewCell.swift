//
//  SmallThreeCollectionViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

import UIKit
import SnapKit
import FSPagerView

class SmallThreeCollectionViewCell: FSPagerViewCell {
    
    var model: socialModel? {
        didSet {
            guard let model = model else { return }
            listLabel.text = model.ctenitive ?? ""
            descLabel.text = model.filmably ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pa_l_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var greenImageView: UIImageView = {
        let greenImageView = UIImageView()
        greenImageView.image = UIImage(named: "dgr_bg_image_ic")
        return greenImageView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#009F1E")
        listLabel.textAlignment = .left
        listLabel.font = UIFont.system(14, weightValue: 500)
        return listLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.system(12, weightValue: 400)
        return descLabel
    }()
    
    lazy var checkLabel: PaddedLabel = {
        let checkLabel = PaddedLabel()
        checkLabel.padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        checkLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        checkLabel.textAlignment = .center
        checkLabel.font = UIFont.system(13, weightValue: 500)
        checkLabel.text = LanguageManager.localizedString(for: "Check")
        checkLabel.backgroundColor = UIColor.init(hexString: "#009F1E")
        checkLabel.layer.cornerRadius = 14
        checkLabel.clipsToBounds = true
        return checkLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(greenImageView)
        bgImageView.addSubview(listLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(checkLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 71))
        }
        greenImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        listLabel.snp.makeConstraints { make in
            make.centerY.equalTo(greenImageView.snp.centerY)
            make.left.equalTo(greenImageView.snp.right).offset(4)
            make.height.equalTo(16)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(greenImageView.snp.bottom).offset(5)
            make.width.equalTo(265)
        }
        checkLabel.snp.makeConstraints { make in
            make.centerY.equalTo(greenImageView.snp.centerY)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(28)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
