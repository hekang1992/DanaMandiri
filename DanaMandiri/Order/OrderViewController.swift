//
//  OrderViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit
import MJRefresh

class OrderViewController: BaseViewController {
    
    lazy var listView: OrderListView = {
        let listView = OrderListView(frame: .zero)
        return listView
    }()
    
    let viewModel = OrderListViewModel()
    
    var type: String = "4"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(85)
        }
        
        listView.clickBlock = { str in
            self.type = str
            self.getListInfo(with: str)
        }
        
        listView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getListInfo(with: self.type)
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListInfo(with: type)
    }
    
}

extension OrderViewController {
    
    private func getListInfo(with type: String) {
        let json = ["stition": type, "pancreoutside": "1", "towardoon": "50"]
        viewModel.getOrderListInfo(with: json) { model in
            self.listView.tableView.mj_header?.endRefreshing()
            if ["0", "00"].contains(model.aboutation) {
                self.listView.modelArray = model.salin?.sipirangeular ?? []
                self.listView.tableView.reloadData()
            }
        }
    }
    
}
