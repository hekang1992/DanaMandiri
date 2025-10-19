//
//  ProductCollectionViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

import UIKit
import SnapKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    var model: lessastModel? {
        didSet {
            guard let model = model else { return }
            typeLabel.text = model.ctenitive ?? ""
            let articleit = model.articleit ?? 0
            logoImageView.kf.setImage(with: URL(string: model.firmacity ?? ""))
            if articleit == 1 {
                completeLabel.text = LanguageManager.localizedString(for: "Completed") + "\n" + "✓"
                completeLabel.textColor = .white
                completeLabel.font = UIFont.system(12, weightValue: 600)
            }else {
                completeLabel.text = LanguageManager.localizedString(for: "GO") + ">"
                completeLabel.textColor = .black
                completeLabel.font = UIFont.system(16, weightValue: 600)
            }
        }
    }
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        typeLabel.textAlignment = .center
        typeLabel.font = UIFont.system(14, weightValue: 600)
        typeLabel.numberOfLines = 0
        return typeLabel
    }()
    
    lazy var completeLabel: UILabel = {
        let completeLabel = UILabel()
        completeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        completeLabel.textAlignment = .center
        completeLabel.numberOfLines = 0
        return completeLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        /// comp_bg_oimage
        bgImageView.image = UIImage(named: "gress_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(typeLabel)
        bgImageView.addSubview(completeLabel)
        bgImageView.addSubview(logoImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        typeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(100)
        }
        completeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
            make.bottom.equalTo(completeLabel.snp.top).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
