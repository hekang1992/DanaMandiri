//
//  OrderListView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/11.
//

import UIKit
import SnapKit

class OrderListView: UIView {
    
    private var selectedIndex: Int = 0
    
    private var filterButtons: [UIButton] = []
    
    var clickBlock: ((String) -> Void)?
    
    var modelArray: [sipirangeularModel]? {
        didSet {
            
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
        listLabel.text = LanguageManager.localizedString(for: "Order")
        return listLabel
    }()

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "order_bg_image")
        headImageView.isUserInteractionEnabled = true
        return headImageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitleColor(.white, for: .normal)
        oneBtn.setTitle(LanguageManager.localizedString(for: "All"), for: .normal)
        oneBtn.titleLabel?.font = UIFont.system(13, weightValue: 600)
        oneBtn.tag = 0
        oneBtn.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitleColor(.white, for: .normal)
        twoBtn.setTitle(LanguageManager.localizedString(for: "Applying"), for: .normal)
        twoBtn.titleLabel?.font = UIFont.system(13, weightValue: 600)
        twoBtn.tag = 1
        twoBtn.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setTitleColor(.white, for: .normal)
        threeBtn.setTitle(LanguageManager.localizedString(for: "Repayment"), for: .normal)
        threeBtn.titleLabel?.font = UIFont.system(13, weightValue: 600)
        threeBtn.tag = 2
        threeBtn.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.setTitleColor(.white, for: .normal)
        fourBtn.setTitle(LanguageManager.localizedString(for: "Finish"), for: .normal)
        fourBtn.titleLabel?.font = UIFont.system(13, weightValue: 600)
        fourBtn.tag = 3
        fourBtn.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        return fourBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(OrderListViewCell.self, forCellReuseIdentifier: "OrderListViewCell")
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
        setupUI()
        setupFilterButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        addSubview(listLabel)
        addSubview(headImageView)
        headImageView.addSubview(stackView)
        stackView.addArrangedSubview(oneBtn)
        stackView.addArrangedSubview(twoBtn)
        stackView.addArrangedSubview(threeBtn)
        stackView.addArrangedSubview(fourBtn)
        addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(listLabel.snp.bottom)
            make.size.equalTo(CGSize(width: 335, height: 48))
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupFilterButtons() {
        filterButtons = [oneBtn, twoBtn, threeBtn, fourBtn]
        
        filterButtons.forEach { button in
            button.backgroundColor = .clear
            button.setTitleColor(.gray, for: .normal)
            button.layer.cornerRadius = 19
            button.layer.masksToBounds = true
        }
        
        selectButton(at: 0)
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        selectButton(at: sender.tag)
    }
    
    private func selectButton(at index: Int) {
        filterButtons.forEach { button in
            button.backgroundColor = .clear
            button.setTitleColor(.white, for: .normal)
        }
        
        let selectedButton = filterButtons[index]
        selectedButton.backgroundColor = UIColor(hexString: "#ECDF14")
        selectedButton.setTitleColor(.black, for: .normal)
        
        selectedIndex = index
        
        handleFilterSelection(at: index)
    }
    
    private func handleFilterSelection(at index: Int) {
        switch index {
        case 0:
            self.clickBlock?(String(2+2))
        case 1:
            self.clickBlock?(String(2+5))
        case 2:
            self.clickBlock?(String(2+4))
        case 3:
            self.clickBlock?(String(2+3))
        default:
            break
        }
   
    }
    
    func selectFilter(at index: Int) {
        guard index >= 0 && index < filterButtons.count else { return }
        selectButton(at: index)
    }
    
    func getSelectedIndex() -> Int {
        return selectedIndex
    }
}

extension OrderListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListViewCell", for: indexPath) as! OrderListViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = model
        return cell
    }
    
}
