//
//  ChangeTypeView.swift
//  FutureCash
//
//  Created by apple on 2024/4/29.
//

import UIKit

class ChangeTypeView: UIView {
    
    var modelArray: [PModel]?
    
    var block: (() -> Void)?
    
    var block1: ((PModel) -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "bgikuu")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.setImage(UIImage(named: "quxiao"), for: .normal)
        canBtn.addTarget(self, action: #selector(canClick), for: .touchUpInside)
        return canBtn
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20.px()
        layout.minimumLineSpacing = 20.px()
        let totalSpacing = layout.minimumInteritemSpacing
        let numberOfItemsPerRow = 2
        let itemWidth = (SCREEN_WIDTH - totalSpacing - 50.px()) / CGFloat(numberOfItemsPerRow)
        layout.itemSize = CGSizeMake(itemWidth, 122.px())
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ChangeViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(canBtn)
        bgImageView.addSubview(collectionView)
        bgImageView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(550.px())
        }
        canBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(31.px(), 33.px()))
            make.top.equalTo(bgImageView).offset(20.px())
            make.left.equalTo(bgImageView).offset(20.px())
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(canBtn.snp.bottom).offset(15.px())
            make.left.right.bottom.equalTo(bgImageView).inset(UIEdgeInsets(top: 0, left: 25.px(), bottom: 0, right: 25.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ChangeTypeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ChangeViewCell else {
            fatalError("Unable to dequeue CardTypeCell")
        }
        cell.model = modelArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = modelArray?[indexPath.row]
        if let model = model {
            self.block1?(model)
        }
    }
    
    @objc func canClick() {
        self.block?()
    }
    
}
