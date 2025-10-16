//
//  BasicView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/14.
//

import UIKit
import SnapKit
import RxSwift
import TYAlertController
import RxCocoa

class BasicView: UIView {
    
    var model: BaseModel?
    
    let disposeBag = DisposeBag()
    
    var tapClickBlock: ((TapClickViewCell, Int) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(hexString: "#F2F8FC")
        tableView.register(TapClickViewCell.self, forCellReuseIdentifier: "TapClickViewCell")
        tableView.register(EnterInputViewCell.self, forCellReuseIdentifier: "EnterInputViewCell")
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

extension BasicView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.salin?.clastoon?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = model?.salin?.clastoon?[indexPath.row]
        let uxori = listModel?.uxori ?? ""
        if uxori == "clearsive" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnterInputViewCell", for: indexPath) as! EnterInputViewCell
            cell.model = listModel
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.textChangedHandler = { [weak self] text in
                self?.model?.salin?.clastoon?[indexPath.row].prehens = text
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TapClickViewCell", for: indexPath) as! TapClickViewCell
            cell.model = listModel
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            /// CITY_INFO
            if uxori == "xylical" {
                if let listModel = listModel {
                    self.cityClick(with: cell, listModel: listModel, indexPath: indexPath)
                }
            }else {
                if let listModel = listModel {
                    self.enumClick(with: cell, listModel: listModel, indexPath: indexPath)
                }
            }
            return cell
        }
    }
    
}

extension BasicView {
    
    private func enumClick(with cell: TapClickViewCell, listModel: clastoonModel, indexPath: IndexPath) {
        cell.tapClickBlock = { [weak self] in
            if let self = self, let viewController = self.getViewController() {
                self.endEditing(true)
                let popView = PopSelectInfoView(frame: self.bounds)
                popView.model = listModel
                let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)!
                viewController.present(alertVc, animated: true)
                
                popView.cancelBtn.rx.tap.subscribe(onNext: {
                    viewController.dismiss(animated: true)
                }).disposed(by: disposeBag)
                
                popView.tapClickIndexBlock = { [weak self] bindex in
                    guard let self = self else { return }
                    let prehens = self.model?.salin?.clastoon?[indexPath.row].aboveent?[bindex].pachyade ?? ""
                    let skillette = self.model?.salin?.clastoon?[indexPath.row].aboveent?[bindex].skillette ?? ""
                    cell.nameTx.text = prehens
                    viewController.dismiss(animated: true) {
                        self.model?.salin?.clastoon?[indexPath.row].prehens = prehens
                        self.model?.salin?.clastoon?[indexPath.row].skillette = String(skillette)
                    }
                }
            }
        }
    }
    
    private func cityClick(with cell: TapClickViewCell, listModel: clastoonModel, indexPath: IndexPath) {
        cell.tapClickBlock = { [weak self] in
            if let self = self, let viewController = self.getViewController() {
                self.endEditing(true)
                let popView = PopSelectCityInfoView(frame: self.bounds)
                popView.model = listModel
                let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)!
                viewController.present(alertVc, animated: true)
                
                popView.cancelBtn.rx.tap.subscribe(onNext: {
                    viewController.dismiss(animated: true)
                }).disposed(by: disposeBag)
                
                popView.confirmBlock = { [weak self] nameStr in
                    guard let self = self else { return }
                    cell.nameTx.text = nameStr
                    viewController.dismiss(animated: true) {
                        self.model?.salin?.clastoon?[indexPath.row].prehens = nameStr
                    }
                }
            }
        }
    }
    
}
