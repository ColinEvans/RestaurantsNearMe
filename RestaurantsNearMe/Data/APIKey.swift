//
//  APIKey.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-27.
//

import Foundation
import CloudKit

struct APIKey {
  enum Source {
    case cloudKit
  }

  let source: Source
  var value: String?

  var keyId: UUID {
    switch source {
    case .cloudKit:
      return UUID(uuidString: "B63DACB6-230C-4361-8C7A-2BFBB4505191")!
    }
  }
}
