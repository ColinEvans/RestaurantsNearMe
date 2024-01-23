//
//  RestaurantListProving.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation
import Combine

// sourcery: AutoMockable
protocol RestaurantListProviding {
  var restaurants: AnyPublisher<[Restaurant], Never> { get }
  var fetchingError: AnyPublisher<String, Never> { get }

  func updateRestaurants() async
}
