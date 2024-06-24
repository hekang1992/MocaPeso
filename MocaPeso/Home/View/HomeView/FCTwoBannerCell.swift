//
//  FCTwoBannerCell.swift
//  FutureCash
//
//  Created by apple on 2024/5/16.
//

import UIKit

class FCTwoBannerCell: UICollectionViewCell {
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholddafda")
        return imageView
    }()
    
    var model: ReddeningModel? {
        didSet {
            guard let model = model else { return }
            if let url = URL(string: model.yewtiful ?? "") {
                bgImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholddafda"))
            }
        }
    }
    
    var fModel: ReddeningModel? {
        didSet {
            guard let model = fModel else { return }
            if let url = URL(string: model.yewtiful ?? "") {
                bgImageView.kf.setImage(with: url, placeholder: UIImage(named: "fudaiplacefadf"))
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
