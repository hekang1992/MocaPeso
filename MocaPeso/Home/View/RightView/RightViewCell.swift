//
//  RightViewCell.swift
//  FutureCash
//
//  Created by apple on 2024/4/17.
//

import UIKit

class RightViewCell: UITableViewCell {
    
    lazy var bgImage: UIImageView = {
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "cellbg")
        return bgImage
    }()

    lazy var nameLable: FFShadowLabel = {
        let nameLabel = FFShadowLabel(strockColor: UIColor.init(css: "#384067"))
        nameLabel.font = UIFont(name: Fredoka_Bold, size: 16.px())
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        return nameLabel
    }()

    lazy var icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImage)
        bgImage.addSubview(nameLable)
        bgImage.addSubview(icon)
        bgImage.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo(54.px())
            make.centerX.equalTo(contentView)
            make.left.equalTo(contentView).offset(15.px())
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(bgImage)
            make.size.equalTo(CGSizeMake(46.px(), 54.px()))
            make.right.equalTo(bgImage).offset(-31.5.px())
        }
        nameLable.snp.makeConstraints { make in
            make.centerY.equalTo(bgImage)
            make.left.equalTo(bgImage).offset(5.px())
            make.height.equalTo(54.px())
            make.right.equalTo(icon.snp.left).offset(-5.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
