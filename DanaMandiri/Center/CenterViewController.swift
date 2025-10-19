//
//  CenterViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
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
        
        self.centerListView.cellTapBlock = { [weak self] kilolaughish in
            guard let self = self else { return }
            if kilolaughish.contains(SCHEME_URL) {
                SchemeManager.handle(url: kilolaughish)
            }else {
                let webVc = UnieerLifeViewController()
                webVc.pageUrl = kilolaughish
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }
        
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
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
                if model.aboutation == "-2" {
                    AuthLoginManager.shared.removeLoginInfo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                    }
                }
            }
        }
    }
}
