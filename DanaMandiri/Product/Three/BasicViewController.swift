//
//  BasicViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

class BasicViewController: BaseViewController {
    
    var productID: String = ""
    
    let disposeBag = DisposeBag()
    
    let viewModel = BasicViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()

    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        typeImageView.image = cin == "460" ? UIImage(named: "basic_bg_od_image") : UIImage(named: "basic_bg_en_image")
        return typeImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Next Step"), for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 700)
        againBtn.layer.cornerRadius = 24
        againBtn.layer.borderWidth = 1
        againBtn.layer.borderColor = UIColor.black.cgColor
        againBtn.backgroundColor = UIColor.init(hexString: "#009F1E")
        return againBtn
    }()
    
    lazy var basicView: BasicView = {
        let basicView = BasicView()
        return basicView
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
        
        headView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.popToDetailViewController()
        }).disposed(by: disposeBag)
        
        view.addSubview(typeImageView)
        typeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
            make.width.equalTo(335)
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(typeImageView.snp.bottom).offset(11)
            make.width.equalTo(335)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        bgView.addSubview(againBtn)
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSizeMake(305, 50))
            make.bottom.equalToSuperview().offset(-20)
        }
        
        bgView.addSubview(basicView)
        basicView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(againBtn.snp.top).offset(-10)
        }
        
        let json = ["response": productID, "slogon": "1"]
        viewModel.getBasicInfo(with: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                self.basicView.model = model
                self.basicView.tableView.reloadData()
            }
        }
        
        againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.saveInfo()
        }).disposed(by: disposeBag)
        
    }

}

extension BasicViewController {
    
    private func saveInfo() {
        let model = self.basicView.model
        print("skillette=========\(model?.salin?.clastoon?.first?.skillette ?? "")")
    }
    
}
