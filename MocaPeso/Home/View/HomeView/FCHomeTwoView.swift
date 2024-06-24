//
//  FCHomeTwoView.swift
//  FutureCash
//
//  Created by apple on 2024/5/14.
//

import UIKit
import TYCyclePagerView

class FCHomeTwoView: UIView {
    
    var block1: ((String) -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    var block4: ((ReddeningModel) -> Void)?
    
    var productArray: [ReddeningModel]?
    
    var fudaiBannerArray: [ReddeningModel]?
    
    var modelBannerArray: [ReddeningModel]? {
        didSet {
            guard let modelBannerArray = modelBannerArray else { return }
            if modelBannerArray.count > 1 {
                pagerView1.isInfiniteLoop = true
            }else {
                pagerView1.isInfiniteLoop = false
            }
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.contentMode = .scaleAspectFill
        iconImageView1.clipsToBounds = true
        iconImageView1.image = UIImage(named: "bg1")
        iconImageView1.isUserInteractionEnabled = true
        return iconImageView1
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.setBackgroundImage(UIImage(named: "Sliceleft"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setBackgroundImage(UIImage(named: "Slicerightifad"), for: .normal)
        rightBtn.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        return rightBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(FCProductCommonCell.self, forCellReuseIdentifier: "FCProductCommonCell")
        tableView.register(FCProductSpecialCell.self, forCellReuseIdentifier: "FCProductSpecialCell")
        return tableView
    }()
    
    lazy var pagerView1: TYCyclePagerView = {
        let view = TYCyclePagerView()
        view.delegate = self
        view.dataSource = self
        view.isInfiniteLoop = true
        view.autoScrollInterval = 2
        view.register(FCTwoBannerCell.self, forCellWithReuseIdentifier: "cellId")
        return view
    }()
    
    lazy var pagerView2: TYCyclePagerView = {
        let view = TYCyclePagerView()
        view.delegate = self
        view.dataSource = self
        view.isInfiniteLoop = false
        view.autoScrollInterval = 0
        view.register(FCTwoBannerCell.self, forCellWithReuseIdentifier: "cellId")
        return view
    }()
    
    lazy var proLabel: UILabel = {
        let proLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 24.px())!, textColor: .white, textAlignment: .center)
        proLabel.text = "·  More product  ·"
        return proLabel
    }()
    
    lazy var numView: UIImageView = {
        let numView = UIImageView()
        numView.image = UIImage(named: "Slicuoirn")
        return numView
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 15.px())!, textColor: .white, textAlignment: .center)
        return numLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView1)
        iconImageView1.addSubview(tableView)
        iconImageView1.addSubview(leftBtn)
        iconImageView1.addSubview(rightBtn)
        leftBtn.addSubview(numView)
        numView.addSubview(numLabel)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 50.px(), right: 0))
        }
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-10.px())
            make.size.equalTo(CGSizeMake(98.px(), 109.px()))
            make.bottom.equalToSuperview().offset(-50.px())
        }
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(10.px())
            make.size.equalTo(CGSizeMake(98.px(), 109.px()))
            make.bottom.equalToSuperview().offset(-50.px())
        }
        numView.snp.makeConstraints { make in
            make.top.equalTo(leftBtn)
            make.right.equalTo(leftBtn)
            make.size.equalTo(CGSizeMake(27.px(), 27.px()))
        }
        numLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCHomeTwoView: UITableViewDelegate, UITableViewDataSource, TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    
    @objc func leftClick() {
        self.feedBack()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: [], animations: {
            self.leftBtn.snp.updateConstraints { make in
                make.left.equalToSuperview()
            }
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0) {
                self.block2?()
            } completion: { _ in
                UIView.animate(withDuration: 0.25) {
                    self.leftBtn.snp.updateConstraints { make in
                        make.left.equalToSuperview().offset(-10.px())
                    }
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func rightClick() {
        self.feedBack()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: [], animations: {
            self.rightBtn.snp.updateConstraints { make in
                make.right.equalToSuperview()
            }
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0) {
                self.block3?()
            } completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    UIView.animate(withDuration: 0.25) {
                        self.rightBtn.snp.updateConstraints { make in
                            make.right.equalToSuperview().offset(10.px())
                        }
                        self.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    func feedBack() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return fudaiBannerArray != nil ? 215.px() : 140.px()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(pagerView1)
        headView.addSubview(proLabel)
        pagerView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(28.px())
            make.top.equalToSuperview()
            make.height.equalTo(80.px())
        }
        proLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15.px())
            make.left.equalToSuperview()
        }
        if fudaiBannerArray != nil {
            headView.addSubview(pagerView2)
            pagerView2.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(28.px())
                make.top.equalTo(pagerView1.snp.bottom).offset(15.px())
                make.height.equalTo(60.px())
            }
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = productArray?[indexPath.row]
        guard let model = model else { return UITableViewCell() }
        let hoping = model.hoping ?? ""
        if hoping.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FCProductCommonCell", for: indexPath) as? FCProductCommonCell {
                conCommonCell(cell, with: model)
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FCProductSpecialCell", for: indexPath) as? FCProductSpecialCell {
                configureCell(cell, with: model)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = productArray?[indexPath.row] else { return }
        self.block4?(model)
    }
    
    func conCommonCell(_ cell: FCProductCommonCell, with model: ReddeningModel) {
        cell.model = model
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
    
    func configureCell(_ cell: FCProductSpecialCell, with model: ReddeningModel) {
        cell.model = model
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        if pagerView == pagerView1 {
            if let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellId", for: index) as? FCTwoBannerCell {
                cell.model = modelBannerArray?[index]
                return cell
            }
        }else {
            if let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellId", for: index) as? FCTwoBannerCell {
                cell.fModel = fudaiBannerArray?[index]
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func numberOfItems(in pagerView: TYCyclePagerView) -> Int {
        if pagerView == pagerView1 {
            return modelBannerArray?.count ?? 0
        }else {
            return fudaiBannerArray?.count ?? 0
        }
    }
    
    func layout(for pagerView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        if pagerView == pagerView1 {
            layout.itemSize = CGSizeMake(319.px(), 80.px())
        }else {
            layout.itemSize = CGSizeMake(319.px(), 60.px())
        }
        layout.itemSpacing = 10.px()
        return layout
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        if pageView == pagerView1 {
            guard let model = modelBannerArray?[index] else { return }
            let clickUrl = model.weren ?? ""
            if !clickUrl.isEmpty {
                self.block1?(clickUrl)
            }
        }else {
            guard let model = fudaiBannerArray?[index] else { return }
            let clickUrl = model.weren ?? ""
            if !clickUrl.isEmpty {
                self.block1?(clickUrl)
            }
        }
        
    }
    
}
