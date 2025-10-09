//
//  Base.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/9.
//

import UIKit
import SnapKit
import RxSwift

class BaseView: UIView {
    let disposeBag = DisposeBag()
}

class BaseViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
