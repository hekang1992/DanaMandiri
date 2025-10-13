//
//  CenterListView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/11.
//

import UIKit
import SnapKit

class CenterListView: UIView {

    private var selectedIndex: Int = 0
    
    private var filterButtons: [UIButton] = []
    
    var model: BaseModel? {
        didSet {
            tableView.reloadData()
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
        listLabel.font = UIFont.system(16, weightValue: 600)
        listLabel.text = LanguageManager.localizedString(for: "My")
        return listLabel
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "cen_logo_image")
        return logoImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        phoneLabel.textAlignment = .center
        phoneLabel.font = UIFont.system(24, weightValue: 500)
        let phoneNum = AuthLoginManager.shared.getPhoneNumber() ?? ""
        if phoneNum.count >= 7 {
            phoneLabel.text = FormatPhoneNumber.formatPhoneNumber(phoneNum)
        }else {
            phoneLabel.text = phoneNum
        }
        return phoneLabel
    }()
    
    lazy var yqImageView: UIImageView = {
        let yqImageView = UIImageView()
        yqImageView.image = UIImage(named: "cc_yhq_image")
        return yqImageView
    }()
    
    lazy var listImageView: UIImageView = {
        let listImageView = UIImageView()
        listImageView.image = UIImage(named: "cc_list_ad_image")
        listImageView.isUserInteractionEnabled = true
        return listImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(CenterListViewCell.self, forCellReuseIdentifier: "CenterListViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        addSubview(listLabel)
        addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(phoneLabel)
        scrollView.addSubview(yqImageView)
        scrollView.addSubview(listImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(listLabel.snp.bottom).offset(5)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 108, height: 108))
            make.top.equalToSuperview().offset(15)
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.height.equalTo(24)
            make.width.equalTo(220)
        }
        
        yqImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 79))
            make.top.equalTo(phoneLabel.snp.bottom).offset(15)
        }
        
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        if cin == "462" {
            yqImageView.isHidden = true
            yqImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 0, height: 0))
                make.top.equalTo(phoneLabel.snp.bottom)
            }
        }else {
            yqImageView.isHidden = false
            yqImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 335, height: 79))
                make.top.equalTo(phoneLabel.snp.bottom).offset(15)
            }
        }
        
        listImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(yqImageView.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 335, height: 272))
            make.bottom.equalToSuperview().offset(-20)
        }
        
        listImageView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
}

extension CenterListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.salin?.equize?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = model?.salin?.equize?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenterListViewCell", for: indexPath) as! CenterListViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = listModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listModel = model?.salin?.equize?[indexPath.row]
        let kilolaughish = listModel?.kilolaughish ?? ""
        if kilolaughish.contains(SCHEME_URL) {
            SchemeManager.handle(url: kilolaughish)
        }else {
            
        }
    }
}

class FormatPhoneNumber {
    static func formatPhoneNumber(_ phoneNumber: String) -> String {
        let phoneLength = phoneNumber.count
        let prefix = String(phoneNumber.prefix(2))
        let suffix = String(phoneNumber.suffix(4))
        let starCount = phoneLength - 6
        let stars = String(repeating: "*", count
                           : starCount)
        return "\(prefix)\(stars)\(suffix)"
    }

}
