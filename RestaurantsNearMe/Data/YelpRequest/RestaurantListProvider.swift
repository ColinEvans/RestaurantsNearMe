//
//  RestaurantListProvider.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation
import Networking
import Combine

class RestaurantListProvider: RestaurantListProviding {
  private let _restaurants = PassthroughSubject<[Restaurant], Never>()
  private let _errorMessage = PassthroughSubject<String, Never>()
  private let _isDataLoading = PassthroughSubject<Bool, Never>()

  var restaurants: AnyPublisher<[Restaurant], Never> {
    _restaurants.eraseToAnyPublisher()
  }
  var fetchingError: AnyPublisher<String, Never> {
    _errorMessage.eraseToAnyPublisher()
  }
  var isLoading: AnyPublisher<Bool, Never> {
    _isDataLoading.eraseToAnyPublisher()
  }

  private let client: AsyncHTTPClient
  private let fetch = FetchingActor()
  private var cancellables = Set<AnyCancellable>()
  
  init(requestProvider: AnyPublisher<YelpRequest?, Never>, client: AsyncHTTPClient) {
    self.client = client
    requestProvider
      .compactMap { $0 }
      .sink { request in
        Task { [weak self] in
          await self?.updateRestaurants(for: request)
        }
      }.store(in: &cancellables)
  }

  func updateRestaurants(for request: YelpRequest) async {
    await asyncWrapper { [weak self] in
      guard let self = self else { return }
      do {
        let updatedList = try await self.client.response(for: request)
        _restaurants.send(updatedList)
      } catch let error as CustomStringConvertible {
        _errorMessage.send(error.description)
      } catch {
        // TODO: - For debugging, all messages thrown in implementation should be CustomStringConvertible
        fatalError("All errors thrown should conform to CustomStringConvertible")
      }
    }
  }
  
  private func asyncWrapper(for asyncFunc: @escaping () async -> ()) async {
    guard await !fetch.isFetching else {
      _errorMessage.send("error")
      return
    }

    await fetch.update(isMakingFetch: true)
    _isDataLoading.send(true)
    await asyncFunc()
    await fetch.update(isMakingFetch: false)
    _isDataLoading.send(false)
  }
}
