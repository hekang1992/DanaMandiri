//
//  ProductCollectionViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

import UIKit
import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var model: lessastModel? {
        didSet {
            guard let model = model else { return }
            
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        /// comp_bg_oimage
        bgImageView.image = UIImage(named: "gress_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
