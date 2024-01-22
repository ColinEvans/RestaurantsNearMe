//
//  YelpRequestError.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-22.
//

import Foundation

enum YelpRequestError: Error {
  case unableToParseRestaurants
}

extension YelpRequestError: CustomStringConvertible {
  var description: String {
    switch self {
    case .unableToParseRestaurants:
      return "Unable to retrieve results. Please ensure the location is available and try again."
    }
  }
}
