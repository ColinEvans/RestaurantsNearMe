//
//  RestaurantListProvider.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation
import Networking
import Combine

struct RestaurantListProvider: RestaurantListProving {
  let restaurants = PassthroughSubject<[Restaurant], Never>()
  private let requestProvider: CurrentValueSubject<YelpRequest?, Never>
  private let client: AsyncHTTPClient
  
  init(requestProvider: CurrentValueSubject<YelpRequest?, Never>, client: AsyncHTTPClient) {
    self.requestProvider = requestProvider
    self.client = client
  }
  
  func updateRestaurants() async {
    guard let request = requestProvider.value else { return }
    do {
      let updatedList = try await client.response(for: request)
      restaurants.send(updatedList)
    } catch {
      // TODO: - Handle Errors at later time
      print(error.localizedDescription)
    }
  }
}
