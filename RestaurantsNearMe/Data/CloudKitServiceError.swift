//
//  CloudKitServiceError.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-27.
//

import Foundation

enum CloudKitServiceError: Error {
  case containerNotAvailable
  case fetchFailed
  case incorrectDataFormat
}

extension CloudKitServiceError: CustomStringConvertible {
  var description: String {
    switch self {
    case .containerNotAvailable:
      return "Failed to connect to server"
    case .fetchFailed:
      return "Unable to perform server connection"
    case .incorrectDataFormat:
      return "Incorrect data format"
    }
  }
}
