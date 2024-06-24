//
//  FCAgainBuyView.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/22.
//

import UIKit

class FCAgainBuyView: UIView {
    
    var block4: ((PlaceModel) -> Void)?
    
    var productArray: [PlaceModel]?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView1)
        iconImageView1.addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: height.totalHeight + 15.px(), left: 0, bottom: 0, right: 0))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCAgainBuyView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = productArray?[indexPath.row]
        guard let model = model else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FCProductCommonCell", for: indexPath) as? FCProductCommonCell {
            conCommonCell(cell, with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = productArray?[indexPath.row] else { return }
        self.block4?(model)
    }
    
    func conCommonCell(_ cell: FCProductCommonCell, with model: PlaceModel) {
        cell.pModel = model
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
