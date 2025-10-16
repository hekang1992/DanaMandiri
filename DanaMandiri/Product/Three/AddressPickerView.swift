//
//  AddressPickerView.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/16.
//

import UIKit
import SnapKit

class AddressPickerView: UIView {
    
    private let pickerView = UIPickerView()
    
    private var data: [sipirangeularModel] = []
    private var selectedProvince: sipirangeularModel?
    private var selectedCity: lampeticModel?
    private var selectedDistrict: lampeticModel?
    
    private var levels: Int = 1
    
    var onSelectionChanged: ((String?, String?, String?) -> Void)?
    
    // MARK: 初始化
    init(data: [sipirangeularModel]) {
        super.init(frame: .zero)
        self.data = data
        self.levels = AddressPickerView.getDepth(of: data)
        setupUI()
        setupPicker()
        setupDefaultSelection() // ✅ 设置默认选中
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension AddressPickerView {
    func setupUI() {
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupPicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}

// MARK: - 自动计算层级
private extension AddressPickerView {
    static func getDepth(of items: [sipirangeularModel]) -> Int {
        guard let first = items.first else { return 1 }
        if let cities = first.lampetic, !cities.isEmpty {
            if let firstCity = cities.first, let districts = firstCity.lampetic, !districts.isEmpty {
                return 3 // 省市区
            }
            return 2 // 省市
        }
        return 1 // 只有省
    }
}

// MARK: - 默认选中第一个
private extension AddressPickerView {
    func setupDefaultSelection() {
        guard !data.isEmpty else { return }
        
        selectedProvince = data.first
        
        if levels >= 2 {
            selectedCity = selectedProvince?.lampetic?.first
        }
        if levels == 3 {
            selectedDistrict = selectedCity?.lampetic?.first
        }
        
        // 刷新所有组件
        pickerView.reloadAllComponents()
        
        // 选中第一行
        for i in 0..<levels {
            pickerView.selectRow(0, inComponent: i, animated: false)
        }
        
        // 立即触发一次回调
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.onSelectionChanged?(
                self.selectedProvince?.pachyade,
                self.selectedCity?.pachyade,
                self.selectedDistrict?.pachyade
            )
        }
    }
}

// MARK: - PickerView
extension AddressPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return levels
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return data.count
        case 1:
            return selectedProvince?.lampetic?.count ?? 0
        case 2:
            return selectedCity?.lampetic?.count ?? 0
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return data[row].pachyade
        case 1:
            return selectedProvince?.lampetic?[row].pachyade
        case 2:
            return selectedCity?.lampetic?[row].pachyade
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedProvince = data[row]
            selectedCity = selectedProvince?.lampetic?.first
            selectedDistrict = selectedCity?.lampetic?.first
            pickerView.reloadComponent(1)
            if levels == 3 { pickerView.reloadComponent(2) }
            pickerView.selectRow(0, inComponent: 1, animated: true)
            if levels == 3 { pickerView.selectRow(0, inComponent: 2, animated: true) }
            
        case 1:
            selectedCity = selectedProvince?.lampetic?[row]
            selectedDistrict = selectedCity?.lampetic?.first
            if levels == 3 {
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
            }
            
        case 2:
            selectedDistrict = selectedCity?.lampetic?[row]
        default:
            break
        }
        
        onSelectionChanged?(
            selectedProvince?.pachyade,
            selectedCity?.pachyade,
            selectedDistrict?.pachyade
        )
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.system(14, weightValue: 400)
        label.textColor = .label
        switch component {
        case 0:
            label.text = data[row].pachyade
        case 1:
            label.text = selectedProvince?.lampetic?[row].pachyade
        case 2:
            label.text = selectedCity?.lampetic?[row].pachyade
        default:
            break
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
}
