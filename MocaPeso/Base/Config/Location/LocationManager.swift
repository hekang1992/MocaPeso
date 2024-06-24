//
//  LocationManager.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import CoreLocation

typealias LocationModelBlock = (_ locationModel: LocationModel) -> Void
class LocationManager: NSObject,CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    
    private var locationUpdateHandler: LocationModelBlock?
    
    var locatinModel = LocationModel()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 1000
    }
    
    func startUpdatingLocation(completion: @escaping LocationModelBlock) {
        locationUpdateHandler = completion
        if (CLLocationManager.authorizationStatus() == .denied) {
            locationUpdateHandler?(locatinModel)
        }else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("用户已授权位置信息")
            locationManager.startUpdatingLocation()
        case .denied:
            print("用户拒绝授权位置信息")
            locationUpdateHandler?(locatinModel)
            locationManager.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        getAddressFromCoordinates(latitude: latitude, longitude: longitude)
    }
    
    private func getAddressFromCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let model = LocationModel()
        model.longitude = longitude
        model.latitude = latitude
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self, let placemark = placemarks?.first else { return }
            model.country = placemark.country ?? ""
            model.countryCode = placemark.isoCountryCode ?? ""
            model.province = placemark.administrativeArea ?? ""
            model.city = placemark.locality ?? ""
            model.district = placemark.subLocality ?? ""
            model.street = placemark.thoroughfare ?? ""
            DispatchQueue.global().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.locatinModel = model
            }
            self.locationUpdateHandler?(model)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("🔥Error>>>>>>>🔥\(error)")
    }
    
}
