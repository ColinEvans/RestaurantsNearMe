//
//  APIKey.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-27.
//

import Foundation
import CloudKit

enum APIKeyNames: String {
  case type = "APIKey"
  case keyName
}

struct APIKey: Hashable {
  static let name = "B63DACB6-230C-4361-8C7A-2BFBB4505191"
  let keyName: String
}
