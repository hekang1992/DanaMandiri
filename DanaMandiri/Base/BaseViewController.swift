//
//  BaseViewController.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/9.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var headView: CommonHeadView = {
        let headView = CommonHeadView()
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    func popToSpecificViewController() {
//        guard let navigationController = self.navigationController else { return }
//        if let targetVC = navigationController.viewControllers.first(where: { $0 is AppStepViewViewController }) {
//            navigationController.popToViewController(targetVC, animated: true)
//        } else {
//            navigationController.popViewController(animated: true)
//        }
    }
    
}
