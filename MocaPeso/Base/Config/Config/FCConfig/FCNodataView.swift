//
//  FCNodataView.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/16.
//

import UIKit

class FCNodataView: UIView {

    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "nodataimage")
        return icon
    }()
    
    lazy var label: UILabel = {
        let label = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: UIColor(css: "#384067"), textAlignment: .center)
        label.text = "Here are no orders."
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        addSubview(label)
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSizeMake(120.px(), 75.px()))
        }
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(30.px())
            make.height.equalTo(22.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
