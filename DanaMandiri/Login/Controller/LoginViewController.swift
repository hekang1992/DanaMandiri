//
//  LoginViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/9.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import FBSDKCoreKit
import AppTrackingTransparency

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()
    
    let loginViewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    private var countdownTimer: Timer?
    
    private var remainingSeconds: Int = 60
    
    var entertime: String = ""
    
    var leavetime: String = ""
    
    let locationManagerModel = LocationManagerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        entertime = String(Int(Date().timeIntervalSince1970))
        
        loginView.phoneCodeView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.toCodeInfo()
        }).disposed(by: disposeBag)
        
        loginView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.toLoginInfo()
        }).disposed(by: disposeBag)
        
        /// LOCATION_PERSMISSON_INFO
        LocationManager.shared.requestLocation { [weak self] info in
            switch info {
            case .success(let success):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    print("info====location------\(info)")
                    AddressLocationInfoModel.shared.locationModel = success
                    self?.toLocationInfo(with: success)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
}

extension LoginViewController {
    
    private func toLoginInfo() {
        LoginTimeManager.shared.leavetime = String(Date().timeIntervalSince1970)
        let phone = self.loginView.phoneListView.phoneTx.text ?? ""
        let code = self.loginView.phoneCodeView.phoneTx.text ?? ""
        if phone.isEmpty {
            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Please enter your phone number"))
            return
        }
        if code.isEmpty {
            ToastProgressHUD.showToastText(message: "")
            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Please enter the verification code"))
            return
        }
        if self.loginView.cycleBtn.isSelected == false {
            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Please review and confirm the agreement"))
            return
        }
        let json = ["thatise": phone,
                    "sophoency": code,
                    "himselfform": "tologin",
                    "determine": "1"]
        loginViewModel.toLogin(json: json) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                let phone = model.salin?.thatise ?? ""
                let token = model.salin?.cast ?? ""
                AuthLoginManager.shared.saveLoginInfo(phone: phone, token: token)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                }
                let locationModel = AddressLocationInfoModel.shared.locationModel
                let colJson = ["opportunityatory": "",
                               "muls": "1",
                               "presentality": "",
                               "dens": self?.entertime ?? "",
                               "graman": String(locationModel?.longitude ?? 0.0),
                               "anem": String(locationModel?.latitude ?? 0.0)]
                ColsomeManager.colsomeInfo(with: colJson)
            }else {
                AuthLoginManager.shared.removeLoginInfo()
            }
        }
    }
    
    private func toCodeInfo() {
        let phone = self.loginView.phoneListView.phoneTx.text ?? ""
        let json = ["leaderad": phone, "thalam": "1"]
        loginViewModel.getCode(json: json) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                self?.startCodeTime()
            }
        }
    }
    
    private func startCodeTime() {
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateCountdown),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func updateCountdown() {
        remainingSeconds -= 1
        updateButtonTitle()
        
        if remainingSeconds <= 0 {
            stopCountdown()
        }
    }
    
    private func updateButtonTitle() {
        if remainingSeconds > 0 {
            loginView.phoneCodeView.againBtn.isEnabled = false
            loginView.phoneCodeView.againBtn.setTitle("\(remainingSeconds)s", for: .normal)
        } else {
            loginView.phoneCodeView.againBtn.isEnabled = true
            loginView.phoneCodeView.againBtn.setTitle(LanguageManager.localizedString(for: "Code"), for: .normal)
        }
    }
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        loginView.phoneCodeView.againBtn.isEnabled = true
        remainingSeconds = 60
    }
    
}

extension LoginViewController {
    
    private func toLocationInfo(with model: LocationInfo) {
        let administrativeArea = model.administrativeArea ?? ""
        let locality = model.locality ?? ""
        let pairs: [(String, Any)] = [
            ("studminute", administrativeArea.isEmpty ? locality : administrativeArea),
            ("memberion", model.countryCode ?? ""),
            ("sphinct", model.country ?? ""),
            ("matrkeyast", model.name ?? ""),
            ("anem", model.latitude),
            ("graman", model.longitude),
            ("nascitious", model.locality ?? ""),
            ("pancreesque", model.subLocality ?? "")
        ]
        
        let json = Dictionary(uniqueKeysWithValues: pairs)
        
        locationManagerModel.uoAddressinfo(json: json) { model in
            if ["0", "00"].contains(model.aboutation) {
                print("location=======suceess=======")
            }
        }
    }
}
