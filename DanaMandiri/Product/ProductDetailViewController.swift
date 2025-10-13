//
//  ProductDetailViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProductDetailViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    
    let viewModel = ProductViewModel()
    
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
            }
        }
    }
    
}
