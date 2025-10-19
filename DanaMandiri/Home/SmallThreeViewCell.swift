//
//  SmallThreeViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

import UIKit
import SnapKit
import FSPagerView
import Kingfisher

class SmallThreeViewCell: UITableViewCell {
    
    var tapClick: ((String) -> Void)?
    
    var smallModel: [socialModel]? {
        didSet {
            guard let smallModel = smallModel else { return }
            if smallModel.count <= 1 {
                pagerView.automaticSlidingInterval = 0
                pagerView.isInfinite = false
                pagerView.isScrollEnabled = false
            } else {
                pagerView.automaticSlidingInterval = 3.0
                pagerView.isInfinite = true
                pagerView.isScrollEnabled = true
            }
            pagerView.reloadData()
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var pagerView: FSPagerView = {
        let pv = FSPagerView()
        pv.dataSource = self
        pv.delegate = self
        pv.register(SmallThreeCollectionViewCell.self, forCellWithReuseIdentifier: "SmallThreeCollectionViewCell")
        pv.interitemSpacing = 5
        pv.transformer = FSPagerViewTransformer(type: .linear)
        return pv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(pagerView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-5)
        }
        pagerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SmallThreeViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let model = smallModel?[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "SmallThreeCollectionViewCell", at: index) as! SmallThreeCollectionViewCell
        cell.contentView.layer.shadowRadius = 0
        cell.model = model
        return cell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return smallModel?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let model = smallModel?[index] {
            self.tapClick?(model.singleain ?? "")
        }
    }
    
}
