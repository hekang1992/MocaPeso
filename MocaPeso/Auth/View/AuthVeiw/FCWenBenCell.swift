//
//  FCWenBenCell.swift
//  FutureCash
//
//  Created by apple on 2024/5/8.
//

import UIKit

class FCWenBenCell: UITableViewCell {
    
    private struct Constants {
        static let nameLabelFont = UIFont(name: "Fredoka-Bold", size: 18.px())!
        static let nameLabelColor = UIColor(css: "#FFFFFF")
        static let nameLabelWidth: CGFloat = 250.px()
        static let nameLabelHeight: CGFloat = 20.px()
        static let bgImageViewWidth: CGFloat = 319.px()
        static let bgImageViewHeight: CGFloat = 50.px()
        static let nameFieldFont = UIFont(name: Fredoka_Bold, size: 18.px())!
        static let nameFieldPlaceholderColor = UIColor(css: "#6C8BB7")!
        static let nameFieldRightInset: CGFloat = 17.px()
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameLabelFont
        label.textColor = Constants.nameLabelColor
        label.textAlignment = .left
        return label
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Slicepessfe33"))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.font = Constants.nameFieldFont
        nameField.textColor = .white
        nameField.setupLeftView(width: 15.px(), height: 15.px())
        nameField.setupRightView(imageName: "Slicettt11qa", width: 25.px(), height: 25.px())
        nameField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return nameField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(nameField)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(28.px())
            make.width.equalTo(Constants.nameLabelWidth)
            make.height.equalTo(Constants.nameLabelHeight)
        }
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15.px())
            make.width.equalTo(Constants.bgImageViewWidth)
            make.height.equalTo(Constants.bgImageViewHeight)
        }
        nameField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Constants.nameFieldRightInset))
        }
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-20.px())
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField == nameField {
            if let model = model {
                model.sapped = nameField.text
            }
        }
    }
    
    var model: ExceptModel? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let model = model else { return }
        nameLabel.text = model.blonde ?? ""
        let sapped = model.sapped ?? ""
        let calls = model.calls ?? ""
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: Constants.nameFieldFont,
            .foregroundColor: Constants.nameFieldPlaceholderColor
        ]
        nameField.attributedPlaceholder = NSAttributedString(string: model.blamed ?? "", attributes: placeholderAttributes)
        if calls == "1" {
            nameField.keyboardType = .numberPad
        }else {
            nameField.keyboardType = .default
        }
        if !sapped.isEmpty {
            nameField.text = sapped
        }else {
            nameField.text = ""
        }
    }
    
}
