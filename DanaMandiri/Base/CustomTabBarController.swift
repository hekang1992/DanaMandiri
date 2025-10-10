//
//  CustomerTabBarController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/10.
//

import UIKit
import SnapKit

class CustomTabBarController: UIViewController {
    
    private let tabBarHeight: CGFloat = 85
    private let customTabBar = UIView()
    private var buttons: [UIButton] = []
    private var childVCs: [UIViewController] = []
    private var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupChildren()
        setupCustomTabBar()
        select(index: 0)
    }
    
    private func setupChildren() {
        let homeVC = BaseNavigationController(rootViewController: HomeViewController())
        let orderVc = BaseNavigationController(rootViewController: OrderViewController())
        let centerVc = BaseNavigationController(rootViewController: CenterViewController())
        
        childVCs = [homeVC, orderVc, centerVc]
        
        for vc in childVCs {
            addChild(vc)
            view.addSubview(vc.view)
            vc.view.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.bottom.equalToSuperview().inset(tabBarHeight)
            }
            vc.didMove(toParent: self)
            vc.view.isHidden = true
        }
    }
    
    private func setupCustomTabBar() {
        customTabBar.backgroundColor = .white
        customTabBar.clipsToBounds = false
        view.addSubview(customTabBar)
        
        customTabBar.layer.shadowColor = UIColor.black.cgColor
        customTabBar.layer.shadowOpacity = 0.15
        customTabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        customTabBar.layer.shadowRadius = 3
        
        customTabBar.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(tabBarHeight)
        }
        
        let titles = [
            LanguageManager.localizedString(for: "Home"),
            LanguageManager.localizedString(for: "Order"),
            LanguageManager.localizedString(for: "My")]
        
        let images = [UIImage(named: "li_hone_icon_image_normal"),
                      UIImage(named: "li_order_icon_image_normal"),
                      UIImage(named: "li_center_icon_image_normal")]
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        customTabBar.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(35)
            make.left.right.equalToSuperview().inset(20)
        }
        
        for i in 0..<titles.count {
            let btn = UIButton(type: .custom)
            btn.setTitle(titles[i], for: .normal)
            btn.setImage(images[i]?.withRenderingMode(.alwaysTemplate), for: .normal)
            btn.setTitleColor(UIColor.init(hexString: "#8D8D8D"), for: .normal)
            btn.setTitleColor(UIColor.init(hexString: "#0E0F0F"), for: .selected)
            btn.tintColor = .gray
            btn.tag = i
            btn.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
            btn.titleLabel?.font = UIFont.system(12, weightValue: 600)
            btn.layer.cornerRadius = 17
            btn.clipsToBounds = true
            
            btn.semanticContentAttribute = .forceLeftToRight
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            
            stack.addArrangedSubview(btn)
            buttons.append(btn)
        }
    }
    
    @objc private func onTap(_ sender: UIButton) {
        select(index: sender.tag)
    }
    
    private func select(index: Int) {
        guard index >= 0 && index < childVCs.count else { return }
        
        childVCs[selectedIndex].view.isHidden = true
        childVCs[index].view.isHidden = false
        selectedIndex = index
        
        for (i, btn) in buttons.enumerated() {
            let isSelected = (i == index)
            btn.isSelected = isSelected
            btn.backgroundColor = isSelected ? UIColor(hexString: "#009F1E").withAlphaComponent(0.36) : .white
            btn.tintColor = isSelected ? .black : .gray
        }
    }
    
}
