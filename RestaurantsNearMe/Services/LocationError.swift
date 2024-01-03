//
//  LocationError.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation

enum LocationError: Error {
  case refuseLocationService
}

extension LocationError: CustomStringConvertible {
  var description: String {
    switch self {
    case .refuseLocationService:
      """
       Location services must be enabled to retrieve results.
       Please enable location services in the settings
      """
    }
  }
}
