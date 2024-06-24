//
//  ChangeViewCell.swift
//  FutureCash
//
//  Created by apple on 2024/4/29.
//

import UIKit

class ChangeViewCell: UICollectionViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.image = UIImage(named: "caidafj")
        return iconImageView
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 18.px())!, textColor: .white, textAlignment: .left)
        titleLable.text = "UMID"
        return titleLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgView)
        bgView.addSubview(iconImageView)
        bgView.addSubview(titleLable)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.bottom.equalTo(bgView)
            make.size.equalTo(CGSizeMake(147.px(), 88.px()))
        }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(bgView)
            make.height.equalTo(20.px())
            make.left.equalTo(iconImageView.snp.left)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: PModel? {
        didSet {
            guard let model = model else { return }
            titleLable.text = model.excuse ?? ""
            let imageUrl = URL(string: model.yewtiful ?? "")
            iconImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "caidafj"))
        }
    }
    
}
