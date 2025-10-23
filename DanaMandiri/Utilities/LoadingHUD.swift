//
//  LoadingHUD.shared.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/10.
//

import UIKit
import SnapKit

final class LoadingHUD {
    
    static let shared = LoadingHUD()
    
    private var containerView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    private var loadingCount = 0
    
    private init() {}
    
    func show() {
        DispatchQueue.main.async {
            self.loadingCount += 1
            if self.containerView != nil { return }
            
            guard let window = self.getKeyWindow() else { return }
            
            let background = UIView()
            background.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            window.addSubview(background)
            background.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            let hudBox = UIView()
            hudBox.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            hudBox.layer.cornerRadius = 12
            background.addSubview(hudBox)
            hudBox.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.height.equalTo(100)
            }
            
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.startAnimating()
            hudBox.addSubview(indicator)
            indicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            self.containerView = background
            self.activityIndicator = indicator
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.loadingCount = max(self.loadingCount - 1, 0)
            guard self.loadingCount == 0 else { return }
            
            self.activityIndicator?.stopAnimating()
            self.containerView?.removeFromSuperview()
            self.containerView = nil
            self.activityIndicator = nil
        }
    }
    
    func forceHide() {
        DispatchQueue.main.async {
            self.loadingCount = 0
            self.activityIndicator?.stopAnimating()
            self.containerView?.removeFromSuperview()
            self.containerView = nil
            self.activityIndicator = nil
        }
    }
    
    private func getKeyWindow() -> UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }
}
