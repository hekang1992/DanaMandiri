//
//  OrderViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {
    
    lazy var listView: OrderListView = {
        let listView = OrderListView(frame: .zero)
        return listView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    


}
