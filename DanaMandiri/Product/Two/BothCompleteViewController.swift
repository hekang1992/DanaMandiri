//
//  BothCompleteViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

class BothCompleteViewController: BaseViewController {
    
    var productID: String = ""
    
    var orderNumber: String = ""
    
    let disposeBag = DisposeBag()
    
    let viewModel = PersonalImageViewModel()
    
    lazy var bothView: BothComleteView = {
        let bothView = BothComleteView()
        return bothView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        view.addSubview(bothView)
        bothView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(5)
        }
        
        headView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.popToDetailViewController()
        }).disposed(by: disposeBag)
        
        getPersonalInfo()
        
        bothView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.popToDetailViewController()
        }).disposed(by: disposeBag)
        
    }
    
}

extension BothCompleteViewController {
    
    private func getPersonalInfo() {
        let json = ["response": productID, "hispidity": "1"]
        viewModel.getPersonalInfo(with: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                self.bothView.model = model
            }
        }
    }
}
