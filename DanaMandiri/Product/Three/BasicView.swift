//
//  BasicView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/14.
//

import UIKit
import SnapKit

class BasicView: UIView {
    
    var model: BaseModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(hexString: "#F2F8FC")
        tableView.register(TapClickViewCell.self, forCellReuseIdentifier: "TapClickViewCell")
        tableView.register(EnterInputViewCell.self, forCellReuseIdentifier: "EnterInputViewCell")
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
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BasicView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.salin?.clastoon?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = model?.salin?.clastoon?[indexPath.row]
        let uxori = listModel?.uxori ?? ""
        if uxori == "clearsive" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnterInputViewCell", for: indexPath) as! EnterInputViewCell
            cell.model = listModel
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TapClickViewCell", for: indexPath) as! TapClickViewCell
            cell.model = listModel
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        
    }
        
}
