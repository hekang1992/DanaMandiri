//
//  CommonHeadView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

import UIKit
import SnapKit

class CommonHeadView: UIView {
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        return bgView
    }()

    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setImage(UIImage(named: "back_d_image"), for: .normal)
        return againBtn
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(16, weightValue: 600)
        return listLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(againBtn)
        bgView.addSubview(listLabel)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        againBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        listLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 18))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
