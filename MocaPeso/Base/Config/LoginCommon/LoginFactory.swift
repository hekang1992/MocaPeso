//
//  LoginFactory.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import SystemServices
import DeviceKit

class LoginFactory: NSObject {
    
    static func getLoginParas() -> String{
        let shoot: String = "iOS"
        let pursed: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let fingerprints: String = Device.current.description
        let routine: String = DeviceInfo.getIdfv()
        let pitched: String = SystemServices().systemsVersion ?? ""
        let pistol: String = "liliy"
        var temple: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: PHONE_SESSIONID) as? String {
            temple = sessionId
        }
        let below: String = DeviceInfo.getIdfv()
        let change: String = "change"
        let lastUrl: String = "shoot=\(shoot)&pursed=\(pursed)&fingerprints=\(fingerprints)&routine=\(routine)&pitched=\(pitched)&pistol=\(pistol)&temple=\(temple)&below=\(below)&change=\(change)"
        return lastUrl
    }
    
    static func saveLoginInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(phone, forKey: PHONE_LOGIN)
        UserDefaults.standard.setValue(sessionID, forKey: PHONE_SESSIONID)
        UserDefaults.standard.synchronize()
    }
    
    static func removeLoginInfo() {
        UserDefaults.standard.setValue("", forKey: PHONE_LOGIN)
        UserDefaults.standard.setValue("", forKey: PHONE_SESSIONID)
        UserDefaults.standard.synchronize()
    }
}
