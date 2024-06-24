//
//  FCPopCardInfoView.swift
//  FutureCash
//
//  Created by apple on 2024/5/7.
//

import UIKit
import BRPickerView

class FCPopCardInfoView: UIView {
    
    var model: CardInfoModel?
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    lazy var bgimageView: UIImageView = {
        let bgimageView = UIImageView()
        bgimageView.isUserInteractionEnabled = true
        bgimageView.image = UIImage(named: "Sliceyello")
        return bgimageView
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "quxiao"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var idImageView: UIImageView = {
        let idImageView = UIImageView()
        return idImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "huixingzhen")
        return iconImageView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.image = UIImage(named: "Sliceqwe")
        return iconImageView1
    }()
    
    lazy var nameView1: FCNameView = {
        let nameView1 = FCNameView()
        nameView1.nameLabel.text = "Name:"
        let placeholderFont = UIFont(name: Fredoka_Medium, size: 16.px())
        let foregroundColor = UIColor.init(css: "#FFC460")
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: placeholderFont!,
            .foregroundColor: foregroundColor!
        ]
        nameView1.nameField.attributedPlaceholder = NSAttributedString(string: "Enter your name", attributes: placeholderAttributes)
        return nameView1
    }()
    
    lazy var nameView2: FCNameView = {
        let nameView2 = FCNameView()
        nameView2.nameLabel.text = "Number:"
        let placeholderFont = UIFont(name: Fredoka_Medium, size: 16.px())
        let foregroundColor = UIColor.init(css: "#FFC460")
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: placeholderFont!,
            .foregroundColor: foregroundColor!
        ]
        nameView2.nameField.attributedPlaceholder = NSAttributedString(string: "Enter your Number", attributes: placeholderAttributes)
        return nameView2
    }()
    
    lazy var nameView3: FCNameView = {
        let nameView3 = FCNameView()
        nameView3.nameLabel.text = "Date of Birth:"
        let imageView = UIImageView()
        imageView.image = UIImage(named: "xiala")
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: 25.px(), height: 25.px())
        nameView3.nameField.rightView = imageView
        nameView3.nameField.rightViewMode = .always
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        nameView3.nameField.addGestureRecognizer(tapGesture)
        nameView3.nameField.isUserInteractionEnabled = true
        return nameView3
    }()
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "fpnfitbtn"), for: .normal)
        btn1.addTarget(self, action: #selector(saveClick), for: .touchUpInside)
        return btn1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        addSubview(bgimageView)
        addSubview(iconImageView1)
        addSubview(idImageView)
        addSubview(iconImageView)
        addSubview(btn1)
        bgimageView.addSubview(nameView1)
        bgimageView.addSubview(nameView2)
        bgimageView.addSubview(nameView3)
        btn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(27.5.px())
            make.size.equalTo(CGSizeMake(31.px(), 33.px()))
            make.top.equalTo(self).offset(145.px())
        }
        bgimageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(btn.snp.bottom).offset(6.px())
            make.size.equalTo(CGSizeMake(320.px(), 432.px()))
        }
        idImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(19.px())
            make.top.equalTo(bgimageView).offset(8.px())
            make.size.equalTo(CGSizeMake(162.px(), 97.px()))
        }
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(19.5.px(), 45.5.px()))
            make.top.equalTo(idImageView.snp.top).offset(-14.5.px())
            make.right.equalTo(idImageView.snp.right).offset(-41.px())
        }
        iconImageView1.snp.makeConstraints { make in
            make.top.equalTo(bgimageView.snp.top)
            make.right.equalTo(self).offset(-17.px())
            make.size.equalTo(CGSizeMake(218.px(), 135.5.px()))
        }
        nameView1.snp.makeConstraints { make in
            make.top.equalTo(idImageView.snp.bottom).offset(22.px())
            make.left.equalTo(bgimageView).offset(39.px())
            make.centerX.equalTo(bgimageView)
            make.height.equalTo(72.px())
        }
        nameView2.snp.makeConstraints { make in
            make.top.equalTo(nameView1.snp.bottom).offset(15.px())
            make.left.equalTo(bgimageView).offset(39.px())
            make.centerX.equalTo(bgimageView)
            make.height.equalTo(72.px())
        }
        nameView3.snp.makeConstraints { make in
            make.top.equalTo(nameView2.snp.bottom).offset(15.px())
            make.left.equalTo(bgimageView).offset(39.px())
            make.centerX.equalTo(bgimageView)
            make.height.equalTo(72.px())
        }
        btn1.snp.makeConstraints { make in
            make.centerX.equalTo(bgimageView)
            make.bottom.equalTo(bgimageView.snp.bottom).offset(45.px())
            make.size.equalTo(CGSizeMake(183.px(), 86.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCPopCardInfoView {
    
    @objc func btnClick() {
        self.block?()
    }
    
    @objc func saveClick() {
        self.block1?()
    }
    
    @objc func textFieldTapped() {
        let dateStr: String = self.nameView3.nameField.text ?? ""
        if !dateStr.isEmpty {
            let timeArray = dateStr.components(separatedBy: "-")
            let day = timeArray[0]
            let mon = timeArray[1]
            let year = timeArray[2]
            pickDate(day: day, mon: mon, year: year)
        }
    }
    
    func pickDate(day: String, mon: String, year: String) {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.selectDate = NSDate.br_setYear(Int(year)!, month: Int(mon)!, day: Int(day)!)
        datePickerView.minDate = NSDate.br_setYear(1900, month: 10, day: 1)
        datePickerView.maxDate = Date()
        datePickerView.resultBlock = { [weak self] selectDate, selectValue in
            print("selectValue>>>>>\(selectValue ?? "")")
            let timeArray = selectValue!.components(separatedBy: "-")
            let year = timeArray[0]
            let mon = timeArray[1]
            let day = timeArray[2]
            self?.nameView3.nameField.text = String(format: "%@-%@-%@", day,mon,year)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: Fredoka_Bold, size: 18.px())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.red
        datePickerView.pickerStyle = customStyle
        datePickerView.show()
    }
    
}
