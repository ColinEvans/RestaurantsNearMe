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
  // TODO: - These should be combined into one
  var fetchingError: AnyPublisher<String, Never> { get }
  var isLoading: AnyPublisher<Bool, Never> { get }

  /// Uses offset, to paginate the correct subset of results
  func updateRestaurants(for request: YelpRequest) async
}
