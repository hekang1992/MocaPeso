//
//  SecPopViewViewController.swift
//  MocaPeso
//
//  Created by apple on 2024/6/19.
//

import UIKit

class SecPopViewViewController: FCBaseViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "secdedai")
        bgImageView.contentMode = .center
        return bgImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        self.navView.titleLable.text = "Loan license"
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 267.px(), height: 317.px()))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
