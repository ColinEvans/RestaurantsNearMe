//
//  APIKey.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-09.
//

import Foundation

@propertyWrapper
struct APIKeyProvider {
  var wrappedValue: APIKey

  /// Initializes an empty `APIKey` of type `wrappedValue`
  init(_ wrappedValue: APIKey.Source) {
    self.wrappedValue = APIKey(source: wrappedValue)
  }
}
