//
//  FaceViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

class FaceViewController: BaseViewController {
    
    var productID: String = ""
    
    var orderNumber: String = ""
    
    let disposeBag = DisposeBag()
    
    var entertime: String = ""
    
    var leavetime: String = ""
    
    let viewModel = PersonalImageViewModel()
    
    let detailViewModel = ProductViewModel()
    
    lazy var faceView: FaceView = {
        let faceView = FaceView()
        return faceView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
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
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        view.addSubview(faceView)
        faceView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(5)
        }
        
        headView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let leaveView = PopLeaveDownView(frame: self.view.bounds)
            let alertVc = TYAlertController(alert: leaveView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            leaveView.cancelBlock = {
                self.dismiss(animated: true) {
                    self.popToDetailViewController()
                }
            }
            leaveView.leaveBlock = {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
        
        faceView.uploadBlock = { [weak self] model in
            let articleit = model.salin?.feliimportant?.articleit ?? 0
            self?.uploadImageInfo(with: String(articleit), isNextBtn: "0")
        }
        
        faceView.nextBlock = { [weak self] model in
            let articleit = model.salin?.feliimportant?.articleit ?? 0
            self?.uploadImageInfo(with: String(articleit), isNextBtn: "1")
        }
        
        getPersonalInfo()
    }
    
}

extension FaceViewController {
    
    /// 判断是否上传了身份证---获取身份信息
    private func getPersonalInfo() {
        let json = ["response": productID, "hispidity": "1"]
        viewModel.getPersonalInfo(with: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                self.faceView.model = model
            }
        }
    }
    
    private func uploadImageInfo(with type: String, isNextBtn: String) {
        if type == "1" {
            /// GO_FACE
            if isNextBtn == "1" {
                let json = ["response": productID, "spatitenics": "101"]
                detailViewModel.getProductDetailInfo(with: json) { [weak self] model in
                    guard let self = self else { return }
                    let type = model.salin?.shake?.resourceosity ?? ""
                    self.goPageWithType(type: type, model: model, productID: productID)
                }
            }else {
                ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "The identity information has been uploaded"))
            }
        }else {
            /// GET_CAMERA_PERSSION
            CameraManager.shared.takePhoto("1") { [weak self] image in
                if let image = image {
                    self?.uoloimage(with: image)
                } else {
                    print("cancel=======")
                }
            }

        }
    }
    
    
    private func uoloimage(with image: UIImage) {
        let json = ["skillette": "10",
                    "uvulent": "2",
                    "mediast": "",
                    "cladal": "1",
                    "archriskage": "en"]
        leavetime = String(Int(Date().timeIntervalSince1970))
        viewModel.uploadPersonalImageInfo(with: json, image: image) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                self?.getPersonalInfo()
                self?.colInfo()
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
            }
        }
    }
    
    private func colInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
            let locationModel = AddressLocationInfoModel.shared.locationModel
            let json = ["opportunityatory": productID,
                        "muls": "3",
                        "presentality": orderNumber,
                        "dens": entertime,
                        "graman": String(locationModel?.longitude ?? 0.0),
                        "anem": String(locationModel?.latitude ?? 0.0)]
            ColsomeManager.colsomeInfo(with: json, leavetime: leavetime)
        }
    }
    
}
