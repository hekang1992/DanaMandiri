//
//  CommonBpViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

class CommonBpViewController: BaseViewController {
    
    var productID: String = ""
    
    var orderNumber: String = ""
    
    var entertime: String = ""
    
    let disposeBag = DisposeBag()
    
    let viewModel = CommonBpViewModel()
    
    var dictArray: [[String: String]] = []
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()

    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        typeImageView.image = cin == "460" ? UIImage(named: "cnp_id_bg_image") : UIImage(named: "cnp_in_bg_image")
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
    
    lazy var bpView: CommonBpView = {
        let bpView = CommonBpView()
        return bpView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        LocationManager.shared.requestLocation { info in
            switch info {
            case .success(let success):
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    AddressLocationInfoModel.shared.locationModel = success
                }
                break
            case .failure(_):
                break
            }
        }
        
        entertime = String(Int(Date().timeIntervalSince1970))
        
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
        
        bgView.addSubview(bpView)
        bpView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(againBtn.snp.top).offset(-10)
        }
        
        let json = ["response": productID, "notacy": "cp"]
        viewModel.getCommonBpInfo(with: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                self.bpView.model = model
                self.bpView.tableView.reloadData()
            }
        }
        
        againBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self, let model = self.bpView.model {
                dictArray.removeAll()
                let modelArray = model.salin?.toughel?.sipirangeular ?? []
                modelArray.forEach { model in
                    let merilet = model.merilet ?? ""
                    let pachyade = model.pachyade ?? ""
                    let phytfew = model.phytfew ?? ""
                    let fallacy = model.fallacy ?? ""
                    let dict = ["merilet": merilet,
                                "pachyade": pachyade,
                                "phytfew": phytfew,
                                "fallacy": fallacy]
                    self.dictArray.append(dict)
                }
                sagePbInfo(with: dictArray)
            }
        }).disposed(by: disposeBag)
        
        bpView.allPhoneClickBlock = { [weak self] jsonStr in
            self?.getAllPhone(to: jsonStr)
        }
        
    }

}

extension CommonBpViewController {
    
    private func getAllPhone(to jsonStr: String) {
        let json = ["skillette": "3", "salin": jsonStr]
        viewModel.saveAllPhoneInfo(with: json) { model in }
    }
    
    private func sagePbInfo(with dictArray: [[String: String]]) {
        var jsonSring: String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictArray, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                jsonSring = jsonString
            }
        } catch {
            print("Failed JSON: \(error)")
        }
        
        
        let json = ["response": productID, "salin": jsonSring]
        viewModel.saveCommonBpInfo(with: json) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                self?.popToDetailViewController()
                self?.colInfo()
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
            }
        }
    }
    
    private func colInfo() {
        let locationModel = AddressLocationInfoModel.shared.locationModel
        let json = ["opportunityatory": productID,
                    "muls": "6",
                    "presentality": orderNumber,
                    "dens": entertime,
                    "graman": String(locationModel?.longitude ?? 0.0),
                    "anem": String(locationModel?.latitude ?? 0.0)]
        ColsomeManager.colsomeInfo(with: json)
    }
    
}
