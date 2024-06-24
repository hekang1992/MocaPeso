//
//  FCGenderCell.swift
//  FutureCash
//
//  Created by apple on 2024/5/8.
//

import UIKit

class FCGenderCell: UITableViewCell {
    
    var selectedIndex: Int?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 18.px())!, textColor: .white, textAlignment: .left)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(28.px())
            make.width.equalTo(200.px())
            make.height.equalTo(20.px())
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15.px())
            make.leading.equalToSuperview()
            make.height.equalTo(100.px())
        }
        bgView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-20.px())
        }
    }
    
    var model: ExceptModel? {
        didSet {
            guard let model = model else {
                bgView.subviews.forEach { $0.removeFromSuperview() }
                return
            }
            bgView.subviews.forEach { $0.removeFromSuperview() }
            nameLabel.text = model.blonde
            if let modelArray = model.children {
                for (index, model) in modelArray.enumerated() {
                    let button = UIButton(type: .custom)
                    button.tag = index + 10
                    button.frame = CGRect(x: 38.5.px() + CGFloat(index) * 173.px(), y: 0, width: 107.px(), height: 100.px())
                    button.setBackgroundImage(UIImage(named: model.employment ?? ""), for: .normal)
                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                    bgView.addSubview(button)
                }
                
                let excuse = model.excuse ?? ""
                if !excuse.isEmpty {
                    if let excuseInt = Int(excuse) {
                        let result = excuseInt + 9
                        if let btn = viewWithTag(result) as? UIButton {
                            buttonTapped(selectedButton: btn)
                        }
                    }
                }
                updateButtonStates()
            }
        }
    }
    
    @objc func buttonTapped(selectedButton: UIButton) {
        selectedIndex = selectedButton.tag - 10
        updateButtonStates()
    }

    func updateButtonStates() {
        guard let modelArray = model?.children else { return }
        for (index, model) in modelArray.enumerated() {
            if let btn = bgView.viewWithTag(index + 10) as? UIButton {
                let employment = model.employment ?? ""
                if index != selectedIndex {
                    btn.isSelected = false
                    btn.setBackgroundImage(UIImage(named: employment == "male" ? "male" : "female"), for: .normal)
                } else {
                    btn.isSelected = true
                    btn.setBackgroundImage(UIImage(named: employment == "male" ? "male_sel" : "female_sel"), for: .normal)
                    print("❤️性别❤️>>>>>>>>\(model.excuse ?? "")")
                    self.model?.excuse = model.excuse
                }
            }
        }
    }
}
