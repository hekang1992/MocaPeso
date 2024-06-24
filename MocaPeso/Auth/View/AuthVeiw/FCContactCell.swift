//
//  FCContactCell.swift
//  FutureCash
//
//  Created by apple on 2024/5/11.
//

import UIKit

class FCContactCell: UITableViewCell {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 18.px())!, textColor: .white, textAlignment: .left)
        return nameLabel
    }()

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "Maskreq")
        return bgImageView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(css: "#6C8BB7")
        return lineView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Grouptrr")
        return iconImageView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.image = UIImage(named: "ruighf")
        return iconImageView1
    }()
    
    lazy var textField1: UITextField = {
        let textField1 = UITextField()
        textField1.font = UIFont(name: Fredoka_Bold, size: 18.px())
        textField1.textColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(guanxiClick(_:)))
        textField1.addGestureRecognizer(tapGesture)
        return textField1
    }()
    
    lazy var textField2: UITextField = {
        let textField1 = UITextField()
        textField1.font = UIFont(name: Fredoka_Bold, size: 18.px())
        textField1.textColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(haomaClick(_:)))
        textField1.addGestureRecognizer(tapGesture)
        return textField1
    }()
    
    lazy var textField3: UITextField = {
        let textField1 = UITextField()
        textField1.font = UIFont(name: Fredoka_Bold, size: 18.px())
        textField1.textColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(haomaClick(_:)))
        textField1.addGestureRecognizer(tapGesture)
        return textField1
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(lineView)
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(iconImageView1)
        bgImageView.addSubview(textField1)
        bgImageView.addSubview(textField2)
        bgImageView.addSubview(textField3)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(28.px())
            make.width.equalTo(250.px())
            make.height.equalTo(20.px())
        }
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.leading.equalTo(contentView).offset(28.px())
            make.top.equalTo(nameLabel.snp.bottom).offset(15.px())
            make.bottom.equalTo(contentView).offset(-20.px())
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView).offset(49.px())
            make.left.equalTo(bgImageView).offset(22.px())
            make.right.equalTo(bgImageView).offset(-61.px())
            make.height.equalTo(1.px())
        }
        iconImageView1.snp.makeConstraints { make in
            make.top.equalTo(bgImageView).offset(15.5.px())
            make.size.equalTo(CGSizeMake(19.px(), 19.px()))
            make.right.equalTo(bgImageView).offset(-22.px())
        }
        iconImageView.snp.makeConstraints { make in
            make.bottom.equalTo(bgImageView).offset(-25.5.px())
            make.size.equalTo(CGSizeMake(19.px(), 19.px()))
            make.right.equalTo(bgImageView).offset(-22.px())
        }
        textField1.snp.makeConstraints { make in
            make.top.equalTo(bgImageView)
            make.right.equalTo(iconImageView.snp.left).offset(-10.px())
            make.left.equalTo(lineView.snp.left)
            make.bottom.equalTo(lineView.snp.top)
        }
        textField2.snp.makeConstraints { make in
            make.height.equalTo(35.px())
            make.right.equalTo(iconImageView.snp.left).offset(-10.px())
            make.left.equalTo(lineView.snp.left)
            make.top.equalTo(lineView.snp.bottom)
        }
        textField3.snp.makeConstraints { make in
            make.height.equalTo(35.px())
            make.right.equalTo(iconImageView.snp.left).offset(-10.px())
            make.left.equalTo(lineView.snp.left)
            make.top.equalTo(textField2.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: ExceptModel? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let model = model else { return }
        nameLabel.text = model.saying ?? ""
        model.excuse = model.square
        textField1.text = model.Jorjjty
        textField2.text = model.employment
        textField3.text = model.lowndes
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(css: "#6C8BB7")!,
            .font: UIFont(name: Fredoka_Bold, size: 16.px())!
        ]
        textField1.attributedPlaceholder = NSAttributedString(string: model.reljjihe ?? "", attributes: attributes)
        textField2.attributedPlaceholder = NSAttributedString(string: model.jiirrls ?? "", attributes: attributes)
        textField3.attributedPlaceholder = NSAttributedString(string: model.rekkiiel ?? "", attributes: attributes)
    }
}

extension FCContactCell {
    
    @objc func guanxiClick(_ sender: UITapGestureRecognizer) {
        self.block1?()
    }
    
    @objc func haomaClick(_ sender: UITapGestureRecognizer) {
        self.block2?()
    }
    
}
