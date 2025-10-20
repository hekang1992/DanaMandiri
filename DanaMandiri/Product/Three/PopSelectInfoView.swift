//
//  PopSelectInfoView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopSelectInfoView: UIView {
    
    var selectIndex: Int?
    
    let disposeBag = DisposeBag()
    
    var tapClickIndexBlock: ((Int) -> Void)?
    
    var model: clastoonModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.ctenitive ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pop_info_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "candel_gb_ic"), for: .normal)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.system(16, weightValue: 600)
        return nameLabel
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Confirming"), for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 700)
        againBtn.layer.cornerRadius = 24
        againBtn.layer.borderWidth = 1
        againBtn.layer.borderColor = UIColor.black.cgColor
        againBtn.backgroundColor = UIColor.init(hexString: "#009F1E")
        return againBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(PopSelectInfoViewCell.self, forCellReuseIdentifier: "PopSelectInfoViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(cancelBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(againBtn)
        bgImageView.addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 325, height: 395))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(23)
            make.height.equalTo(20)
        }
        
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 239, height: 48))
            make.bottom.equalToSuperview().offset(-23)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(againBtn.snp.top).offset(-5)
        }
        
        againBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self, let selectIndex = selectIndex {
                self.tapClickIndexBlock?(selectIndex)
            }else {
                ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Please select an item"))
            }
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopSelectInfoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.aboveent?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = model?.aboveent?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopSelectInfoViewCell", for: indexPath) as! PopSelectInfoViewCell
        cell.model = listModel
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.updateSelectionState(isSelected: indexPath.row == selectIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectIndex != indexPath.row {
            selectIndex = indexPath.row
            tableView.reloadData()
        }
    }
    
}
