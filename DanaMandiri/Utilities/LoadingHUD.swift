//
//  LoadingHUD.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit

final class LoadingHUD {
    
    static let shared = LoadingHUD()
    private init() {}
    
    private var loadingView: UIView?
    
    // MARK:
    class func show(text: String? = nil) {
        DispatchQueue.main.async {
            
            guard let window = currentWindow else {
                print("⚠️ LoadingHUD: no window")
                return
            }
            
            let containerView = UIView()
            containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            window.addSubview(containerView)
            containerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            // HUD
            let hudView = UIView()
            hudView.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
            hudView.layer.cornerRadius = 12
            hudView.clipsToBounds = true
            containerView.addSubview(hudView)
            
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.startAnimating()
            hudView.addSubview(indicator)
            
            var label: UILabel?
            if let text = text {
                let lbl = UILabel()
                lbl.text = text
                lbl.textColor = .white
                lbl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                lbl.textAlignment = .center
                lbl.numberOfLines = 0
                hudView.addSubview(lbl)
                label = lbl
            }
            
            // MARK: - SnapKit
            hudView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.lessThanOrEqualTo(160)
            }
            
            indicator.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(20)
            }
            
            if let label = label {
                label.snp.makeConstraints { make in
                    make.top.equalTo(indicator.snp.bottom).offset(10)
                    make.left.right.equalToSuperview().inset(12)
                    make.bottom.equalToSuperview().offset(-20)
                }
            } else {
                indicator.snp.makeConstraints { make in
                    make.bottom.equalToSuperview().offset(-20)
                }
            }
            
            shared.loadingView = containerView
        }
    }
    
    // MARK: - HIDE
    class func hide() {
        DispatchQueue.main.async {
            shared.loadingView?.removeFromSuperview()
            shared.loadingView = nil
        }
    }
    
    // MARK: -（iOS 14+）
    private static var currentWindow: UIWindow? {
        // 1️⃣
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive })?
            .windows
            .first(where: { $0.isKeyWindow }) {
            return window
        }
        
        // 2️⃣
        if let window = UIApplication.shared.windows.first(where: { !$0.isHidden }) {
            return window
        }
        
        // ✅
        return nil
    }
}
