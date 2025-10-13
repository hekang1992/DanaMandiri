//
//  CenterViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit
import MJRefresh

class CenterViewController: BaseViewController {
    
    lazy var centerListView: CenterListView = {
        let centerListView = CenterListView(frame: .zero)
        return centerListView
    }()
    
    let viewModel = CenterListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(centerListView)
        centerListView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.centerListView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getCenterInfo()
        })
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCenterInfo()
    }

}

extension CenterViewController {
    
    private func getCenterInfo() {
        viewModel.getCenterInfo { model in
            self.centerListView.scrollView.mj_header?.endRefreshing()
            if ["0", "00"].contains(model.aboutation) {
                self.centerListView.model = model
            }
        }
    }
}
