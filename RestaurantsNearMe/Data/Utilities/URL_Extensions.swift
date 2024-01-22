//
//  URL_Extensions.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation

extension URL {
  init(_ string: StaticString) {
    self.init(string: string.toString())!
  }
}
