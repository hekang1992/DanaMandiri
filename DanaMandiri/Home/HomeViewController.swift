//
//  HomeViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit
import RxSwift
import RxRelay
import SnapKit
import MJRefresh
import CoreLocation
import TYAlertController

class HomeViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let homeViewModel = HomeViewModel()
    
    var homeModel = BehaviorRelay<BaseModel?>(value: nil)
    
    var smallModel: socialModel?
    
    let locationManagerModel = LocationManagerModel()
    
    lazy var smallView: SmallMainView = {
        let smallView = SmallMainView(frame: .zero)
        smallView.isHidden = true
        return smallView
    }()
    
    lazy var homeView: HomeView = {
        let homeView = HomeView(frame: .zero)
        homeView.isHidden = true
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(smallView)
        smallView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(85)
        }
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(85)
        }
        
        smallView.twoBlock = { [weak self] clickBtn, productID in
            self?.applyInfo(with: productID, clickBtn: clickBtn)
        }
        
        smallView.threeBlock = { [weak self] pageUrl in
            if pageUrl.isEmpty {
                return
            }else {
                let webVc = UnieerLifeViewController()
                webVc.pageUrl = pageUrl
                self?.navigationController?.pushViewController(webVc, animated: true)
            }
        }
        
        smallView.fourBlock = { [weak self] clickBtn, productID in
            self?.applyInfo(with: productID, clickBtn: clickBtn)
        }
        
        /// REFRESH_HOME_INFO
        smallView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeInfo()
        })
        
        homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeInfo()
        })
        
        /// HOME_DETAIL_INFO
        self.homeModel.asObservable().subscribe(onNext: { model in
            guard let model = model else { return }
            let listArray = model.salin?.sipirangeular ?? []

            if let index = listArray.firstIndex(where: { $0.skillette == "successfultic" }) {
                print("✅ successfultic，index=====: \(index)")
                /// SMALL_CARD
                self.smallView.isHidden = false
                self.homeView.isHidden = true
                self.smallView.smallModel = listArray[index].social?.first
                self.smallView.smallModelArray = listArray
                self.smallView.tableView.reloadData()
            } else {
                print("❌ no successfultic")
                /// BIG_CARD
                self.smallView.isHidden = true
                self.homeView.isHidden = false
                let index = listArray.firstIndex(where: { $0.skillette == "tricesimition" }) ?? 0
                self.homeView.smallModel = listArray[index].social?.first
                self.smallModel = self.homeView.smallModel
            }
        }).disposed(by: disposeBag)
        
        ///APPLY_PRODUCT
        homeView.applyBlock = { [weak self] clickBtn in
            let testnature = String(self?.smallModel?.testnature ?? 0)
            self?.applyInfo(with: testnature, clickBtn: clickBtn)
        }
        
        homeViewModel.getAdressInfo { model in
            if ["0", "00"].contains(model.aboutation) {
                CityAddressModel.shared.cityModel = model.salin
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            NotificationCenter.default.post(name: Notification.Name("aTTracking"), object: nil, userInfo: ["type": "home"])
        }
        
        LocationManager.shared.requestLocation { model in
            AddressLocationInfoModel.shared.locationModel = model
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
}

extension HomeViewController {
    
    private func upComputerLoadInfo() {
        let json = DeviceInfoManager.backJson()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)!
            if let base64Data = jsonString.data(using: .utf8) {
                let base64String = base64Data.base64EncodedString()
                let dictJson = ["salin": base64String]
                homeViewModel.uploadSbInfo(with: dictJson) { model in }
            }
        } catch {
            
        }
    }
    
    private func toLocationInfo() {
        if let model = AddressLocationInfoModel.shared.locationModel {
            let administrativeArea = model.administrativeArea ?? ""
            let locality = model.locality ?? ""
            let pairs: [(String, Any)] = [
                ("studminute", administrativeArea.isEmpty ? locality : administrativeArea),
                ("memberion", model.countryCode ?? ""),
                ("sphinct", model.country ?? ""),
                ("matrkeyast", model.name ?? ""),
                ("anem", String(model.latitude)),
                ("graman", String(model.longitude)),
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
    
    private func buOneInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let entertime = UserDefaults.standard.object(forKey: "entertime") as? String ?? ""
            let locationModel = AddressLocationInfoModel.shared.locationModel
            let colJson = ["opportunityatory": "",
                           "muls": "1",
                           "presentality": "",
                           "dens": entertime,
                           "graman": String(locationModel?.longitude ?? 0.0),
                           "anem": String(locationModel?.latitude ?? 0.0)]
            ColsomeManager.colsomeInfo(with: colJson, leavetime: String(Int(Date().timeIntervalSince1970)))
        }
    }
    
    private func getHomeInfo() {
        homeViewModel.getHomeInfo { [weak self] model in
            self?.smallView.tableView.mj_header?.endRefreshing()
            self?.homeView.scrollView.mj_header?.endRefreshing()
            if ["0", "00"].contains(model.aboutation) {
                self?.homeModel.accept(model)
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
                if model.aboutation == "-2" {
                    AuthLoginManager.shared.removeLoginInfo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                    }
                }
            }
        }
    }
    
    private func applyInfo(with productID: String, clickBtn: UIButton) {
        buOneInfo()
        upComputerLoadInfo()
        toLocationInfo()
        
        let cin = CinInfoModel.shared.cinModel?.cin ?? ""
        
        let status = CLLocationManager().authorizationStatus
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            applyProductInfo(with: productID, clickBtn: clickBtn)
        }else {
            if cin == "460" {
                ShowLocationPermissionAlert.showPermissionAlert(on: self)
            }else {
                applyProductInfo(with: productID, clickBtn: clickBtn)
            }
        }
        
    }
    private func applyProductInfo(with productID: String, clickBtn: UIButton) {
        clickBtn.isEnabled = false
        LoadingHUD.shared.show()
        let json = ["typefication": "1001",
                    "dynaance": "1000",
                    "noticeion": "1000",
                    "response": productID]
        homeViewModel.applyProductInfo(with: json) { [weak self] model in
            clickBtn.isEnabled = true
            LoadingHUD.shared.hide()
            if ["0", "00"].contains(model.aboutation) {
                let anteaneity = model.salin?.recordenne?.anteaneity ?? []
                if anteaneity.isEmpty {
                    let singleain = model.salin?.singleain ?? ""
                    self?.goWithPageUrl(with: singleain, productID: productID)
                }else {
                    /// TOASW_INFO_POOP_VIEW
                    guard let self = self else { return }
                    let sayaView = PopSayaView(frame: self.view.bounds)
                    sayaView.modelArray = anteaneity
                    let alertVc = TYAlertController(alert: sayaView, preferredStyle: .alert)!
                    self.present(alertVc, animated: true)
                    
                    sayaView.cancelBlock = { [weak self] in
                        self?.dismiss(animated: true)
                    }
                    
                    sayaView.oneBlock = { [weak self] pageUrl in
                        self?.dismiss(animated: true) {
                            self?.goWithPageUrl(with: pageUrl, productID: productID)
                        }
                    }
                    
                    sayaView.twoBlock = { [weak self] pageUrl in
                        self?.dismiss(animated: true) {
                            self?.goWithPageUrl(with: pageUrl, productID: productID)
                        }
                    }
                    
                }
            }else {
                if model.aboutation == "-2" {
                    AuthLoginManager.shared.removeLoginInfo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
                    }
                }
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
            }
        }
    }
    
    func goWithPageUrl(with pageUrl: String, productID: String) {
        if pageUrl.contains(SCHEME_URL) {
            SchemeManager.handle(url: pageUrl)
        }else {
            let webVc = UnieerLifeViewController()
            webVc.pageUrl = pageUrl
            webVc.productID = productID
            self.navigationController?.pushViewController(webVc, animated: true)
        }
    }
    
}


class ShowLocationPermissionAlert {
    static func showPermissionAlert(on vc: UIViewController) {
         let alert = UIAlertController(
            title: LanguageManager.localizedString(for: "Location permission is disabled"),
            message: LanguageManager.localizedString(for: "Please enable location permission in Settings to use the location"),
             preferredStyle: .alert
         )
         
        alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Cancel"), style: .cancel))
         alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Settings"), style: .default, handler: { _ in
             if let url = URL(string: UIApplication.openSettingsURLString) {
                 UIApplication.shared.open(url)
             }
         }))
         
         vc.present(alert, animated: true)
     }
}
