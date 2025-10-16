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

class ProductDetailViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    
    let viewModel = ProductViewModel()
    
    var shakeModel: shakeModel?
    
    var model: BaseModel?
    
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
            let resourceosity = self?.shakeModel?.resourceosity ?? ""
            /// IMAGE_PERSONAL_INFO
            if resourceosity.isEmpty {
                /// ORDER_INFO
                self?.orderToPage()
            }else {
                self?.goPageWithType(type: resourceosity)
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDetailInfo()
    }
    
}

extension ProductDetailViewController {
    
    private func getDetailInfo() {
        let json = ["response": productID, "spatitenics": "101"]
        viewModel.getProductDetailInfo(with: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                self.productView.model = model
                self.model = model
                self.shakeModel = model.salin?.shake
            }
        }
    }
    
    private func goNextPageInfo(with model: lessastModel) {
        let resourceosity = model.resourceosity ?? ""
        let articleit = model.articleit ?? 0
        if articleit == 1 {
            goPageWithType(type: resourceosity)
        }else {
            let type = self.shakeModel?.resourceosity ?? ""
            goPageWithType(type: type)
        }
    }
    
    private func goPageWithType(type: String) {
        switch type {
        case "cunely":
            let viewModel = PersonalImageViewModel()
            let json = ["response": productID, "hispidity": "1"]
            viewModel.getPersonalInfo(with: json) { [weak self] model in
                guard let self = self else { return }
                /// ID
                let articleit = model.salin?.phobthougharian?.articleit ?? 0
                /// FACE
                let faceNum = model.salin?.feliimportant?.articleit ?? 0
                if articleit == 1 {
                    if faceNum == 1 {
                        let bothVc = BothCompleteViewController()
                        bothVc.productID = productID
                        bothVc.orderNumber = self.model?.salin?.etharium?.presentality ?? ""
                        self.navigationController?.pushViewController(bothVc, animated: true)
                    }else {
                        let faceVc = FaceViewController()
                        faceVc.productID = productID
                        faceVc.orderNumber = self.model?.salin?.etharium?.presentality ?? ""
                        self.navigationController?.pushViewController(faceVc, animated: true)
                    }
                }else {
                    let personalVc = PersonalImageViewController()
                    personalVc.productID = productID
                    personalVc.orderNumber = self.model?.salin?.etharium?.presentality ?? ""
                    self.navigationController?.pushViewController(personalVc, animated: true)
                }
            }
            break
        case "caedular":
            let basicVc = BasicViewController()
            basicVc.productID = productID
            self.navigationController?.pushViewController(basicVc, animated: true)
            break
        case "consumer":
            let cnpVc = CommonBpViewController()
            cnpVc.productID = productID
            self.navigationController?.pushViewController(cnpVc, animated: true)
            break
        case "anderdom":
            let youngVc = ChangeYoungViewController()
            youngVc.productID = productID
            self.navigationController?.pushViewController(youngVc, animated: true)
            break
        default:
            break
        }
    }
    
    private func orderToPage() {
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
    
}
