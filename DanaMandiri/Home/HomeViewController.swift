//
//  HomeViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit
import RxSwift
import RxRelay
import SnapKit
import MJRefresh

class HomeViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let homeViewModel = HomeViewModel()
    
    var homeModel = BehaviorRelay<BaseModel?>(value: nil)
    
    var smallModel: socialModel?
    
    lazy var smallView: SmallMainView = {
        let smallView = SmallMainView(frame: .zero)
        smallView.isHidden = true
        return smallView
    }()
    
    lazy var homeView: HomeView = {
        let homeView = HomeView(frame: .zero)
        homeView.isHidden = true
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(smallView)
        smallView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(85)
        }
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(85)
        }
        
        /// REFRESH_HOME_INFO
        smallView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeInfo()
        })
        
        homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeInfo()
        })
        
        /// HOME_DETAIL_INFO
        self.homeModel.asObservable().subscribe(onNext: { model in
            guard let model = model else { return }
            let listArray = model.salin?.sipirangeular ?? []

            if let index = listArray.firstIndex(where: { $0.skillette == "successfultic" }) {
                print("✅ successfultic，index=====: \(index)")
                /// SMALL_CARD
                self.smallView.isHidden = false
                self.homeView.isHidden = true
                self.smallView.smallModel = listArray[index].social?.first
                self.smallView.smallModelArray = listArray
                self.smallView.tableView.reloadData()
            } else {
                print("❌ no successfultic")
                /// BIG_CARD
                self.smallView.isHidden = true
                self.homeView.isHidden = false
                let index = listArray.firstIndex(where: { $0.skillette == "tricesimition" }) ?? 0
                self.homeView.smallModel = listArray[index].social?.first
                self.smallModel = self.homeView.smallModel
            }
        }).disposed(by: disposeBag)
        
        ///APPLY_PRODUCT
        homeView.applyBlock = {
            self.applyInfo()
        }
        
        homeViewModel.getAdressInfo { model in
            if ["0", "00"].contains(model.aboutation) {
                CityAddressModel.shared.cityModel = model.salin
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
}

extension HomeViewController {
    
    private func getHomeInfo() {
        homeViewModel.getHomeInfo { [weak self] model in
            self?.smallView.tableView.mj_header?.endRefreshing()
            self?.homeView.scrollView.mj_header?.endRefreshing()
            if ["0", "00"].contains(model.aboutation) {
                self?.homeModel.accept(model)
            }
        }
    }
    
    private func applyInfo() {
        let testnature = String(self.smallModel?.testnature ?? 0)
        let json = ["typefication": "1001",
                    "dynaance": "1000",
                    "noticeion": "1000",
                    "response": testnature]
        homeViewModel.applyProductInfo(with: json) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                let singleain = model.salin?.singleain ?? ""
                if singleain.contains(SCHEME_URL) {
                    SchemeManager.handle(url: singleain)
                }else {
                    let webVc = UnieerLifeViewController()
                    webVc.pageUrl = singleain
                    webVc.productID = testnature
                    self?.navigationController?.pushViewController(webVc, animated: true)
                }
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
            }
        }
    }
    
}
