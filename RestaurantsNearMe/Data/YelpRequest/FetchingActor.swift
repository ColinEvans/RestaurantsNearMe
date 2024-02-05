//
//  FetchingActor.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-02-04.
//

import Foundation

/// Used by Transport clients to manage if a request is being made
actor FetchingActor {
  var isFetching = false
  
  func update(isMakingFetch: Bool) {
    isFetching = isMakingFetch
  }
}
