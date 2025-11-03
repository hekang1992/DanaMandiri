//
//  LocationManager.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/17.
//

import Foundation
import CoreLocation

class LocationInfoModel {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var country: String?
    var countryCode: String?
    var administrativeArea: String?
    var locality: String?
    var subLocality: String?
    var name: String?
}

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private var completion: ((LocationInfoModel) -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation(completion: @escaping (LocationInfoModel) -> Void) {
        self.completion = completion
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == .denied || status == .restricted {

        } else {
            manager.startUpdatingLocation()
        }
    }
    
    func requestLocation() {
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        } else if manager.authorizationStatus == .denied {

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
        UserDefaults.standard.synchronize()
        
        manager.stopUpdatingLocation()
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self else { return }
            
            if error != nil {
                return
            }
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            let model = LocationInfoModel()
            
            model.latitude = location.coordinate.latitude
            model.longitude = location.coordinate.longitude
            model.country = placemark.country
            model.countryCode = placemark.isoCountryCode
            model.administrativeArea = placemark.administrativeArea
            model.locality = placemark.locality
            model.subLocality = placemark.subLocality
            model.name = placemark.name
            
            self.completion?(model)
            self.completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}

enum LocationError: Error, LocalizedError {
    case permissionDenied
    case noPlacemark
    
    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return "Location permission denied."
        case .noPlacemark:
            return "Unable to find placemark for this location."
        }
    }
}

