//
//  LocationProviding.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation
import CoreLocation
import Combine

// sourcery: AutoMockable
protocol LocationProviding {
  var locationErrorPropogator: AnyPublisher<LocationError, Never> { get }
  var currentLocation: AnyPublisher<CLLocation, Never> { get }
  var areLocationPermissionsValid: AnyPublisher<Bool, Never> { get }

  func askLocationPermissions()
}
