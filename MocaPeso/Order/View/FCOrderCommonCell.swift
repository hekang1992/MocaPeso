//
//  FCOrderCommonCell.swift
//  FutureCash
//
//  Created by apple on 2024/5/15.
//

import UIKit
import Kingfisher

class FCOrderCommonCell: UITableViewCell {
    
    var block: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "cellbgcomm")
        return bgImageView
    }()
    
    lazy var label1: UILabel = {
        let label1 = UILabel.createLabel(font: UIFont(name: Fredoka_Regular, size: 15.px())!, textColor: UIColor.init(css: "#485284"), textAlignment: .left)
        return label1
    }()
    
    lazy var label2: UILabel = {
        let label1 = UILabel.createLabel(font: UIFont(name: Fredoka_Regular, size: 15.px())!, textColor: UIColor.init(css: "#485284"), textAlignment: .right)
        return label1
    }()
    
    lazy var label3: UILabel = {
        let label1 = UILabel.createLabel(font: UIFont(name: Fredoka_Regular, size: 15.px())!, textColor: UIColor.init(css: "#485284"), textAlignment: .left)
        return label1
    }()
    
    lazy var label4: UILabel = {
        let label1 = UILabel.createLabel(font: UIFont(name: Fredoka_Regular, size: 15.px())!, textColor: UIColor.init(css: "#485284"), textAlignment: .right)
        return label1
    }()
    
    lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        return productImageView
    }()
    
    lazy var nameLabel: FFShadowLabel = {
        let nameLabel = FFShadowLabel()
        nameLabel.font = UIFont(name: Fredoka_Bold, size: 16.px())
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(label1)
        bgImageView.addSubview(label2)
        bgImageView.addSubview(label3)
        bgImageView.addSubview(label4)
        bgImageView.addSubview(productImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(btn)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(26.px())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-22.px())
        }
        label1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.px())
            make.left.equalToSuperview().offset(15.px())
            make.width.equalTo(150.px())
        }
        label2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.px())
            make.right.equalToSuperview().offset(-15.px())
            make.width.equalTo(150.px())
        }
        label3.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(4.px())
            make.left.equalToSuperview().offset(15.px())
            make.width.equalTo(150.px())
        }
        label4.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(4.px())
            make.right.equalToSuperview().offset(-15.px())
            make.width.equalTo(150.px())
        }
        productImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13.px())
            make.bottom.equalToSuperview().offset(-15.px())
            make.size.equalTo(CGSizeMake(40.px(), 40.px()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(productImageView.snp.centerY)
            make.left.equalTo(productImageView.snp.right).offset(10.px())
            make.height.equalTo(24.px())
            make.width.equalTo(200.px())
        }
        btn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.size.equalTo(CGSizeMake(115.px(), 56.px()))
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: PlaceModel? {
        didSet {
            guard let model = model else { return }
            label1.text = model.taking
            label2.text = model.capital
            label3.text = model.disappeared
            label4.text = model.wants
            let cough = model.cough ?? ""
            productImageView.kf.setImage(with: URL(string: model.light ?? ""))
            nameLabel.text = " " + (model.plume ?? "")
            if cough.isEmpty {
                btn.isHidden = true
            }else {
                btn.isHidden = false
                btn.kf.setImage(with: URL(string: cough), for: .normal)
            }
            
        }
    }
    
    @objc func btnClick() {
        self.block?()
    }
    
}

