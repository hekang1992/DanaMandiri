//
//  HomeViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import RxSwift
import RxRelay
import SnapKit
import MJRefresh

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let homeViewModel = HomeViewModel()
    
    var homeModel = BehaviorRelay<BaseModel?>(value: nil)
    
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
            make.edges.equalToSuperview()
        }
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        /// REFRESH_HOME_INFO
        smallView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
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
            } else {
                print("❌ no successfultic")
                /// BIG_CARD
                self.smallView.isHidden = true
                self.homeView.isHidden = false
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
}

extension HomeViewController {
    
    private func getHomeInfo() {
        homeViewModel.getHomeInfo { [weak self] model in
            self?.smallView.scrollView.mj_header?.endRefreshing()
            if ["0", "00"].contains(model.aboutation) {
                self?.homeModel.accept(model)
            }
        }
    }
    
}
