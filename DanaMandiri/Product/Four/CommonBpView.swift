//
//  CommonBpView.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/16.
//

import UIKit
import SnapKit
import RxSwift
import TYAlertController
import RxCocoa
internal import Contacts

class CommonBpView: UIView {
    
    var model: BaseModel?
    
    let disposeBag = DisposeBag()
    
    var tapClickBlock: ((CommonBpViewCell, Int) -> Void)?
    
    var allPhoneClickBlock: ((String) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(hexString: "#F2F8FC")
        tableView.register(CommonBpViewCell.self, forCellReuseIdentifier: "CommonBpViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CommonBpView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.salin?.toughel?.sipirangeular?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = model?.salin?.toughel?.sipirangeular?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonBpViewCell", for: indexPath) as! CommonBpViewCell
        cell.model = listModel
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if let listModel = listModel {
            self.enumClick(with: cell, listModel: listModel, indexPath: indexPath)
        }
        return cell
    }
    
}

extension CommonBpView {
    
    private func enumClick(with cell: CommonBpViewCell, listModel: sipirangeularModel, indexPath: IndexPath) {
        cell.tapClickBlock = { [weak self] in
            if let self = self, let viewController = self.getViewController() {
                self.endEditing(true)
                let popView = PopSelectGqView(frame: self.bounds)
                popView.model = listModel
                let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)!
                viewController.present(alertVc, animated: true)
                
                popView.cancelBtn.rx.tap.subscribe(onNext: {
                    viewController.dismiss(animated: true)
                }).disposed(by: disposeBag)
                
                popView.tapClickIndexBlock = { [weak self] bindex in
                    guard let self = self else { return }
                    let prehens = self.model?.salin?.toughel?.sipirangeular?[indexPath.row].archile?[bindex].pachyade ?? ""
                    let skillette = self.model?.salin?.toughel?.sipirangeular?[indexPath.row].archile?[bindex].skillette ?? ""
                    cell.nameTx.text = prehens
                    viewController.dismiss(animated: true) {
                        self.model?.salin?.toughel?.sipirangeular?[indexPath.row].clastoon = prehens
                        self.model?.salin?.toughel?.sipirangeular?[indexPath.row].phytfew = String(skillette)
                    }
                }
            }
        }
        
        cell.tapPhoneClickBlock = { [weak self] in
            if let self = self, let viewController = self.getViewController() {
                let clastoon = self.model?.salin?.toughel?.sipirangeular?[indexPath.row].clastoon ?? ""
                if clastoon.isEmpty {
                    ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "Please choose the relationship"))
                    return
                }
                
                ContactManager.shared.fetchAllContacts(on: viewController) { contacts in
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: contacts, options: [])
                        let base64String = jsonData.base64EncodedString()
                        self.allPhoneClickBlock?(base64String)
                    } catch {
                        print("Base64 failue: \(error)")
                    }
                }
                
                ContactManager.shared.selectSingleContact(on: viewController) { contact in
                    if let contact = contact {
                        let givenName = contact.givenName
                        let familyName = contact.familyName
                        
                        let phones = contact.phoneNumbers.map { $0.value.stringValue }
                        let phoneNumber = phones.first ?? ""
                        
                        let name = "\(givenName) \(familyName)"
                        
                        if name == " " {
                            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "The phone number is incorrect, please select again"))
                            return
                        }
                        
                        if phoneNumber.isEmpty {
                            ToastProgressHUD.showToastText(message: LanguageManager.localizedString(for: "The name is incorrect, please select again"))
                            return
                        }
                        cell.phoneTx.text = "\(name)-\(phoneNumber)"
                        
                        self.model?.salin?.toughel?.sipirangeular?[indexPath.row].pachyade = name
                        self.model?.salin?.toughel?.sipirangeular?[indexPath.row].merilet = phoneNumber
                        
                    } else {
                        print("cancel")
                    }
                }
            }
        }
    }
}
