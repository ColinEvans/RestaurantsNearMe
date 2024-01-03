//
//  LocationProvider.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation
import CoreLocation
import Combine

class LocationProvider: NSObject {
  private let locationManager: CLLocationManager
  private let _locationErrorPropogator = PassthroughSubject<LocationError, Never>()
  private let _currentLocation = PassthroughSubject<CLLocation, Never>()
  private let _areLocationPermissionsValid = PassthroughSubject<Bool, Never>()
  
  init(locationManager: CLLocationManager) {
    self.locationManager = locationManager
    super.init()
    locationManager.delegate = self
  }
}

// MARK: - Extensions<LocationProviding>
extension LocationProvider: LocationProviding {
  var locationErrorPropogator: AnyPublisher<LocationError, Never> {
    _locationErrorPropogator.eraseToAnyPublisher()
  }
  
  var currentLocation: AnyPublisher<CLLocation, Never> {
    _currentLocation.eraseToAnyPublisher()
  }
  
  var areLocationPermissionsValid: AnyPublisher<Bool, Never> {
    _areLocationPermissionsValid.eraseToAnyPublisher()
  }
  
  func askLocationPermissions() {
    locationManager.requestWhenInUseAuthorization()
  }
}

// MARK: - Extensions<CLLocationManagerDelegate>
extension LocationProvider: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .denied:
      _locationErrorPropogator.send(.refuseLocationService)
      _areLocationPermissionsValid.send(false)
    case .authorizedWhenInUse:
      if let location = manager.location {
        _currentLocation.send(location)
      }
      _areLocationPermissionsValid.send(true)
    case .authorizedAlways:
      _areLocationPermissionsValid.send(true)
    default:
      return
    }
  }
}
