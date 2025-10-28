//
//  ProductDetailViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MJRefresh

class ProductDetailViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    
    let viewModel = ProductViewModel()
    
    var shakeModel: shakeModel?
    
    var model: BaseModel?
    
    var entertime: String = ""
    
    var leavetime: String = ""
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()
    
    lazy var productView: ProductView = {
        let productView = ProductView()
        return productView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        LocationManager.shared.requestLocation { model in
            AddressLocationInfoModel.shared.locationModel = model
        }
        
        entertime = String(Int(Date().timeIntervalSince1970))
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headView.listLabel.text = LanguageManager.localizedString(for: "Product Details")
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
        }
        
        headView.againBtn.rx.tap.subscribe(onNext: {
            self.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        view.addSubview(productView)
        productView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(5)
        }
        
        productView.cellClickBlock = { [weak self] model in
            self?.goNextPageInfo(with: model)
        }
        
        productView.borrowBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let resourceosity = self.shakeModel?.resourceosity ?? ""
            /// IMAGE_PERSONAL_INFO
            if resourceosity.isEmpty {
                /// ORDER_INFO
                self.orderToPage()
            }else {
                self.goPageWithType(type: resourceosity, model: self.model ?? BaseModel(), productID: productID)
            }
        }).disposed(by: disposeBag)
        
        productView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.getDetailInfo()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDetailInfo()
    }
    
}

extension ProductDetailViewController {
    
    private func getDetailInfo() {
        let json = ["response": productID, "spatitenics": "101"]
        viewModel.getProductDetailInfo(with: json) { [weak self] model in
            self?.productView.scrollView.mj_header?.endRefreshing()
            if ["0", "00"].contains(model.aboutation) {
                self?.productView.model = model
                self?.model = model
                self?.shakeModel = model.salin?.shake
            }
        }
    }
    
    private func goNextPageInfo(with model: lessastModel) {
        let resourceosity = model.resourceosity ?? ""
        let articleit = model.articleit ?? 0
        if articleit == 1 {
            goPageWithType(type: resourceosity, model: self.model ?? BaseModel(), productID: productID)
        }else {
            let type = self.shakeModel?.resourceosity ?? ""
            goPageWithType(type: type, model: self.model ?? BaseModel(), productID: productID)
        }
    }
    
    private func orderToPage() {
        leavetime = String(Int(Date().timeIntervalSince1970))
        let noency = self.model?.salin?.etharium?.presentality ?? ""
        let tergable = self.model?.salin?.etharium?.tergable ?? ""
        let coprattack = self.model?.salin?.etharium?.coprattack ?? ""
        let tentsure = String(self.model?.salin?.etharium?.tentsure ?? 0)
        let json = ["noency": noency,
                    "tergable": tergable,
                    "quartplaceise": "1",
                    "coprattack": coprattack,
                    "tentsure": tentsure]
        viewModel.orderInfo(with: json) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                self?.colInfo()
                let singleain = model.salin?.singleain ?? ""
                let webVc = UnieerLifeViewController()
                webVc.pageUrl = singleain
                webVc.productID = self?.productID ?? ""
                self?.navigationController?.pushViewController(webVc, animated: true)
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
            }
        }
    }
    
    private func colInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
//            let locationModel = AddressLocationInfoModel.shared.locationModel
            
            let latitude = UserDefaults.standard.object(forKey: "latitude") as? Double ?? 0.0
            let longitude = UserDefaults.standard.object(forKey: "longitude") as? Double ?? 0.0
    
            let json = ["opportunityatory": productID,
                        "muls": "8",
                        "presentality": self.model?.salin?.etharium?.presentality ?? "",
                        "dens": entertime,
                        "graman": String(longitude),
                        "anem": String(latitude)]
            ColsomeManager.colsomeInfo(with: json, leavetime: leavetime)
        }
    }
    
}
