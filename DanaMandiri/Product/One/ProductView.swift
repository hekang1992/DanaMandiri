//
//  ProductView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

import UIKit
import SnapKit
import Kingfisher

class ProductView: UIView {
    
    private var collectionViewHeightConstraint: Constraint?
    
    var cellClickBlock: ((lessastModel) -> Void)?
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.salin?.etharium?.miritude ?? ""
            twoLabel.text = model.salin?.etharium?.tergable ?? ""
            
            threeLabel.text = model.salin?.etharium?.standal?.bothor?.ctenitive ?? ""
            
            let able = model.salin?.etharium?.standal?.bothor?.evidenceish ?? ""
            let fullText = LanguageManager.localizedString(for: "The daily interest rate is as low as") + " " + able
            let attributedString = NSMutableAttributedString(string: fullText)
            if let range = fullText.range(of: able) {
                let nsRange = NSRange(range, in: fullText)
                attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#0C9C35"), range: nsRange)
            }
            fourLabel.attributedText = attributedString
            
            fiveLabel.text = model.salin?.etharium?.rep ?? ""
            let janu = model.salin?.etharium?.coprattack ?? ""
            let full1Text = LanguageManager.localizedString(for: "The term is long") + " " + janu
            let attributed1String = NSMutableAttributedString(string: full1Text)
            if let range = full1Text.range(of: janu) {
                let nsRange = NSRange(range, in: full1Text)
                attributed1String.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#0C9C35"), range: nsRange)
            }
            sixLabel.attributedText = attributed1String
            
            let logoUrl = model.salin?.etharium?.vertindustryent ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            
            collectionView.reloadData()
            updateCollectionViewHeight()
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
        bgImageView.image = UIImage(named: "deia_bg_image")
        bgImageView.layer.cornerRadius = 4.5
        bgImageView.clipsToBounds = true
        return bgImageView
    }()
    
    lazy var oneLabel: PaddedLabel = {
        let oneLabel = PaddedLabel()
        oneLabel.textColor = UIColor.init(hexString: "#01040C")
        oneLabel.textAlignment = .center
        oneLabel.font = UIFont.system(12, weightValue: 500)
        oneLabel.backgroundColor = UIColor.init(hexString: "#ECDF14")
        oneLabel.layer.borderWidth = 1
        oneLabel.layer.borderColor = UIColor.init(hexString: "#0E0F0F").cgColor
        oneLabel.layer.cornerRadius = 13
        oneLabel.clipsToBounds = true
        oneLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return oneLabel
    }()
    
    lazy var twoLabel: PaddedLabel = {
        let twoLabel = PaddedLabel()
        twoLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        twoLabel.textAlignment = .left
        twoLabel.font = UIFont.system(18, weightValue: 900)
        return twoLabel
    }()
    
    lazy var threeLabel: PaddedLabel = {
        let threeLabel = PaddedLabel()
        threeLabel.textColor = UIColor.init(hexString: "#01040C")
        threeLabel.textAlignment = .center
        threeLabel.font = UIFont.system(12, weightValue: 500)
        threeLabel.backgroundColor = UIColor.init(hexString: "#ECDF14")
        threeLabel.layer.borderWidth = 1
        threeLabel.layer.borderColor = UIColor.init(hexString: "#0E0F0F").cgColor
        threeLabel.layer.cornerRadius = 13
        threeLabel.clipsToBounds = true
        threeLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return threeLabel
    }()
    
    lazy var fourLabel: PaddedLabel = {
        let fourLabel = PaddedLabel()
        fourLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        fourLabel.textAlignment = .left
        fourLabel.font = UIFont.system(12, weightValue: 400)
        return fourLabel
    }()
    
    lazy var fiveLabel: PaddedLabel = {
        let fiveLabel = PaddedLabel()
        fiveLabel.textColor = UIColor.init(hexString: "#01040C")
        fiveLabel.textAlignment = .center
        fiveLabel.font = UIFont.system(12, weightValue: 500)
        fiveLabel.backgroundColor = UIColor.init(hexString: "#ECDF14")
        fiveLabel.layer.borderWidth = 1
        fiveLabel.layer.borderColor = UIColor.init(hexString: "#0E0F0F").cgColor
        fiveLabel.layer.cornerRadius = 13
        fiveLabel.clipsToBounds = true
        fiveLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return fiveLabel
    }()
    
    lazy var sixLabel: PaddedLabel = {
        let sixLabel = PaddedLabel()
        sixLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        sixLabel.textAlignment = .left
        sixLabel.font = UIFont.system(12, weightValue: 400)
        return sixLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.backgroundColor = .purple
        return logoImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        oneImageView.image = cin == "460" ? UIImage(named: "id_pro_image") : UIImage(named: "en_prode_image")
        return oneImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var borrowBtn: UIButton = {
        let borrowBtn = UIButton(type: .custom)
        borrowBtn.setTitle(LanguageManager.localizedString(for: "To Borrow Money"), for: .normal)
        borrowBtn.setTitleColor(UIColor.init(hexString: "#0E0F0F"), for: .normal)
        borrowBtn.titleLabel?.font = UIFont.system(16, weightValue: 700)
        borrowBtn.layer.cornerRadius = 25
        borrowBtn.layer.borderWidth = 1
        borrowBtn.layer.borderColor = UIColor.black.cgColor
        borrowBtn.backgroundColor = UIColor.init(hexString: "#EAA028")
        return borrowBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        addSubview(borrowBtn)
        scrollView.addSubview(bgImageView)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(fourLabel)
        bgImageView.addSubview(fiveLabel)
        bgImageView.addSubview(sixLabel)
        bgImageView.addSubview(logoImageView)
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(bgView)
        bgView.addSubview(collectionView)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 242))
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.left.equalToSuperview().offset(31)
            make.height.equalTo(26)
        }
        twoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(oneLabel.snp.bottom).offset(5)
            make.height.equalTo(36)
        }
        threeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(twoLabel.snp.bottom).offset(8)
            make.height.equalTo(26)
        }
        fourLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(threeLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        fiveLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(fourLabel.snp.bottom).offset(8)
            make.height.equalTo(26)
        }
        sixLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(fiveLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.right.equalToSuperview().offset(-31)
            make.size.equalTo(CGSize(width: 51, height: 51))
        }
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView.snp.bottom).offset(12)
            make.width.equalTo(341)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            self.collectionViewHeightConstraint = make.height.equalTo(0).constraint
        }
        borrowBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 50))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateCollectionViewHeight() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let itemCount = model?.salin?.lessast?.count ?? 0
        let numberOfRows = ceil(CGFloat(itemCount) / 2.0)
        
        let cellHeight: CGFloat = 146
        let totalVerticalSpacing = layout.sectionInset.top + layout.sectionInset.bottom +
        (layout.minimumLineSpacing * max(numberOfRows - 1, 0))
        let totalHeight = (cellHeight * numberOfRows) + totalVerticalSpacing
        
        collectionViewHeightConstraint?.update(offset: totalHeight)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
}

extension ProductView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.salin?.lessast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell",
                                                      for: indexPath) as! ProductCollectionViewCell
        let listModel = model?.salin?.lessast?[indexPath.row]
        cell.model = listModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 146, height: 146)
        }
        let totalHorizontalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let availableWidth = collectionView.frame.width - totalHorizontalSpacing
        let cellWidth = floor(availableWidth / 2)
        return CGSize(width: cellWidth, height: 146)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listModel = model?.salin?.lessast?[indexPath.row] {
            self.cellClickBlock?(listModel)
        }
    }
}
