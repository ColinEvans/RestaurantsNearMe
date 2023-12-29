//
//  CloudKitServiceActor.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-12.
//

import Foundation
import Combine

actor CloudKitServiceActor {
  var isFetching = false {
    didSet {
      isFetchingPublisher.send(isFetching)
    }
  }
  
  func updateIsFetching(to isFetching: Bool) {
    self.isFetching = isFetching
  }
  
  private let isFetchingPublisher: PassthroughSubject<Bool, Never>
  init(_ isFetchingPublisher: PassthroughSubject<Bool, Never> ) {
    self.isFetchingPublisher = isFetchingPublisher
  }
}
