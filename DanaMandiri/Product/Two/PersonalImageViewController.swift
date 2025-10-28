//
//  PersonalImageViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

class PersonalImageViewController: BaseViewController {
    
    var productID: String = ""
    
    var orderNumber: String = ""
    
    let disposeBag = DisposeBag()
    
    let viewModel = PersonalImageViewModel()
    
    let detailViewModel = ProductViewModel()
    
    lazy var personalView: PersonalImageView = {
        let personalView = PersonalImageView()
        return personalView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()
    
    var entertime: String = ""
    
    var leavetime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        LocationManager.shared.requestLocation { model in
            AddressLocationInfoModel.shared.locationModel = model
        }
        
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
        
        view.addSubview(personalView)
        personalView.snp.makeConstraints { make in
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
        
        personalView.uploadBlock = { [weak self] model in
            let articleit = model.salin?.phobthougharian?.articleit ?? 0
            self?.uploadImageInfo(with: String(articleit), isNextBtn: "0")
        }
        
        personalView.nextBlock = { [weak self] model in
            let articleit = model.salin?.phobthougharian?.articleit ?? 0
            self?.uploadImageInfo(with: String(articleit), isNextBtn: "1")
        }
        
        entertime = String(Int(Date().timeIntervalSince1970))
        
        getPersonalInfo()
    }
    
}

extension PersonalImageViewController {
    
    /// 判断是否上传了身份证---获取身份信息
    private func getPersonalInfo() {
        let json = ["response": productID, "hispidity": "1"]
        viewModel.getPersonalInfo(with: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                self.personalView.model = model
            }
        }
    }
    
    private func uploadImageInfo(with type: String, isNextBtn: String) {
        if type == "1" {
            /// GO_FACE
            if isNextBtn == "1" {
//                let faceVc = FaceViewController()
//                faceVc.productID = productID
//                faceVc.orderNumber = orderNumber
//                self.navigationController?.pushViewController(faceVc, animated: true)
                
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
            CameraManager.shared.takePhoto { [weak self] image in
                if let image = image {
                    self?.uoloimage(with: image)
                } else {
                    print("cancel=======")
                }
            }
            
        }
    }
    
    
    private func uoloimage(with image: UIImage) {
        let json = ["skillette": "11",
                    "uvulent": "2",
                    "mediast": "",
                    "cladal": "1",
                    "archriskage": "en"]
        viewModel.uploadPersonalImageInfo(with: json, image: image) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                DispatchQueue.main.async {
                    self?.popSueecInfo(with: model)
                }
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
            }
        }
    }
    
    private func popSueecInfo(with model: BaseModel) {
        let popView = PopPersonalInfoView(frame: self.view.bounds)
        if let salinModel = model.salin {
            popView.model = salinModel
        }
        let alsetVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)!
        self.present(alsetVc, animated: true)
        
        popView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        popView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.saveImageInfo(with: popView)
        }).disposed(by: disposeBag)
        
        popView.timeBlock = { time in
            let popTimeView = PopSelectTimeInfoView(frame: self.view.bounds)
            popTimeView.defaultDateString = time
            popTimeView.confirmBlock = { dateStr in
                popView.timeLabel.text = dateStr
                popView.timeLabel.textColor = UIColor.init(hexString: "#0E0F0F")
                popTimeView.removeFromSuperview()
            }
            
            popTimeView.cancelBtn.rx.tap.subscribe(onNext: { _ in
                popTimeView.removeFromSuperview()
            }).disposed(by: self.disposeBag)
            
            if let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows.first(where: { $0.isKeyWindow }) {
                
                window.addSubview(popTimeView)
                popTimeView.bgImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                popTimeView.bgImageView.alpha = 0
                UIView.animate(withDuration: 0.25,
                               delay: 0,
                               usingSpringWithDamping: 0.8,
                               initialSpringVelocity: 0.5,
                               options: .curveEaseOut,
                               animations: {
                    popTimeView.bgImageView.transform = .identity
                    popTimeView.bgImageView.alpha = 1
                })
            }
        }
        
    }
    
    private func saveImageInfo(with popView: PopPersonalInfoView) {
        let name = popView.nameTx.text ?? ""
        let idnum = popView.idNumberTx.text ?? ""
        let time = popView.timeLabel.text ?? ""
        if name.isEmpty {
            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Real Name"))
            return
        }
        if idnum.isEmpty {
            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "ID Number"))
            return
        }
        if time.isEmpty {
            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Birthday"))
            return
        }
        let phone = AuthLoginManager.shared.getPhoneNumber() ?? ""
        leavetime = String(Int(Date().timeIntervalSince1970))
        let json = ["playty": "1",
                    "polyward": time,
                    "segetical": idnum,
                    "pachyade": name,
                    "noency": orderNumber,
                    "merilet": phone,
                    "response": productID]
        viewModel.savePersonalInfo(with: json) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    self.colInfo()
                    self.getPersonalInfo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        let json = ["response": self.productID, "spatitenics": "101"]
                        self.detailViewModel.getProductDetailInfo(with: json) { [weak self] model in
                            guard let self = self else { return }
                            let type = model.salin?.shake?.resourceosity ?? ""
                            self.goPageWithType(type: type, model: model, productID: productID)
                        }
                    }
                }
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
                        "muls": "2",
                        "presentality": orderNumber,
                        "dens": entertime,
                        "graman": String(longitude),
                        "anem": String(latitude)]
            ColsomeManager.colsomeInfo(with: json, leavetime: leavetime)
        }
    }
    
}
