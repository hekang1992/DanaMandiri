//
//  SmallOneViewCell.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/11.
//

import UIKit
import SnapKit
import FSPagerView
import Kingfisher

class SmallOneViewCell: UITableViewCell {
    
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
        pv.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
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
            make.top.equalToSuperview()
            make.height.equalTo(70)
            make.bottom.equalToSuperview()
        }
        pagerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SmallOneViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let model = smallModel?[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: model?.scolieer ?? ""))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.backgroundColor = .systemBlue
        return cell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return smallModel?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        ToastProgressHUD.showToastText(message: String(index))
    }
    
}
