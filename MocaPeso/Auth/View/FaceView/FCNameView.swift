//
//  FCNameView.swift
//  FutureCash
//
//  Created by apple on 2024/5/7.
//

import UIKit

class FCNameView: UIView {
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: UIColor.init(css: "#B74C1B"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "rewsdf")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.font = UIFont(name: Fredoka_Medium, size: 18.px())
        nameField.textColor = UIColor.white
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 20.px(), height: 20.px())
        nameField.leftView = leftView
        nameField.leftViewMode = .always
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wenben")
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: 25.px(), height: 25.px())
        nameField.rightView = imageView
        nameField.rightViewMode = .always
        return nameField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(bgImageView)
        bgImageView.addSubview(nameField)
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSizeMake(100.px(), 20.px()))
        }
        bgImageView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(10.px())
            make.size.equalTo(CGSizeMake(244.px(), 40.px()))
        }
        nameField.snp.makeConstraints { make in
            make.left.bottom.top.equalTo(bgImageView)
            make.right.equalTo(bgImageView).offset(-17.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
