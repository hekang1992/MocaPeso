//
//  CardTypeCell.swift
//  FutureCash
//
//  Created by apple on 2024/4/26.
//

import UIKit
import Kingfisher

class CardTypeCell: UICollectionViewCell {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgView)
        bgView.addSubview(iconImageView)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(bgView)
            make.size.equalTo(CGSizeMake(147.px(), 84.5.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: PModel? {
        didSet {
            guard let model = model else { return }
            let imageUrl = URL(string: model.yewtiful ?? "")
            iconImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "caidafj"))
        }
    }
    
}
