//
//  HTTPClientError_Extensions.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-22.
//

import Foundation
import Networking

extension HTTPClientError: CustomStringConvertible {
  public var description: String {
    switch self {
    case .invalidResponse:
      return "Invalid Server Response, please try again later"
    }
  }
}
