//
//  EnterInputViewCell.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/14.
//

import UIKit
import SnapKit

class EnterInputViewCell: UITableViewCell {
    
    var model: clastoonModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.ctenitive ?? ""
            nameTx.placeholder = model.raptaceous ?? ""
            let uncifear = model.uncifear ?? ""
            nameTx.keyboardType = uncifear == "1" ? .numberPad : .default
        }
    }
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.system(14, weightValue: 500)
        return nameLabel
    }()
    
    lazy var nameTx: UITextField = {
        let nameTx = UITextField()
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Real Name"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#8D8D8D") as Any,
            .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(300))
        ])
        nameTx.attributedPlaceholder = attrString
        nameTx.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        nameTx.textColor = UIColor.init(hexString: "#0E0F0F")
        nameTx.backgroundColor = .white
        nameTx.layer.cornerRadius = 14
        nameTx.clipsToBounds = true
        nameTx.leftView = UIView(frame: CGRectMake(0, 0, 10, 10))
        nameTx.leftViewMode = .always
        nameTx.backgroundColor = UIColor.init(hexString: "#EDF0F2")
        return nameTx
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTx)
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
        }
        
        nameTx.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 305, height: 46))
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
