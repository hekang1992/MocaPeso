//
//  TotalModel.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import Foundation
import HandyJSON

class BaseModel: HandyJSON {
    required init() {}
    var conceive: Int?
    var wanting: String?
    var easily: [String: Any]?
}

class EasilyModel: HandyJSON {
    required init() {}
    var feared: FearedModel?
    var except: [ExceptModel]?
    var eleven: ElevenModel?
    var palace: [PlaceModel]?
    var given: GivenModel?
    var weren: String?
    var stranger: String?
    var untidily: UntidilyModel?
    var filthy: FilthyModel?
    var retired: FilthyModel?
    var palaced: FilthyModel?
}

class ProductModel: HandyJSON {
    required init() {}
}

class UntidilyModel: HandyJSON {
    required init() {}
    var reddening: ReddeningModel?
}

class FilthyModel: HandyJSON {
    required init() {}
    var reddening: [ReddeningModel]?
}

class GivenModel: HandyJSON {
    required init() {}
    var suffused: String?
}

class ElevenModel: HandyJSON {
    required init() {}
    var palace: [ExceptModel]?
}

class PlaceModel: HandyJSON {
    required init() {}
    var employment: String?//名字
    var particularly: String?
    var palace: [PlaceModel]?
    var solid: String?
    var saying: String?
    var elderly: [PlaceModel]?
    var excuse: String?
    
    var service: String?//orderid
    var smell: String?//productid
    var plume: String?//name
    var light: String?//icon
    var disappeared: String?//日期文案
    var wants: String?//日期值
    var taking: String?//额度文案
    var capital: String?//额度
    var obvious: String?//h5地址
    var hundred: String?//You are already 7 days overdue,please repay in time
    var cough: String?//按钮链接
    var contents: String?//按钮链接
    var anemic: String?
    var reddening: [ReddeningModel]?
    var oceans: String?
    var troubles: String?
}

class ExceptModel: HandyJSON {
    required init() {}
    var except: [ExceptModel]?
    var particularly: String?
    var blonde: String?//标题
    var blamed: String?//placeholder
    var conceive: String?//code保存时的key键
    var ourselves: String?//cell样式
    var calls: String?//是否是数字键盘1是
    var children: [ChildrenModel]?
    var sapped: String?//回写的值
    var excuse: String?//传值
    var solid: String?
    var saying: String?
    var elderly: [ChildrenModel]?
    var employment: String?
    var lowndes: String?
    var Jorjjty: String?
    var square: String?
    var jielle: String?
    var reljjihe: String?
    var rekkiiel: String?
    var jiirrls: String?
}

class ChildrenModel: HandyJSON {
    required init() {}
    var excuse: String?//代码
    var employment: String?//名字
    var soothing: String?//picurl
    var children: [ChildrenModel]?
}

class GoogleModel: HandyJSON {
    required init() {}
    var pistol: String?
    var profession: String?
}

class LoginModel: HandyJSON {
    required init() {}
    var temperance: String?//phone
    var temple: String?//sessionid
}

class CardTypeModel: HandyJSON {
    required init() {}
    var pwpnnemw: [PModel]?
}

class PModel: HandyJSON {
    required init() {}
    var excuse: String?//umid
    var yewtiful: String?//pic url
}

class ReddeningModel: HandyJSON {
    required init() {}
    var particularly: String?//产品ID
    var plume: String?
    var expenditure: String?
    var spacious: String?//额度
    var imagination: String?//文案
    var crime: String?//时间
    var enamoured: String?
    var stories: String?
    var reads: String?
    var weren: String?//链接
    var yewtiful: String?//image链接
    var hoping: String?//逾期文案
    var light: String?
    var oceans: String?
    var troubles: String?
    var jiorlistd: String?
}

class CardInfoModel: HandyJSON {
    required init() {}
    var employment: String?//name
    var thorough: String?//id
    var intended: String?//date
    var weren: String?//pic url
    var telephoned: String?//year
    var frauds: String?//mon
    var ingenious: String?//day
}

class IDCradModel: HandyJSON {
    required init() {}
    var weren: String?//人脸地址
    var waved: WavedModel?
}

class WavedModel: HandyJSON {
    required init() {}
    var weren: String?//ID地址
}

class FaceModel: HandyJSON {
    required init() {}
    var stands: String?
}

class FearedModel: HandyJSON {
    required init() {}
    var enjoyment: String?//下一步认证
    var hekdllw: String?//总步数
    var killewh: String?//目前在那一步
    var verifyRate: String?//25%
    var verifyTitle: String?
}
