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

extension CloudKitServiceError {
  func toErrorString() -> String {
    switch self {
    case .containerNotAvailable:
      return "Failed to connect to server"
    case .fetchFailed, .incorrectDataFormat:
      return "Incorrect data format"
    }
  }
}
