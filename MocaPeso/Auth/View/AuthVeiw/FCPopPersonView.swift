//
//  FCPopPersonView.swift
//  FutureCash
//
//  Created by apple on 2024/5/9.
//

import UIKit

class FCPopPersonView: UIView {
    
    var block: (() -> Void)?
    
    var modelArray: [ChildrenModel]?
    
    var block1: ((ChildrenModel) -> Void)?
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(FCPopPCell.self, forCellReuseIdentifier: "FCPopPCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(canBtn)
        bgImageView.addSubview(tableView)
        bgImageView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(550.px())
        }
        canBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(31.px(), 33.px()))
            make.top.equalTo(bgImageView).offset(20.px())
            make.left.equalTo(bgImageView).offset(20.px())
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(canBtn.snp.bottom).offset(10.px())
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCPopPersonView: UITableViewDelegate, UITableViewDataSource {
    
    @objc func canClick() {
        self.block?()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let modelArray = modelArray else { return UITableViewCell() }
        let model = modelArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FCPopPCell", for: indexPath) as? FCPopPCell {
            configureCell(cell, with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func configureCell(_ cell: FCPopPCell, with model: ChildrenModel) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.nameLabel.textColor = .white
        cell.model = model
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let modelArray = modelArray else { return }
        let model = modelArray[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) as? FCPopPCell {
            cell.nameLabel.textColor = .red
            self.block1?(model)
        }
    }
    
}
