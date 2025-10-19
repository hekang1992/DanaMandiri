//
//  OrderViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit
import SnapKit
import MJRefresh
import RxSwift
import RxGesture

class OrderViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
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
        
        listView.cellTapBlock = { [weak self] pageUrl in
            if pageUrl.contains(SCHEME_URL) {
                SchemeManager.handle(url: pageUrl)
            }else {
                let webVc = UnieerLifeViewController()
                webVc.pageUrl = pageUrl
                self?.navigationController?.pushViewController(webVc, animated: true)
            }
        }
        
        listView.emptyView.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
            }
        }).disposed(by: disposeBag)
        
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
