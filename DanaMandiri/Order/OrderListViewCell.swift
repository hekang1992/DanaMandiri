//
//  OrderListViewCell.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/13.
//

import UIKit
import SnapKit
import Kingfisher

class OrderListViewCell: UITableViewCell {
    
    var model: sipirangeularModel? {
        didSet {
            guard let model = model else { return }
            let itiner = model.westernenne?.itiner ?? ""
            footLabel.text = itiner
            if itiner.isEmpty {
                bgView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(5)
                    make.size.equalTo(CGSize(width: 335, height: 177))
                    make.centerX.equalToSuperview()
                    make.bottom.equalToSuperview().offset(-7)
                }
            }else {
                bgView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(5)
                    make.size.equalTo(CGSize(width: 335, height: 205))
                    make.centerX.equalToSuperview()
                    make.bottom.equalToSuperview().offset(-7)
                }
            }
            let threeite = model.westernenne?.threeite ?? ""
            typeLabel.text = model.westernenne?.selendom ?? ""
            switch threeite {
            case "stirpargueious":
                typeLabel.textColor = UIColor.init(hexString: "#EC1812")
                bgView.backgroundColor = UIColor.init(hexString: "#F7DDDC")
                break
            case "macijobia":
                typeLabel.textColor = UIColor.init(hexString: "#EAA028")
                bgView.backgroundColor = UIColor.init(hexString: "#FAF2E1")
                break
            case "ptyalfold":
                typeLabel.textColor = UIColor.init(hexString: "#009F1E")
                bgView.backgroundColor = UIColor.init(hexString: "#DEF0DF")
                break
            case "sacchar":
                typeLabel.textColor = UIColor.init(hexString: "#49A9E4")
                bgView.backgroundColor = UIColor.init(hexString: "#E6F2FA")
                break
            case "itself":
                typeLabel.textColor = UIColor.init(hexString: "#8D8D8D")
                bgView.backgroundColor = UIColor.init(hexString: "#EDF0F2")
                break
            default:
                typeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
                bgView.backgroundColor = UIColor.init(hexString: "#EDF0F2")
                break
            }
            logoImageView.kf.setImage(with: URL(string: model.vertindustryent ?? ""))
            nameLabel.text = model.alate ?? ""
            
            let able = model.westernenne?.able ?? ""
            let testth = model.westernenne?.testth ?? ""
            rateLabel.text = "\(able)\(" ")|\(" ")\(testth)"
            
            oneLabel.text = model.indiition ?? ""
            twoLabel.text = model.toous ?? ""
            let clysmative = model.westernenne?.clysmative ?? ""
            let lepo = model.westernenne?.lepo ?? ""
            threeLabel.text = "\(clysmative): \(lepo)"
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .center
        typeLabel.font = UIFont.system(14, weightValue: 600)
        return typeLabel
    }()
    
    lazy var footLabel: UILabel = {
        let footLabel = UILabel()
        footLabel.textAlignment = .left
        footLabel.textColor = UIColor.init(hexString: "#EC1812")
        footLabel.font = UIFont.system(10, weightValue: 200)
        footLabel.numberOfLines = 0
        return footLabel
    }()
    
    lazy var nImageView: UIImageView = {
        let nImageView = UIImageView()
        nImageView.contentMode = .scaleAspectFit
        nImageView.image = UIImage(named: "cuy_lci_image")
        return nImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 4
        logoImageView.clipsToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        nameLabel.font = UIFont.system(14, weightValue: 600)
        return nameLabel
    }()
    
    lazy var rateLabel: PaddedLabel = {
        let rateLabel = PaddedLabel()
        rateLabel.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        rateLabel.textColor = UIColor.init(hexString: "#009F1E")
        rateLabel.textAlignment = .center
        rateLabel.font = UIFont.system(13, weightValue: 500)
        rateLabel.backgroundColor = UIColor.init(hexString: "#009F1E").withAlphaComponent(0.15)
        rateLabel.layer.cornerRadius = 6
        rateLabel.clipsToBounds = true
        return rateLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        oneLabel.font = UIFont.system(14, weightValue: 400)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#0E0F0F")
        twoLabel.font = UIFont.system(22, weightValue: 700)
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.textColor = UIColor.init(hexString: "#8D8D8D")
        threeLabel.font = UIFont.system(13, weightValue: 300)
        return threeLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(whiteView)
        bgView.addSubview(typeLabel)
        bgView.addSubview(nImageView)
        bgView.addSubview(footLabel)
        whiteView.addSubview(logoImageView)
        whiteView.addSubview(nameLabel)
        whiteView.addSubview(rateLabel)
        whiteView.addSubview(oneLabel)
        whiteView.addSubview(twoLabel)
        whiteView.addSubview(threeLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 335, height: 205))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-7)
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.left.right.equalToSuperview()
            make.height.equalTo(139)
        }
        typeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(whiteView.snp.top)
        }
        nImageView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(12)
        }
        footLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nImageView.snp.centerY)
            make.left.equalTo(nImageView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(16)
        }
        rateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(28)
        }
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(22)
            make.height.equalTo(23)
        }
        threeLabel.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
