//
//  CardTypeView.swift
//  FutureCash
//
//  Created by apple on 2024/4/26.
//

import UIKit
import MBProgressHUD

class CardTypeView: UIView {
    
    var block: (() -> Void)?
    
    var block1: ((PModel,CardTypeView,IndexPath) -> Void)?
    
    var modelArray: [PModel]?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.contentMode = .scaleAspectFill
        iconImageView1.clipsToBounds = true
        iconImageView1.image = UIImage(named: "bg1")
        iconImageView1.isUserInteractionEnabled = true
        return iconImageView1
    }()
    
    lazy var iconImageView2: UIImageView = {
        let iconImageView2 = UIImageView()
        iconImageView2.image = UIImage(named: "bg3")
        iconImageView2.isUserInteractionEnabled = true
        return iconImageView2
    }()
    
    lazy var iconImageView3: UIImageView = {
        let iconImageView3 = UIImageView()
        iconImageView3.image = UIImage(named: "bg2")
        iconImageView3.isUserInteractionEnabled = true
        return iconImageView3
    }()
    
    lazy var iconImageView4: UIImageView = {
        let iconImageView4 = UIImageView()
        iconImageView4.image = UIImage(named: "Slickigo")
        iconImageView4.isUserInteractionEnabled = true
        return iconImageView4
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = OverlapFlowLayout()
        layout.headerReferenceSize = CGSize(width: 100.px(), height: 16.px())
        layout.sectionInset = UIEdgeInsets(top: 16.px(), left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardTypeCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        let radians = CGFloat(tan(-1.56 * Double.pi / 180))
        collectionView.transform = CGAffineTransform(rotationAngle: radians)
        return collectionView
    }()
    
    lazy var changeBtn: UIButton = {
        let changeBtn = UIButton(type: .custom)
        changeBtn.setImage(UIImage(named: "icon_but"), for: .normal)
        changeBtn.addTarget(self, action: #selector(changeBtnClick), for: .touchUpInside)
        let radians = CGFloat(tan(-1.56 * Double.pi / 180))
        changeBtn.transform = CGAffineTransform(rotationAngle: radians)
        return changeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView1)
        iconImageView1.addSubview(scrollView)
        scrollView.addSubview(iconImageView2)
        scrollView.addSubview(iconImageView3)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(iconImageView4)
        scrollView.addSubview(changeBtn)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView3.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(iconImageView2.snp.bottom).offset(13.px())
            make.size.equalTo(CGSizeMake(375.px(), 465.px()))
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView3)
            make.centerX.equalTo(iconImageView3)
            make.left.equalTo(iconImageView3).offset(30.px())
            make.bottom.equalTo(iconImageView3).offset(-92.px())
        }
        iconImageView4.snp.makeConstraints { make in
            make.top.equalTo(iconImageView3.snp.bottom).offset(-93.px())
            make.size.equalTo(CGSizeMake(68.px(), 117.px()))
            make.left.equalTo(iconImageView1).offset(29.px())
        }
        changeBtn.snp.makeConstraints { make in
            make.right.equalTo(iconImageView1).offset(-14.px())
            make.size.equalTo(CGSizeMake(183.px(), 88.px()))
            make.bottom.equalTo(iconImageView3.snp.bottom).offset(-80.px())
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            iconImageView2.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSizeMake(375.px(), 159.px()))
                make.top.equalTo(height.navigationBarHeight)
            }
        }
        iconImageView4.setNeedsLayout()
        self.layoutIfNeeded()
        let maxY = CGRectGetMaxY(iconImageView4.frame)
        scrollView.contentSize = CGSizeMake(0, maxY + 20.px())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CardTypeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func didselectCollecTionView(_ col: UICollectionView, _ indexPath: IndexPath) {
        if !indexPath.isEmpty {
            collectionView(col, didSelectItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CardTypeCell else {
            fatalError("Unable to dequeue CardTypeCell")
        }
        cell.model = modelArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let layout = collectionView.collectionViewLayout as? OverlapFlowLayout {
            layout.selectedIndexPath = indexPath == layout.selectedIndexPath ? nil : indexPath
            UIView.animate(withDuration: 0.25, animations: {
                collectionView.performBatchUpdates({
                    collectionView.collectionViewLayout.invalidateLayout()
                }, completion: {_ in
                    if indexPath == layout.selectedIndexPath {
                        let model = self.modelArray?[indexPath.row]
                        if let model = model {
                            self.block1?(model,self,indexPath)
                        }
                    }
                })
            })
        }
    }
    
    @objc func changeBtnClick() {
        self.block?()
    }
    
}
