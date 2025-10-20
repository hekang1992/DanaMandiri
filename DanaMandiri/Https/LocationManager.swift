//
//  LocationManager.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/17.
//

import Foundation
import CoreLocation

struct LocationInfo {
    let latitude: Double
    let longitude: Double
    let country: String?
    let countryCode: String?
    let administrativeArea: String?
    let locality: String?
    let subLocality: String?
    let name: String?
}

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private var completion: ((Result<LocationInfo, Error>) -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation(completion: @escaping (Result<LocationInfo, Error>) -> Void) {
        self.completion = completion
        
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == .denied || status == .restricted {
            completion(.failure(LocationError.permissionDenied))
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
            completion?(.failure(LocationError.permissionDenied))
            completion = nil
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
                self.completion?(.failure(error))
                self.completion = nil
                return
            }
            
            guard let placemark = placemarks?.first else {
                self.completion?(.failure(LocationError.noPlacemark))
                self.completion = nil
                return
            }
            
            let info = LocationInfo(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                country: placemark.country,
                countryCode: placemark.isoCountryCode,
                administrativeArea: placemark.administrativeArea,
                locality: placemark.locality,
                subLocality: placemark.subLocality,
                name: placemark.name
            )
            
            self.completion?(.success(info))
            self.completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
        completion = nil
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

