//
//  BaseHeadFile.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import Foundation
import DeviceKit
import SnapKit
import BRPickerView

// 宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
// 状态栏高度
let STATUSBAR_HIGH = Bool.isFullScreenDevice(Device.current) ? 44 : 20
// 导航栏高度
let NAV_HIGH = 44 + STATUSBAR_HIGH;

let Key_Service = "Key_Service"

let Key_Account = "Key_Account"

//push
let FCNotificationCenter = NotificationCenter.default
let FCAPPLE_PUSH = "FCAPPLE_PUSH"
let FCAPPLE_LOCATION = "FCAPPLE_LOCATION"
let FCAPPLE_ROOT_VC = "FCAPPLE_ROOT_VC"
let FCAPPLE_GOOGLE = "FCAPPLE_GOOGLE"
let FCAPPLE_PARAMS = "FCAPPLE_PARAMS"

//fonts
let Fredoka_Bold = "Fredoka-Bold"
let Fredoka_Regular = "Fredoka-Regular"
let Fredoka_SemiBold = "Fredoka-SemiBold"
let Fredoka_Medium = "Fredoka-Medium"

//login
let PHONE_LOGIN = "PHONE_LOGIN"
let PHONE_SESSIONID = "PHONE_SESSIONID"

var IS_LOGIN: Bool {
    if let cssID = UserDefaults.standard.object(forKey: PHONE_SESSIONID) as? String {
        return !cssID.isEmpty
    } else {
        return false
    }
}

// 判断设备是否是全面屏
extension Bool {
    static func isFullScreenDevice(_ device: Device) -> Bool {
        let fullScreenModels: [Device] = Device.allDevicesWithSensorHousing
        return fullScreenModels.contains(device)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UILabel {
    static func createLabel(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.backgroundColor = UIColor.clear
        return label
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    var viewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
}

extension Double {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension Int {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func minus() -> CGFloat{
        return 0 - self
    }
}

extension Data {
    static func compressImageQuality(image: UIImage, maxLength: Int) -> Data? {
        var compression: CGFloat = 0.75
        var data = image.jpegData(compressionQuality: compression)
        if let imageData = data, imageData.count < maxLength {
            return data
        }
        var max: CGFloat = 0.9
        var min: CGFloat = 0.0
        for _ in 0..<5 {
            compression = (max + min) / 2
            if let imageData = image.jpegData(compressionQuality: compression) {
                if imageData.count < Int(Double(maxLength) * 0.8) {
                    min = compression
                } else if imageData.count > maxLength {
                    max = compression
                } else {
                    break
                }
                data = imageData
            }
        }
        return data
    }
}

extension String {
    func convertBase64(_ dict: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            let base64EncodedString = jsonData.base64EncodedString()
            return base64EncodedString
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}

extension UIViewController {
    static func getTopBarHeights(for viewController: UIViewController?) -> (statusBarHeight: CGFloat, navigationBarHeight: CGFloat, totalHeight: CGFloat) {
        let statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let navigationBarHeight: CGFloat = viewController?.navigationController?.navigationBar.frame.height ?? 0
        let totalHeight = statusBarHeight + navigationBarHeight
        return (statusBarHeight, navigationBarHeight, totalHeight)
    }
    
    static func getCurrentUIVC() -> UIViewController? {
        guard let superVC = getCurrentVC() else {
            return nil
        }
        if let tabBarController = superVC as? UITabBarController {
            if let tabSelectVC = tabBarController.selectedViewController as? UINavigationController {
                return tabSelectVC.viewControllers.last
            } else {
                return tabBarController.selectedViewController
            }
        } else if let navigationController = superVC as? UINavigationController {
            return navigationController.viewControllers.last
        }
        return superVC
    }
    
    static func getCurrentVC() -> UIViewController? {
        var result: UIViewController?
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                    break
                }
            }
        }
        if let frontView = window?.subviews.first {
            if let nextResponder = frontView.next {
                if let viewController = nextResponder as? UIViewController {
                    result = viewController
                } else {
                    result = window?.rootViewController
                }
            }
        }
        return result
    }
}

extension UITextField {
    func setupLeftView(width: CGFloat, height: CGFloat) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    func setupRightView(imageName: String, width: CGFloat, height: CGFloat) {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        rightView.addSubview(imageView)
        self.rightView = rightView
        self.rightViewMode = .always
    }
}

class ProvinceModelConverter {
    static func getProvinceModelArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? PlaceModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.particularly
            proviceModel.name = proviceDic.employment
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.palace ?? proviceDic.palace ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.particularly
                cityModel.name = cityDic.employment
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.palace ?? cityDic.palace ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.particularly
                    areaModel.name = areaDic.employment
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}

class GetPayday {
    static func getPaydayModelArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? ChildrenModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.excuse
            proviceModel.name = proviceDic.employment
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.children ?? proviceDic.children ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.excuse
                cityModel.name = cityDic.employment
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.children ?? cityDic.children ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.excuse
                    areaModel.name = areaDic.employment
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}
