//
//  PopSelectInfoViewCell.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/15.
//

import UIKit
import SnapKit

class PopSelectInfoViewCell: UITableViewCell {
    
    var model: aboveentModel? {
        didSet {
            guard let model = model else { return }
            listLabel.text = model.pachyade ?? ""
        }
    }
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(16, weightValue: 400)
        listLabel.layer.cornerRadius = 24
        listLabel.clipsToBounds = true
        return listLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(listLabel)
        listLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 277, height: 46))
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopSelectInfoViewCell {
    
    func updateSelectionState(isSelected: Bool) {
        if isSelected {
            listLabel.backgroundColor = UIColor(hexString: "#C1E0C1")
            listLabel.textColor = UIColor.init(hexString: "#009F1E")
        } else {
            listLabel.backgroundColor = UIColor.clear
            listLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        }
    }
    
}
