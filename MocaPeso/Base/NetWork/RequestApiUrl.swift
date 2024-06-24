//
//  RequestApiUrl.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import Foundation

class GetBaseApi {
    static func setBaseApiUrl() -> String {
        var baseApiUrl = UserDefaults.standard.object(forKey: APIBAERURL) as? String ?? ""
            baseApiUrl = baseApiUrl.isEmpty ? BASE_H5_URL : baseApiUrl
            UserDefaults.standard.set(baseApiUrl, forKey: APIBAERURL)
            UserDefaults.standard.synchronize()
        return baseApiUrl
    }
    
    static func getBaseApiUrl() -> String {
        let baseUrl = "\(GetBaseApi.setBaseApiUrl())/ftch"
        return baseUrl
    }
}

let BASE_H5_URL = "https://tawid-lending.com"
let SCHEME_URL = "ta://loee.opp"
let BASE_GIT_URL = "https://raw.githubusercontent.com/dtsdark/ewit/main/feet"
let APIBAERURL = "APIBAERURL"

// LOGIN
let rightThoroughly = "/rightThoroughly"
let walkedWhole = "/walkedWhole"
let childiveMorley = "/childiveMorley"
let theAfter = "/theAfter"

// HOME
let examined = "/examined"
let cheerfulMirror = "/cheerfulMirror"
let haveHeard = "/haveHeard"
let henry = "/henry"

// AUTH
let persuadedThere = "/persuadedThere"
let seemedIntroducing = "/seemedIntroducing"
let nothingYoumanner = "/nothingYoumanner"
let gettingOclock = "/gettingOclock"
let thoughtfully = "/thoughtfully"
let brotherIndecisively = "/brotherIndecisively"
let theTime = "/theTime"
let namesStimulus = "/namesStimulus"
let elderlySister = "/elderlySister"
let victimsInstrument = "/victimsInstrument"
let heAfter = "/heAfter"
let andChair = "/andChair"
let patientWanted = "/patientWanted"
let troubleObviously = "/troubleObviously"
let wnnjennn = "/wnnjennn"

// ORDER
let alfredsConscious = "/alfredsConscious"
let theyThem = "/theyThem"

// UPDATA
let morningReally = "/morningReally"
let ohBreakfast = "/ohBreakfast"
let theBrother = "/theBrother"
let thank = "/thank"
let addedPlease = "/addedPlease"
let gileFilee = "/gileFilee"
