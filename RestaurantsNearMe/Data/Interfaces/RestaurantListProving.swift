//
//  RestaurantListProving.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation
import Combine

// sourcery: AutoMockable
protocol RestaurantListProving {
  var restaurants: PassthroughSubject<[Restaurant], Never> { get }
  
  func updateRestaurants() async
}
