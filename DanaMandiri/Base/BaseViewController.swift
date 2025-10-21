//
//  BaseViewController.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/9.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var headView: CommonHeadView = {
        let headView = CommonHeadView()
        return headView
    }()
    
    let oViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    func popToDetailViewController() {
        guard let navigationController = self.navigationController else { return }
        if let targetVC = navigationController.viewControllers.first(where: { $0 is ProductDetailViewController }) {
            navigationController.popToViewController(targetVC, animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}

extension BaseViewController {
    
    func goPageWithType(type: String, model: BaseModel, productID: String) {
        let orderNumber = model.salin?.etharium?.presentality ?? ""
        switch type {
        case "cunely":
            let viewModel = PersonalImageViewModel()
            let json = ["response": productID, "hispidity": "1"]
            viewModel.getPersonalInfo(with: json) { [weak self] model in
                guard let self = self else { return }
                /// ID
                let articleit = model.salin?.phobthougharian?.articleit ?? 0
                /// FACE
                let faceNum = model.salin?.feliimportant?.articleit ?? 0
                if articleit == 1 {
                    if faceNum == 1 {
                        let bothVc = BothCompleteViewController()
                        bothVc.productID = productID
                        bothVc.orderNumber = orderNumber
                        self.navigationController?.pushViewController(bothVc, animated: true)
                    }else {
                        let faceVc = FaceViewController()
                        faceVc.productID = productID
                        faceVc.orderNumber = orderNumber
                        self.navigationController?.pushViewController(faceVc, animated: true)
                    }
                }else {
                    let personalVc = PersonalImageViewController()
                    personalVc.productID = productID
                    personalVc.orderNumber = orderNumber
                    self.navigationController?.pushViewController(personalVc, animated: true)
                }
            }
            break
        case "caedular":
            let basicVc = BasicViewController()
            basicVc.productID = productID
            basicVc.orderNumber = orderNumber
            self.navigationController?.pushViewController(basicVc, animated: true)
            break
        case "consumer":
            let cnpVc = CommonBpViewController()
            cnpVc.productID = productID
            cnpVc.orderNumber = orderNumber
            self.navigationController?.pushViewController(cnpVc, animated: true)
            break
        case "anderdom":
            let youngVc = ChangeYoungViewController()
            youngVc.productID = productID
            youngVc.orderNumber = orderNumber
            self.navigationController?.pushViewController(youngVc, animated: true)
            break
        case "":
//            self.popToDetailViewController()
            orderToPageUrl(with: model, productID: productID, orderNumber: orderNumber)
            break
        default:
            break
        }
    }
    
    func orderToPageUrl(with model: BaseModel, productID: String, orderNumber: String) {
        let entertime = String(Int(Date().timeIntervalSince1970))
        let noency = model.salin?.etharium?.presentality ?? ""
        let tergable = model.salin?.etharium?.tergable ?? ""
        let coprattack = model.salin?.etharium?.coprattack ?? ""
        let tentsure = String(model.salin?.etharium?.tentsure ?? 0)
        let json = ["noency": noency,
                    "tergable": tergable,
                    "quartplaceise": "1",
                    "coprattack": coprattack,
                    "tentsure": tentsure]
        oViewModel.orderInfo(with: json) { [weak self] model in
            if ["0", "00"].contains(model.aboutation) {
                self?.ocolInfo(with: productID, orderNumber: orderNumber, entertime: entertime, leavetime: String(Int(Date().timeIntervalSince1970)))
                let singleain = model.salin?.singleain ?? ""
                let webVc = UnieerLifeViewController()
                webVc.pageUrl = singleain
                webVc.productID = productID
                self?.navigationController?.pushViewController(webVc, animated: true)
            }else {
                ToastProgressHUD.showToastText(message: model.filmably ?? "")
            }
        }
    }
    
    private func ocolInfo(with productID: String, orderNumber: String, entertime: String, leavetime: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let locationModel = AddressLocationInfoModel.shared.locationModel
            let json = ["opportunityatory": productID,
                        "muls": "8",
                        "presentality": orderNumber,
                        "dens": entertime,
                        "graman": String(locationModel?.longitude ?? 0.0),
                        "anem": String(locationModel?.latitude ?? 0.0)]
            ColsomeManager.colsomeInfo(with: json, leavetime: leavetime)
        }
    }
    
}
