//
//  FCContactView.swift
//  FutureCash
//
//  Created by apple on 2024/5/11.
//

import UIKit

class FCContactView: UIView {
    
    var modelArray: [ExceptModel]?

    var block: (([[String: Any]]) -> Void)?
    
    var block1: ((FCContactCell, ExceptModel) -> Void)?
    
    var block2: ((FCContactCell, ExceptModel) -> Void)?
    
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
        iconImageView2.image = UIImage(named: "contactInfo")
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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(FCContactCell.self, forCellReuseIdentifier: "FCContactCell")
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
                make.size.equalTo(CGSizeMake(363.px(), 105.px()))
                make.top.equalTo(height.totalHeight + 4.px())
            }
        }
    }
}

extension FCContactView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard modelArray != nil else { return UIView() }
        let footView = UIView()
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "fpnfitbtn"), for: .normal)
        btn.addTarget(self, action: #selector(conFirmClick), for: .touchUpInside)
        footView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(footView)
            make.height.equalTo(86.px())
            make.width.equalTo(183.px())
        }
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let modelArray = modelArray else { return UITableViewCell() }
        let model = modelArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FCContactCell", for: indexPath) as? FCContactCell {
            configureCell(cell, with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func configureCell(_ cell: FCContactCell, with model: ExceptModel) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = model
        cell.block1 = { [weak self] in
            self?.block1?(cell, model)
        }
        cell.block2 = { [weak self] in
            self?.block2?(cell, model)
        }
    }
    
    @objc func conFirmClick() {
        let array = self.modelArray?.map({ model in
            var partialResult: [String: Any] = [:]
            partialResult["solid"] = model.solid ?? ""
            partialResult["square"] = model.square ?? ""
            partialResult["lowndes"] = model.lowndes ?? ""
            partialResult["employment"] = model.employment ?? ""
            return partialResult
        })
        if let array = array {
            self.block?(array)
        }
    }
}
