//
//  SettingViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import TYAlertController

class SettingViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "login_logo_image")
        return logoImageView
    }()
    
    lazy var listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        listLabel.textAlignment = .center
        listLabel.font = UIFont.system(20, weightValue: 700)
        listLabel.text = "Dana Mandiri"
        return listLabel
    }()
    
    lazy var vLabel: UILabel = {
        let vLabel = UILabel()
        vLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        vLabel.textAlignment = .center
        vLabel.font = UIFont.system(14, weightValue: 500)
        vLabel.text = "\(LanguageManager.localizedString(for: "Version")): 1.0.0"
        return vLabel
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle(LanguageManager.localizedString(for: "Go Out"), for: .normal)
        againBtn.setTitleColor(UIColor.init(hexString: "#009F1E"), for: .normal)
        againBtn.titleLabel?.font = UIFont.system(16, weightValue: 600)
        againBtn.layer.cornerRadius = 24
        againBtn.layer.borderWidth = 1
        againBtn.layer.borderColor = UIColor.init(hexString: "#009F1E").cgColor
        return againBtn
    }()
    
    lazy var deleteAccBtn: UIButton = {
        let deleteAccBtn = UIButton(type: .custom)
        deleteAccBtn.setTitle(LanguageManager.localizedString(for: "Account Cancellation"), for: .normal)
        deleteAccBtn.setTitleColor(.white, for: .normal)
        deleteAccBtn.titleLabel?.font = UIFont.system(16, weightValue: 600)
        deleteAccBtn.layer.cornerRadius = 24
        deleteAccBtn.layer.borderWidth = 1
        deleteAccBtn.layer.borderColor = UIColor.white.cgColor
        return deleteAccBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headView.listLabel.text = LanguageManager.localizedString(for: "Settings")
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
        }
        
        headView.againBtn.rx.tap.subscribe(onNext: {
            self.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 335, height: 310))
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        bgView.addSubview(listLabel)
        listLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 220, height: 20))
        }
        
        bgView.addSubview(vLabel)
        vLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(listLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 220, height: 14))
        }
        
        vLabel.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
            ToastProgressHUD.showToastText(message: "\(LanguageManager.localizedString(for: "Version")): 1.0.0")
        }).disposed(by: disposeBag)
        
        bgView.addSubview(againBtn)
        againBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 50))
        }
        
        view.addSubview(deleteAccBtn)
        deleteAccBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295, height: 50))
        }
        
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        deleteAccBtn.isHidden = cin == "460"
        
        
        againBtn.rx.tap.subscribe(onNext: {
            let outView = LogOutView(frame: self.view.bounds)
            let alertVc = TYAlertController(alert: outView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            outView.cancelBlock = {
                self.dismiss(animated: true)
            }
            outView.exitBlock = {
                self.dismiss(animated: true) {
                    self.outInfo()
                }
            }
        }).disposed(by: disposeBag)
        
        deleteAccBtn.rx.tap.subscribe(onNext: {
            let delView = DeleteAccountView(frame: self.view.bounds)
            let alertVc = TYAlertController(alert: delView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            delView.cancelBlock = {
                self.dismiss(animated: true)
            }
            delView.exitBlock = {
                if delView.cycleBtn.isSelected {
                    self.dismiss(animated: true) {
                        self.delInfo()
                    }
                }else {
                    ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Please review and confirm the agreement"))
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
}

extension SettingViewController {
    
    /// LOG_OUT
    private func outInfo() {
        LoadingHUD.show(text: "Loading...")
        NetworkManager.shared.getRequest(url: "/taxile/aboutation", responseType: BaseModel.self) { reslut in
            switch reslut {
            case .success(let success):
                if ["0", "00"].contains(success.aboutation) {
                    AuthLoginManager.shared.removeLoginInfo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                    }
                }
                ToastProgressHUD.showToastText(message: success.filmably ?? "")
                LoadingHUD.hide()
                break
            case .failure(_):
                LoadingHUD.hide()
                break
            }
        }
    }
    
    /// DELETE_ACC
    private func delInfo() {
        LoadingHUD.show(text: "Loading...")
        NetworkManager.shared.getRequest(url: "/taxile/tern", responseType: BaseModel.self) { reslut in
            switch reslut {
            case .success(let success):
                if ["0", "00"].contains(success.aboutation) {
                    AuthLoginManager.shared.removeLoginInfo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                    }
                }
                ToastProgressHUD.showToastText(message: success.filmably ?? "")
                LoadingHUD.hide()
                break
            case .failure(_):
                LoadingHUD.hide()
                break
            }
        }
    }
    
}
