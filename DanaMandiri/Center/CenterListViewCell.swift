//
//  CenterListViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

import UIKit
import SnapKit
import Kingfisher

class CenterListViewCell: UITableViewCell {
    
    var model: equizeModel? {
        didSet {
            guard let model = model else { return }
            logoImageView.kf.setImage(with: URL(string: model.senselike ?? ""))
            listLabel.text = model.ctenitive ?? ""
        }
    }

    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        listLabel.textAlignment = .left
        listLabel.font = UIFont.system(14, weightValue: 500)
        return listLabel
    }()
    
    lazy var eightImageView: UIImageView = {
        let eightImageView = UIImageView()
        eightImageView.image = UIImage(named: "right_ce_image")
        return eightImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        return bgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(listLabel)
        bgView.addSubview(eightImageView)
        
        bgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(64)
            make.bottom.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        listLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(14)
        }
        eightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
