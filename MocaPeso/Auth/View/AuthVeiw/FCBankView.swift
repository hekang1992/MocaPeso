//
//  FCBankView.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/20.
//

import UIKit

class FCBankView: UIView {
    
    var block: ((inout [String: Any]) -> Void)?
    
    var block1: ((FCWalletImageCell, ExceptModel) -> Void)?//normal
    
    var block2: ((FCWalletImageCell, ExceptModel) -> Void)?//city
    
    var block3: ((FCWenBenCell, ExceptModel) -> Void)?//payday
    
    var modelArray: [ExceptModel]?
    
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
        tableView.register(FCWalletImageCell.self, forCellReuseIdentifier: "FCWalletImageCell")
        tableView.register(FCWenBenCell.self, forCellReuseIdentifier: "FCWenBenCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCBankView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = modelArray?.count
        return count ?? 0
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
        switch (model.ourselves, model.conceive) {
        case ("f1", _),("f2", _),("f3", _), (_, _):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FCWenBenCell", for: indexPath) as? FCWenBenCell {
                configureGenderCell(cell, with: model)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func configureGenderCell(_ cell: FCWenBenCell, with model: ExceptModel) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = model
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: 25.px(), height: 25.px())
        switch (model.ourselves) {
        case ("f1"), ("f3"):
            imageView.image = UIImage(named: "Slicexialee")
            cell.nameField.isEnabled = false
        default:
            imageView.image = UIImage(named: "Slicettt11qa")
            cell.nameField.isEnabled = true
        }
        cell.nameField.rightView = imageView
        cell.nameField.rightViewMode = .always
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let modelArray = modelArray else { return }
        let model = modelArray[indexPath.row]
        let ourselves = model.ourselves ?? ""
        switch ourselves {
        case "f1", "f3":
            if let cell = tableView.cellForRow(at: indexPath) as? FCWenBenCell {
                popEnumViewWithModel(cell, model)
            }
            break
        default:
            break
        }
    }
    
    func popEnumViewWithModel(_ cell: FCWenBenCell, _ model: ExceptModel) {
        guard let ourselves = model.ourselves else { return }
        switch (ourselves) {
        case ("f1"):
            self.block3?(cell, model)
            break
        default:
            break
        }
    }
    
    @objc func conFirmClick() {
        if let modelArray = modelArray {
            var dict: [String: Any] = modelArray.reduce(into: [String: Any](), { partialResult, model in
                let type = model.ourselves
                if type == "f1" || type == "f3" {
                    partialResult[model.conceive!] = model.excuse
                }else {
                    partialResult[model.conceive!] = model.sapped
                }
            })
            self.block?(&dict)
        }
    }
    
}
