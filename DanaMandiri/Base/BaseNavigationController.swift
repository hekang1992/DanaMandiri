//
//  BaseNavigationController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/9.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    weak var tabBarDelegate: CustomTabBarControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if let gestureRecognizers = view.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let popGesture = gesture as? UIScreenEdgePanGestureRecognizer {
                    view.removeGestureRecognizer(popGesture)
                }
            }
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            tabBarDelegate?.setTabBarHidden(true, animated: animated)
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            tabBarDelegate?.setTabBarHidden(false, animated: animated)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            tabBarDelegate?.setTabBarHidden(false, animated: false)
        }
    }
}
