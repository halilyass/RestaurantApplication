//
//  LocationService.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import Foundation
import CoreLocation

enum Result<K> {
    case successful(K)
    case incorrent(Error)
}

final class LocationService : NSObject {
    
    //MARK: - Properties
    
    private let manager : CLLocationManager
    
    var newLocation : ((Result<CLLocation>) -> Void)?
    var changeLocation : ((Bool) -> Void)?
    
    var status : CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    var selectedLocation : CLLocationCoordinate2D?
    
    
    //MARK: - Lifecycle
    
    init(manager : CLLocationManager = .init()) {
        self.manager = manager
        self.manager.startUpdatingLocation()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()
        self.manager.delegate = self
        self.manager.distanceFilter = CLLocationDistance(exactly: 250)!
        self.manager.allowDeferredLocationUpdates(untilTraveled: CLLocationDistanceMax, timeout: CLTimeIntervalMax)
    }
    
    //MARK: - Helpers
    
    func request() {
        manager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        manager.requestLocation()
    }
    
}

//MARK: - CLLocationManagerDelegate

extension LocationService : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        newLocation?(.incorrent(error))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.sorted(by: { $0.timestamp > $1.timestamp }).first {
            newLocation?(.successful(location))
            selectedLocation = location.coordinate
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .denied , .notDetermined , .restricted : changeLocation?(false)
            break
            
        default : changeLocation?(true)
        }
        
    }
    
}
