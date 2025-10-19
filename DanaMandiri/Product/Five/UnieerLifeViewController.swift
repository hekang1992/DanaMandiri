//
//  UnieerLifeViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/16.
//

import UIKit
import WebKit
import SnapKit
import RxSwift
import RxCocoa
import StoreKit

class UnieerLifeViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    
    var entertime: String = ""
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "dl_bg")
        return bgImageView
    }()
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let scriptNames = [
            "vigenveryature", "chlorid", "picish",
            "tardature", "thrixacious", "bront"]
        scriptNames.forEach {
            configuration.userContentController.add(self, name: $0)
        }
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.black
        progressView.trackTintColor = UIColor.init(hexString: "#F6FFF1")
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(2)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.height.equalTo(2)
            make.left.right.equalToSuperview()
        }
        
        headView.againBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }).disposed(by: disposeBag)
        
        getWebInfo()
        
        guard let encodedUrlString = pageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let finalUrlString = URLQueryBuilder.appendingQueryParameters(
                to: encodedUrlString,
                parameters: APIQueryBuilder.getParameters()
              ),
              let finalUrl = URL(string: finalUrlString) else {
            print("Failed to construct valid URL from: \(pageUrl)")
            return
        }
        
        webView.load(URLRequest(url: finalUrl))
        
    }
    
}

extension UnieerLifeViewController {
    
    private func getWebInfo() {
        webView.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.headView.listLabel.text = title
                }
            }).disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .map { Float($0) }
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .filter { $0 == 1.0 }
            .subscribe(onNext: { [weak self] _ in
                self?.progressView.setProgress(0.0, animated: false)
                self?.progressView.isHidden = true
            })
            .disposed(by: disposeBag)
    }
    
    
}

extension UnieerLifeViewController: WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("name========\(message.name)")
        print("body========\(message.body)")
        switch message.name {
        case "picish":
            self.navigationController?.popToRootViewController(animated: true)
            break
        case "tardature":
            changeVc()
            break
        case "bront":
            toAppStore()
            break
        case "vigenveryature":
            let body = message.body as? [String]
            colInfo(with: body?.last ?? "", productID: body?.first ?? "")
            break
        case "chlorid":
            break
        case "thrixacious":
            break
        default:
            break
        }
    }
    
    
}

extension UnieerLifeViewController {
    
    private func changeVc() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            NotificationCenter.default.post(name: Notification.Name("switchRootVc"), object: nil)
        }
    }
    
    private func toAppStore() {
        if #available(iOS 14.0, *), let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    private func colInfo(with orderNumber: String, productID: String) {
        let locationModel = AddressLocationInfoModel.shared.locationModel
        let json = ["opportunityatory": productID,
                    "muls": "9",
                    "presentality": orderNumber,
                    "dens": entertime,
                    "graman": String(locationModel?.longitude ?? 0.0),
                    "anem": String(locationModel?.latitude ?? 0.0)]
        ColsomeManager.colsomeInfo(with: json)
    }
    
}
