//
//  FCRequset.swift
//  FutureCash
//
//  Created by apple on 2024/3/26.
//

import UIKit
import Alamofire
import HandyJSON

class FCRequset: NSObject {
    
    static let shared = FCRequset()
    
    typealias CompleteBlock = (_ baseModel: BaseModel) -> Void
    
    typealias NSErrorBlock = (_ error: Any) -> Void
    
    let headers: HTTPHeaders = [
        "Accept": "application/json;",
        "Connection": "keep-alive",
        "Content-Type": "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data"]
    
    func requestAPI(params: [String: Any]?,
                    pageUrl: String,
                    method: HTTPMethod,
                    timeout: TimeInterval = 30,
                    complete: @escaping CompleteBlock,
                    errorBlock: @escaping NSErrorBlock){
        addHudView()
        var wholeApiUrl = GetBaseApi.getBaseApiUrl() + pageUrl + "?" + LoginFactory.getLoginParas()
        wholeApiUrl = wholeApiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print("🔥wholeApiUrl>>>>>>>🔥\(wholeApiUrl)")
        AF.request(wholeApiUrl, method: method, parameters: params, headers: headers).responseData { [weak self] response in
            switch response.result {
            case .success(let success):
                ViewHud.hideLoadView()
                print("success>>>>>>>\(success)")
                if response.data == nil {
                    print("no data")
                    return
                }
                let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                if let model = model {
                    if model.conceive == -2 {
                        complete(model)
                        self?.showLoginVc()
                    }else{
                        complete(model)
                    }
                }else {
                    errorBlock("failure")
                }
                break
            case .failure(let failure):
                ViewHud.hideLoadView()
                errorBlock(failure)
                break
            }
        }
    }
    
    func uploadImageAPI(params: [String: Any]?,
                        pageUrl: String,
                        method: HTTPMethod,
                        timeout: TimeInterval = 30,
                        data: Data,
                        complete: @escaping CompleteBlock,
                        errorBlock: @escaping NSErrorBlock){
        addHudView()
        var wholeApiUrl = GetBaseApi.getBaseApiUrl() + pageUrl + "?" + LoginFactory.getLoginParas()
        wholeApiUrl = wholeApiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print("🔥wholeApiUrl>>>>>>>🔥\(wholeApiUrl)")
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "group", fileName: "group.png", mimeType: "image/png")
                if let params = params {
                    for (key, value) in params {
                        let value :String! = value as? String
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                }
            },
            to: wholeApiUrl,headers: headers)
        .validate()
        .responseData(completionHandler: { response in
            switch response.result {
            case .success(let success):
                ViewHud.hideLoadView()
                if response.data == nil {
                    print("no data")
                    return
                }
                print("success>>image>>\(success)")
                let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                if let model = model {
                    complete(model)
                }else {
                    errorBlock("failure")
                }
                break
            case .failure(let failure):
                ViewHud.hideLoadView()
                errorBlock(failure)
                break
            }
        })
    }
    
    func uploadDataAPI(params: [String: Any]?,
                       pageUrl: String,
                       method: HTTPMethod,
                       timeout: TimeInterval = 30,
                       complete: @escaping CompleteBlock,
                       errorBlock: @escaping NSErrorBlock){
        addHudView()
        var wholeApiUrl = GetBaseApi.getBaseApiUrl() + pageUrl + "?" + LoginFactory.getLoginParas()
        wholeApiUrl = wholeApiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print("🔥wholeApiUrl>>>data>>>🔥\(wholeApiUrl)")
        AF.upload(
            multipartFormData: { multipartFormData in
                if let params = params {
                    for (key, value) in params {
                        let value :String! = value as? String
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                }
            },
            to: wholeApiUrl,headers: headers)
        .validate()
        .responseData(completionHandler: { response in
            switch response.result {
            case .success(let success):
                ViewHud.hideLoadView()
                if response.data == nil {
                    print("no data")
                    return
                }
                print("success>>data>>\(success)")
                let jsonStr = NSString(data:response.data! ,encoding: String.Encoding.utf8.rawValue)
                let model = JSONDeserializer<BaseModel>.deserializeFrom(json: jsonStr as String?)
                if let model = model {
                    complete(model)
                }else {
                    errorBlock("failure")
                }
                break
            case .failure(let failure):
                ViewHud.hideLoadView()
                errorBlock(failure)
                break
            }
        })
    }
    
    func showLoginVc() {
        let vc = UIViewController.getCurrentUIVC() as! FCBaseViewController
        vc.addLoginView()
        LoginFactory.removeLoginInfo()
    }
    
    func addHudView() {
        let loadView = ViewHud.createLoadView()
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                keyWindow.addSubview(loadView)
            }
        }
    }
    
}
