//
//  RightOneView.swift
//  FutureCash
//
//  Created by apple on 2024/5/14.
//

import UIKit
import SnapKit

class RightOneView: UIView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: ((String) -> Void)?
    
    var typeModel: FearedModel?
    
    let titleArray = ["Unpaid loan balance","Loan under review","Failed loan disbursement","Loan fully repaid"]
    
    let imageArray = ["balaceimage","reviewimageda","fialfdaimage","fullfadicon"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(RightViewCell.self, forCellReuseIdentifier: "RightViewCell")
        return tableView
    }()
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.addTarget(self, action: #selector(btn1Click), for: .touchUpInside)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.addTarget(self, action: #selector(btn2Click), for: .touchUpInside)
        return btn2
    }()
    
    lazy var typeView: RightTypeEnumView = {
        let typeView = RightTypeEnumView()
        return typeView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalToSuperview()
            make.bottom.equalTo(self).offset(-10.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RightOneView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 226.px()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let hongqiImageView = UIImageView()
        hongqiImageView.image = UIImage(named: "honeqibg")
        headView.addSubview(hongqiImageView)
        hongqiImageView.addSubview(typeView)
        typeView.typeModel = typeModel
        let heiqiImageView = UIImageView()
        heiqiImageView.isUserInteractionEnabled = true
        heiqiImageView.image = UIImage(named: "heiqiimage")
        headView.addSubview(heiqiImageView)
        heiqiImageView.addSubview(btn1)
        heiqiImageView.addSubview(btn2)
        hongqiImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSizeMake(140.px(), 224.px()))
        }
        heiqiImageView.snp.makeConstraints { make in
            make.top.equalTo(headView)
            make.left.equalTo(hongqiImageView.snp.right)
            make.size.equalTo(CGSizeMake(140.px(), 224.px()))
        }
        typeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        btn1.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(113.px())
        }
        btn2.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(113.px())
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RightViewCell", for: indexPath) as? RightViewCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.icon.image = UIImage(named: imageArray[indexPath.row])
            cell.nameLable.text = titleArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.px()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        switch index {
        case 0://待还款
            self.block3?("6")
            break
        case 1://贷款中
            self.block3?("7")
            break
        case 2://失败
            self.block3?("8")
            break
        case 3://已结清
            self.block3?("5")
            break
        default:
            break
        }
    }
    
    @objc func btn1Click() {
        self.block1?()
    }
    
    @objc func btn2Click() {
        self.block2?()
    }
    
}
