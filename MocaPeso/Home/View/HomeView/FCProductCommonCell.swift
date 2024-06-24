//
//  FCProductCommonCell.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/16.
//

import UIKit

class FCProductCommonCell: UITableViewCell {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "produnormallimage")
        return bgImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        return iconImageView
    }()
    
    lazy var nameLabel: FFShadowLabel = {
        let nameLabel = FFShadowLabel()
        nameLabel.font = UIFont(name: Fredoka_Bold, size: 16.px())
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var borrowLabel: UILabel = {
        let borrowLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 15.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        return borrowLabel
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        return typeImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(borrowLabel)
        bgImageView.addSubview(typeImageView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(26.px())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15.px())
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(13.px())
            make.size.equalTo(CGSizeMake(40.px(), 40.px()))
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10.px())
            make.top.equalToSuperview().offset(15.5.px())
            make.height.equalTo(24.px())
            make.width.equalTo(250.px())
        }
        borrowLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(4.px())
            make.height.equalTo(18.px())
        }
        typeImageView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.size.equalTo(CGSizeMake(115.px(), 56.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: ReddeningModel? {
        didSet {
            guard let model = model else { return }
            let troubles = model.troubles
            switch troubles {
            case "1":
                typeImageView.image = UIImage(named: "applybrntimm")
            case "2":
                typeImageView.image = UIImage(named: "repaybrntimm")
            case "3":
                typeImageView.image = UIImage(named: "jujuebrntimm")
            default:
                break
            }
            iconImageView.kf.setImage(with: URL(string: model.light ?? ""))
            nameLabel.text = " " + (model.plume ?? "")
            borrowLabel.text = model.oceans ?? ""
        }
    }
    
    var pModel: PlaceModel? {
        didSet {
            guard let model = pModel else { return }
            let troubles = model.troubles
            switch troubles {
            case "1":
                typeImageView.image = UIImage(named: "applybrntimm")
            case "2":
                typeImageView.image = UIImage(named: "repaybrntimm")
            case "3":
                typeImageView.image = UIImage(named: "jujuebrntimm")
            default:
                break
            }
            iconImageView.kf.setImage(with: URL(string: model.light ?? ""))
            nameLabel.text = " " + (model.plume ?? "")
            borrowLabel.text = model.oceans ?? ""
        }
    }
    
}
