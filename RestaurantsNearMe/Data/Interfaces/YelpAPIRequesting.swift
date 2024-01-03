//
//  YelpAPIRequesting.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-01.
//

import Foundation
import Networking

// sourcery: AutoMockable
protocol YelpAPIRequesting {
  func updateAPIKey()
  func getUpdatedRestaurants() async
}
