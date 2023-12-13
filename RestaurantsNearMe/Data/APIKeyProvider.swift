//
//  APIKey.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-09.
//

import Foundation

@propertyWrapper
struct APIKeyProvider {
  private var key: APIKey?

  var wrappedValue: APIKey? {
    get {
      return key
    }
    set {
      // TODO update the envrionment with the new key
      key = newValue
    }
  }
}
