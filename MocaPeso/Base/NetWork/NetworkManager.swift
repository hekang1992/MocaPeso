//
//  NetworkManager.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import Alamofire
import Reachability

class NetworkManager {
    
    enum NetworkStatus {
        case wifi
        case cellular
        case none
    }
    
    var typeSty: String = "NONE"
    
    static let shared = NetworkManager()
    
    private let reachability = try!Reachability()
    
    typealias NetworkStatusHandler = (NetworkStatus) -> Void
    
    private var networkStatusHandler: NetworkStatusHandler?
    
    private init() {
        setupReachability()
    }
    
    private func setupReachability() {
        FCNotificationCenter.addObserver(self, selector: #selector(networkStatusChanged), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("无法开始网络状态监测")
        }
    }
    
    deinit {
        reachability.stopNotifier()
        FCNotificationCenter.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    @objc func networkStatusChanged() {
        if reachability.connection != .unavailable {
            if reachability.connection == .wifi {
                typeSty = "WIFI"
                notifyNetworkStatus(.wifi)
            } else {
                typeSty = "4G/5G"
                notifyNetworkStatus(.cellular)
            }
        } else {
            typeSty = "NONE"
            notifyNetworkStatus(.none)
        }
    }
    
    func observeNetworkStatus(_ handler: @escaping NetworkStatusHandler) {
        networkStatusHandler = handler
    }
    
    private func notifyNetworkStatus(_ status: NetworkStatus) {
        if status == .none {
            networkStatusHandler?(status)
        }else {
            reachability.stopNotifier()
            FCNotificationCenter.removeObserver(self, name: .reachabilityChanged, object: nil)
            networkStatusHandler?(status)
        }
    }
    
}
