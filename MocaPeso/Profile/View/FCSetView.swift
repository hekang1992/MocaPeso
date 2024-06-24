//
//  FCSetView.swift
//  FutureCash
//
//  Created by apple on 2024/4/24.
//

import UIKit
import MBProgressHUD

class FCSetView: UIView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "BGvc")
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "ccc11")
        iconImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        iconImageView.addGestureRecognizer(tapGesture)
        return iconImageView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.image = UIImage(named: "ccc11")
        iconImageView1.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped1))
        iconImageView1.addGestureRecognizer(tapGesture)
        return iconImageView1
    }()
    
    lazy var iconImageView2: UIImageView = {
        let iconImageVie2 = UIImageView()
        iconImageVie2.image = UIImage(named: "hearta")
        iconImageVie2.isUserInteractionEnabled = true
        return iconImageVie2
    }()
    
    lazy var titleLable: FFShadowLabel = {
        let titleLable = FFShadowLabel(strockColor: UIColor.init(css: "#384067"))
        titleLable.font = UIFont(name: Fredoka_Bold, size: 16.px())
        titleLable.textAlignment = .center
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheSize = calculateCacheSize(forDirectory: cacheURL)
        titleLable.text = "Clear Cache     \(cacheSize)"
        return titleLable
    }()
    
    lazy var titleLable1: FFShadowLabel = {
        let titleLable1 = FFShadowLabel(strockColor: UIColor.init(css: "#384067"))
        titleLable1.font = UIFont(name: Fredoka_Bold, size: 16.px())
        titleLable1.textAlignment = .center
        titleLable1.text = "Like us, rate and encourage!"
        return titleLable1
    }()
    
    lazy var iconImageView3: UIImageView = {
        let iconImageView3 = UIImageView()
        iconImageView3.image = UIImage(named: "releabc")
        return iconImageView3
    }()
    
    lazy var titleLable2: UILabel = {
        let titleLable2 = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: .white, textAlignment: .center)
        titleLable2.text = "Tawid Loan"
        return titleLable2
    }()
    
    lazy var titleLable3: UILabel = {
        let titleLable3 = UILabel.createLabel(font: UIFont(name: Fredoka_Regular, size: 12.px())!, textColor: .white, textAlignment: .center)
        titleLable3.text = "V1.0.0 Official Release"
        return titleLable3
    }()
    
    lazy var iconImageView4: UIImageView = {//推出登陆
        let iconImageView4 = UIImageView()
        iconImageView4.image = UIImage(named: "ccc11")
        iconImageView4.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped2))
        iconImageView4.addGestureRecognizer(tapGesture)
        return iconImageView4
    }()
    
    lazy var titleLable4: FFShadowLabel = {
        let titleLable4 = FFShadowLabel(strockColor: UIColor.init(css: "#384067"))
        titleLable4.font = UIFont(name: Fredoka_Bold, size: 16.px())
        titleLable4.textAlignment = .center
        titleLable4.text = "Log Out"
        return titleLable4
    }()
    
    lazy var iconImageView5: UIImageView = {
        let iconImageView5 = UIImageView()
        iconImageView5.image = UIImage(named: "deleiamge")
        iconImageView5.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped3))
        iconImageView5.addGestureRecognizer(tapGesture)
        return iconImageView5
    }()
    
    lazy var iconImageView6: UIImageView = {
        let iconImageView6 = UIImageView()
        iconImageView6.image = UIImage(named: "jinggao")
        return iconImageView6
    }()
    
    lazy var titleLable5: FFShadowLabel = {
        let titleLable5 = FFShadowLabel(strockColor: UIColor.init(css: "#384067"))
        titleLable5.font = UIFont(name: Fredoka_Bold, size: 16.px())
        titleLable5.textAlignment = .center
        titleLable5.text = "Delete Account"
        return titleLable5
    }()
    
    lazy var titleLable6: UILabel = {
        let titleLable6 = UILabel.createLabel(font: UIFont(name: Fredoka_Regular, size: 12.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .center)
        titleLable6.numberOfLines = 0
        titleLable6.text = "Account deletion is irreversible! Please proceed with caution."
        return titleLable6
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(iconImageView)
        iconImageView.addSubview(titleLable)
        bgImageView.addSubview(iconImageView1)
        iconImageView1.addSubview(iconImageView2)
        iconImageView1.addSubview(titleLable1)
        bgImageView.addSubview(iconImageView3)
        iconImageView3.addSubview(titleLable2)
        iconImageView3.addSubview(titleLable3)
        bgImageView.addSubview(iconImageView4)
        iconImageView4.addSubview(titleLable4)
        bgImageView.addSubview(iconImageView5)
        iconImageView5.addSubview(titleLable5)
        iconImageView5.addSubview(titleLable6)
        bgImageView.addSubview(iconImageView6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            iconImageView.snp.makeConstraints { make in
                make.top.equalTo(self).offset(height.totalHeight + 45.px())
                make.centerX.equalTo(self)
                make.size.equalTo(CGSizeMake(315.px(), 56.px()))
            }
        }
        titleLable.snp.makeConstraints { make in
            make.center.equalTo(iconImageView)
            make.width.equalTo(200.px())
            make.height.equalTo(24.px())
        }
        iconImageView1.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(25.px())
            make.centerX.equalTo(self)
            make.size.equalTo(CGSizeMake(315.px(), 56.px()))
        }
        iconImageView2.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView1)
            make.size.equalTo(CGSizeMake(20.px(), 18.px()))
            make.right.equalTo(iconImageView1).offset(-40.px())
        }
        titleLable1.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView1)
            make.right.equalTo(iconImageView2.snp.left).offset(-5.px())
            make.height.equalTo(24.px())
            make.width.equalTo(225.px())
        }
        iconImageView3.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.top.equalTo(iconImageView1.snp.bottom).offset(25.px())
            make.size.equalTo(CGSizeMake(315.px(), 86.px()))
        }
        titleLable2.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView3)
            make.top.equalTo(iconImageView3).offset(26.px())
            make.size.equalTo(CGSizeMake(120.px(), 20.px()))
        }
        titleLable3.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView3)
            make.top.equalTo(titleLable2.snp.bottom).offset(10.px())
            make.size.equalTo(CGSizeMake(120.px(), 15.px()))
        }
        iconImageView5.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.size.equalTo(CGSizeMake(315.px(), 90.px()))
            make.bottom.equalTo(bgImageView).offset(-66.px())
        }
        iconImageView4.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.size.equalTo(CGSizeMake(315.px(), 56.px()))
            make.bottom.equalTo(iconImageView5.snp.top).offset(-25.px())
        }
        titleLable4.snp.makeConstraints { make in
            make.center.equalTo(iconImageView4)
            make.size.equalTo(CGSizeMake(100.px(), 22.px()))
        }
        titleLable5.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView5)
            make.width.equalTo(200.px())
            make.height.equalTo(22.px())
            make.top.equalTo(iconImageView5.snp.top).offset(17.px())
        }
        titleLable6.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView5)
            make.left.equalTo(iconImageView5).offset(20.px())
            make.top.equalTo(titleLable5.snp.bottom).offset(10.px())
        }
        iconImageView6.snp.makeConstraints { make in
            make.left.equalTo(iconImageView5.snp.left).offset(-7.px())
            make.top.equalTo(iconImageView5.snp.top).offset(-9.px())
            make.size.equalTo(CGSizeMake(27.px(), 27.px()))
        }
    }
}


extension FCSetView {
    
    func calculateCacheSize(forDirectory directory: URL) -> String {
        let fileManager = FileManager.default
        var totalSize: Int64 = 0
        guard let enumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: nil) else {
            return "0MB"
        }
        for case let fileURL as URL in enumerator {
            do {
                let attributes = try fileManager.attributesOfItem(atPath: fileURL.path)
                if let fileSize = attributes[.size] as? Int64 {
                    totalSize += fileSize
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        let totalSizeInMB = Double(totalSize) / (1024 * 1024)
        let formattedSize = String(format: "%.2f MB", totalSizeInMB)
        return formattedSize
    }
    
    func deleteCache(forDirectory directory: URL) {
        let fileManager = FileManager.default
        guard let enumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: nil) else {
            return
        }
        for case let fileURL as URL in enumerator {
            do {
                try fileManager.removeItem(at: fileURL)
                print("Deleted file: \(fileURL.lastPathComponent)")
            } catch {
                print("Error deleting file: \(error.localizedDescription)")
            }
        }
        print("Cache cleared.")
    }
    
    @objc func imageTapped() {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        deleteCache(forDirectory: cacheURL)
        let loadView = ViewHud.createLoadView()
        if let keyWindow = UIApplication.shared.windows.first {
            keyWindow.addSubview(loadView)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            MBProgressHUD.show(text: "Success")
            self.titleLable.text = "Clear Cache     0.00MB"
            loadView.removeFromSuperview()
        }
    }
    
    @objc func imageTapped1() {
        self.block1?()
    }
    
    @objc func imageTapped2() {
        self.block2?()
    }
    
    @objc func imageTapped3() {
        self.block3?()
    }
}

