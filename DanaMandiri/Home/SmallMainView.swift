//
//  SmallMainView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit
import Kingfisher

class SmallMainView: UIView {
    
    var smallModelArray: [sipirangeularModel]?
    
    var smallModel: socialModel? {
        didSet {
            guard let smallModel = smallModel else { return }
            listLabel.text = smallModel.alate ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(16, weightValue: 700)
        return listLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(SmallOneViewCell.self, forCellReuseIdentifier: "SmallOneViewCell")
        tableView.register(SmallTwoViewCell.self, forCellReuseIdentifier: "SmallTwoViewCell")
        tableView.register(SmallThreeViewCell.self, forCellReuseIdentifier: "SmallThreeViewCell")
        tableView.register(SmallFourViewCell.self, forCellReuseIdentifier: "SmallFourViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(listLabel)
        addSubview(tableView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: 200, height: 16))
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(listLabel.snp.bottom).offset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SmallMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = smallModelArray?[section]
        let skillette = model?.skillette ?? ""
        if skillette == "lessast" {
            return 50
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = smallModelArray?[section]
        let skillette = model?.skillette ?? ""
        if skillette == "lessast" {
            let headView = UIView()
            headView.backgroundColor = .clear
            let btn = UIButton(type: .custom)
            let cin = CinInfoModel.shared.cinModel?.cin ?? ""
            if cin == "460" {
                btn.setBackgroundImage(UIImage(named: "desc_smal_image"), for: .normal)
            }else {
                btn.setBackgroundImage(UIImage(named: "desc_smalen_image"), for: .normal)
            }
            headView.addSubview(btn)
            btn.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(36)
            }
            return headView
        }else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return smallModelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = smallModelArray?[section]
        let skillette = model?.skillette ?? ""
        if skillette == "phonemost" {
            return 1
        }else if skillette == "staracy" {
            return 1
        }else {
            return smallModelArray?[section].social?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = smallModelArray?[indexPath.section]
        let skillette = model?.skillette ?? ""
        if skillette == "phonemost" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallOneViewCell", for: indexPath) as! SmallOneViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.smallModel = model?.social ?? []
            return cell
        }else if skillette == "successfultic" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallTwoViewCell", for: indexPath) as! SmallTwoViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.smallModel = model?.social?[indexPath.row]
            return cell
        }else if skillette == "staracy" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallThreeViewCell", for: indexPath) as! SmallThreeViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.smallModel = model?.social ?? []
            return cell
        }else if skillette == "lessast" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallFourViewCell", for: indexPath) as! SmallFourViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.smallModel = model?.social?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}
