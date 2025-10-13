//
//  StartViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/9.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture
import RxCocoa
import KRProgressHUD

class StartViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle("Try again", for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 600)
        againBtn.layer.cornerRadius = 24
        againBtn.layer.borderWidth = 1
        againBtn.layer.borderColor = UIColor.white.cgColor
        return againBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(againBtn)
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.size.equalTo(CGSize(width: 184, height: 48))
        }
        
        againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.startInfo()
        }).disposed(by: disposeBag)
        
        startInfo()
    }
    
}

extension StartViewController {
    
    private func startInfo() {
        LoadingHUD.show(text: "Loading...")
        let json = ["wearic": String(ProxyStatus.connectionState),
                    "feelaneity": String(VPNStatus.connectionState),
                    "taenisouthernition": Locale.preferredLanguages.first ?? ""]
        NetworkManager.shared.postJsonRequest(url: "/taxile/pubertible",
                                              json: json,
                                              responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                if ["0", "00"].contains(success.aboutation) {
                    if let model = success.salin {
                        CinInfoModel.shared.cinModel = model
                        let cin = model.cin ?? ""
                        if let lang = AppLanguage(rawValue: cin) {
                            LanguageManager.setLanguage(lang)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                        }
                    }
                }else {
                    ToastProgressHUD.showToastText(message: success.filmably ?? "")
                }
                LoadingHUD.hide()
                break
            case .failure(_):
                LoadingHUD.hide()
                break
            }
        }
    }
    
}

class CinInfoModel{
    static let shared = CinInfoModel()
    private init() {}
    var cinModel: salinModel?
}
