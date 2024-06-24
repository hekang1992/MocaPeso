//
//  DeviceInfo.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import AdSupport
import DeviceKit
import SAMKeychain
import CoreTelephony
import SystemServices
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

class DeviceInfo: NSObject {
    
    static func getIdfv() -> String {
        if let uuid = SAMKeychain.password(forService: Key_Service, account: Key_Account), !uuid.isEmpty {
            return uuid
        } else {
            if let deviceIDFV = UIDevice.current.identifierForVendor?.uuidString {
                let success = SAMKeychain.setPassword(deviceIDFV, forService: Key_Service, account: Key_Account)
                if success {
                    print("获取的UUID is \(deviceIDFV)")
                    return deviceIDFV
                } else {
                    return ""
                }
            } else {
                return ""
            }
        }
    }
    
    static func getIDFA() -> String {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier
        return idfa.uuidString
    }
    
    static func isUsingProxy() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
           let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.apple.com")! as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [Any],
           let settings = proxies.first as? [AnyHashable: Any],
           let proxyType = settings[kCFProxyTypeKey] as? String {
            if proxyType == kCFProxyTypeNone as String {
                return "0"
            } else {
                return "1"
            }
        }
        return "0"
    }
    
    static func isVPNConnected() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    static func getNetType() -> String {
        let frank: String = NetworkManager.shared.typeSty
        return frank
    }
    
    static func getTimeZone() -> String {
        let timeZone = NSTimeZone.system
        return timeZone.abbreviation() ?? "";
    }
    
    static func getProTime() -> String {
        let time: TimeInterval = ProcessInfo.processInfo.systemUptime
        let timeDate = Date(timeIntervalSinceNow: 0 - time)
        let timeSp = String(format: "%ld", Int(timeDate.timeIntervalSince1970 * 1000))
        return timeSp
    }
    
    static func getCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentTimeMillis = String(Int64(currentTime * 1000))
        return currentTimeMillis
    }
    
    static func telegram() -> String {
        let telegram = String.init(format: "%.0f",SCREEN_WIDTH)
        return telegram
    }
    
    static func train() -> String {
        let train = String.init(format: "%.0f",SCREEN_HEIGHT)
        return train
    }
    
    static func impossible() -> String {
        let freeDisk: CLongLong = SystemServices.shared().longFreeDiskSpace
        let patience = String(format: "%.2lld", freeDisk)
        return patience
    }
    
    static func nearly() -> String {
        let allDisk: CLongLong = SystemServices.shared().longDiskSpace
        let lists = String(format: "%.2lld", allDisk)
        return lists
    }
    
    static func mademoiselle() -> String {
        let allmem: Double = SystemServices.shared().totalMemory
        let disposed = String(format: "%.0f", allmem * 1024 * 1024)
        return disposed
    }
    
    static func alternative() -> String {
        let freemem: Double = SystemServices.shared().activeMemoryinRaw
        let minute = String(format: "%.0f", freemem * 1024 * 1024)
        return minute
    }
    
    static func isJailBreak() -> String {
        let jailbreakToolPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        for path in jailbreakToolPaths {
            if FileManager.default.fileExists(atPath: path) {
                return "1"
            }
        }
        return "0"
    }
    
    static func getCurrentWifiMac() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in interfaces {
            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? else {
                continue
            }
            if let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String {
                return bssid
            }
        }
        return ""
    }
    
    static  func getAppWifiSSIDInfo() -> String {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            
            currentSSID = myDict["SSID"] as? String ?? ""
            
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
    static  func getAppWifiBSSIDInfo() -> String {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            
            currentSSID = myDict["BSSID"] as? String ?? ""
            
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
    static func deviceInfo() -> [String: Any] {
        let irishman = SystemServices().systemsVersion ?? ""
        let acidly = getProTime()
        let replied = Bundle.main.bundleIdentifier ?? ""
        let foolishly = SystemServices().batteryLevel
        let advice = SystemServices().charging ? 1 : 0
        let subject = DeviceInfo.getIdfv()
        let hesitated = DeviceInfo.getIDFA()
        let savings = getCurrentWifiMac()
        let rotter = getCurrentTime()
        let daresay = isUsingProxy()
        let weeks = isVPNConnected() ? "1" : "0"
        let believe = isJailBreak()
        let is_simulator = Device.current.isSimulator ? "1" : "0"
        let clerk = SystemServices().language ?? ""
        let insurance = SystemServices().carrierName ?? ""
        let frank = getNetType()
        let misunderstand = getTimeZone()
        let truant = getCurrentTime()
        let hurriedly = Device.current.name ?? ""
        let early = UIDevice.current.name
        let reliable = Device.current.description
        let years = String(Device.current.diagonal)
        let working = Device.current.systemVersion ?? ""
        let instruments = SSNetworkInfo.currentIPAddress() ?? ""
        let employment = getAppWifiSSIDInfo()
        let charts = getAppWifiBSSIDInfo()
        let filed = getAppWifiSSIDInfo()
        let impossible = impossible()
        let nearly = nearly()
        let mademoiselle = mademoiselle()
        let alternative = alternative()
        
        var dict: [String: Any] = ["irishmen": "iOS",
                                   "irishman": irishman,
                                   "acidly": acidly,
                                   "replied": replied]
        
        dict["devoted"] = ["foolishly": foolishly,
                           "advice": advice]
        
        dict["persuade"] = ["subject": subject,
                            "hesitated": hesitated,
                            "savings": savings,
                            "rotter": rotter,
                            "daresay": daresay,
                            "weeks": weeks,
                            "believe": believe,
                            "is_simulator": is_simulator,
                            "clerk": clerk,
                            "insurance": insurance,
                            "frank": frank,
                            "misunderstand": misunderstand,
                            "truant": truant]
        
        dict["unfeeling"] = ["mustn": "",
                             "hurriedly": hurriedly,
                             "hesitation":"",
                             "train": train(),
                             "telegram": telegram(),
                             "early": early,
                             "reliable": reliable,
                             "years": years,
                             "working": working]
        
        let wifiInfo: [String: Any] = ["employment": employment,
                                       "charts": charts,
                                       "savings": savings,
                                       "filed": filed]
        
        
        dict["handed"] = ["instruments": instruments,
                          "assistant": "0",
                          "correspondence": wifiInfo]
        
        dict["annoyed"] = ["impossible": impossible,
                           "nearly": nearly,
                           "mademoiselle": mademoiselle,
                           "alternative": alternative]
        
        return dict
    }
}
