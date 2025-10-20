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
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation(completion: @escaping (LocationInfoModel) -> Void) {
        self.completion = completion
        
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == .denied || status == .restricted {
            let locationModel = LocationInfoModel()
            completion(locationModel)
        } else {
            manager.startUpdatingLocation()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        } else if manager.authorizationStatus == .denied {
            let locationModel = LocationInfoModel()
            completion?(locationModel)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        manager.stopUpdatingLocation()
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self else { return }
            
            if let error {
                print("error========\(error.localizedDescription)")
                let locationModel = LocationInfoModel()
                completion?(locationModel)
                return
            }
            
            guard let placemark = placemarks?.first else {
                let locationModel = LocationInfoModel()
                completion?(locationModel)
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let locationModel = LocationInfoModel()
        completion?(locationModel)
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

