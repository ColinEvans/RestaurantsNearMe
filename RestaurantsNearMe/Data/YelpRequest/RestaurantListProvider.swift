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
  private let _restaurants = PassthroughSubject<[Restaurant], Never>()
  private let _errorMessage = PassthroughSubject<String, Never>()

  var restaurants: AnyPublisher<[Restaurant], Never> {
    _restaurants.eraseToAnyPublisher()
  }
  var fetchingError: AnyPublisher<String, Never> {
    _errorMessage.eraseToAnyPublisher()
  }

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
      print(updatedList)
      _restaurants.send(updatedList)
    } catch let error as CustomStringConvertible {
      _errorMessage.send(error.description)
    } catch {
      // TODO: - For debugging, all messages thrown in implementation should be CustomStringConvertible
      fatalError("All errors thrown should conform to CustomStringConvertible")
    }
  }
}
