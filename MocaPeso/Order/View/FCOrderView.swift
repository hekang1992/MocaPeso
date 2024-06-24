//
//  FCOrderView.swift
//  FutureCash
//
//  Created by apple on 2024/5/15.
//

import UIKit

class FCOrderView: UIView {
    
    var block: ((PlaceModel,String) -> Void)?
    
    var modelArray: [PlaceModel]?
    
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
    
    lazy var iconImageView2: UIImageView = {
        let iconImageView2 = UIImageView()
        iconImageView2.image = UIImage(named: "personalImage")
        iconImageView2.isUserInteractionEnabled = true
        return iconImageView2
    }()
    
    lazy var downImageView: UIImageView = {
        let downImageView = UIImageView()
        downImageView.image = UIImage(named: "down")
        midImageView.isUserInteractionEnabled = true
        return downImageView
    }()
    
    lazy var midImageView: UIImageView = {
        let midImageView = UIImageView()
        midImageView.image = UIImage(named: "middle")
        midImageView.isUserInteractionEnabled = true
        return midImageView
    }()
    
    lazy var upImageView: UIImageView = {
        let upImageView = UIImageView()
        upImageView.image = UIImage(named: "upimage")
        upImageView.isUserInteractionEnabled = true
        return upImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(FCOrderSpecialCell.self, forCellReuseIdentifier: "FCOrderSpecialCell")
        tableView.register(FCOrderCommonCell.self, forCellReuseIdentifier: "FCOrderCommonCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView1)
        iconImageView1.addSubview(iconImageView2)
        iconImageView1.addSubview(downImageView)
        iconImageView1.addSubview(midImageView)
        iconImageView1.addSubview(upImageView)
        iconImageView1.addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        upImageView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView2.snp.bottom).offset(6.px())
            make.left.right.equalTo(iconImageView1)
            make.height.equalTo(95.px())
        }
        downImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(iconImageView1)
            make.height.equalTo(95.px())
        }
        midImageView.snp.makeConstraints { make in
            make.top.equalTo(upImageView.snp.bottom)
            make.bottom.equalTo(downImageView.snp.top)
            make.left.right.equalTo(iconImageView1)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(upImageView.snp.top).offset(30.px())
            make.bottom.equalTo(downImageView.snp.bottom).offset(-10.px())
            make.left.right.equalTo(iconImageView1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            iconImageView2.snp.makeConstraints { make in
                make.centerX.equalTo(bgView)
                make.left.equalToSuperview()
                make.height.equalTo(105.px())
//                make.size.equalTo(CGSizeMake(363.px(), 105.px()))
                make.top.equalTo(height.totalHeight + 4.px())
            }
        }
    }
}

extension FCOrderView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let modelArray = modelArray else { return UITableViewCell() }
        let model = modelArray[indexPath.row]
        let hundred: String = model.hundred ?? ""
        if hundred.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FCOrderCommonCell", for: indexPath) as? FCOrderCommonCell {
                conCommonCell(cell, with: model)
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FCOrderSpecialCell", for: indexPath) as? FCOrderSpecialCell {
                configureCell(cell, with: model)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func conCommonCell(_ cell: FCOrderCommonCell, with model: PlaceModel) {
        cell.model = model
        cell.block = { [weak self] in
            self?.block?(model, "btnClick")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
    
    func configureCell(_ cell: FCOrderSpecialCell, with model: PlaceModel) {
        cell.model = model
        cell.block = { [weak self] in
            self?.block?(model, "btnClick")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let modelArray = modelArray else { return }
        let model = modelArray[indexPath.row]
        self.block?(model, "cellClick")
    }
}
