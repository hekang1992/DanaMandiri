//
//  LoadingHUD.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit
import SnapKit

final class LoadingHUD {
    
    static let shared = LoadingHUD()
    private init() {}
    
    private var loadingView: UIView?
    
    class func show() {
        DispatchQueue.main.async {
            
            guard let window = currentWindow else {
                print("⚠️ LoadingHUD: no window")
                return
            }
            
            if shared.loadingView != nil {
                hide()
            }
            
            let containerView = UIView()
            containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            window.addSubview(containerView)
            containerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            let hudView = UIView()
            hudView.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
            hudView.layer.cornerRadius = 12
            hudView.clipsToBounds = true
            containerView.addSubview(hudView)
            
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.startAnimating()
            hudView.addSubview(indicator)
            
            hudView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(80)
            }
            
            indicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            containerView.alpha = 0
            hudView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            UIView.animate(withDuration: 0.3) {
                containerView.alpha = 1
                hudView.transform = .identity
            }
            
            shared.loadingView = containerView
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
            guard let loadingView = shared.loadingView else { return }
            
            UIView.animate(withDuration: 0.2, animations: {
                loadingView.alpha = 0
            }) { _ in
                loadingView.removeFromSuperview()
                shared.loadingView = nil
            }
        }
    }
    
    private static var currentWindow: UIWindow? {
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive })?
            .windows
            .first(where: { $0.isKeyWindow }) {
            return window
        }
        if let window = UIApplication.shared.windows.first(where: { !$0.isHidden }) {
            return window
        }
        return nil
    }
}
