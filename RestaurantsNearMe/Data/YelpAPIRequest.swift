//
//  YelpAPIRequest.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-01.
//

import Foundation
import Networking
import Combine
import CoreLocation

class YelpAPIRequest<B: URLRequestBuilding>: YelpAPIRequesting {
  private let requestBuilder: B
  private let cloudKitServiceProvider: any CloudKitServiceProviding
  private var activeLocation: CLLocation?
  private var cancellables = Set<AnyCancellable>()
  
  init(
    requestBuilder: B,
    locationProvider: some LocationProviding,
    cloudKitServiceProvider: some CloudKitServiceProviding
  ) {
    self.requestBuilder = requestBuilder
    self.cloudKitServiceProvider = cloudKitServiceProvider
    locationProvider
      .currentLocation
      .sink { self.activeLocation = $0 }
      .store(in: &cancellables)
  }
  
  func updateAPIKey() {
    guard let privateKey = cloudKitServiceProvider.apiKey.value else {
      return
    }
    let fullAPIKey = "Bearer " + privateKey
    requestBuilder.withHeaderOptions(headerType: .auth, value: fullAPIKey)
  }
  
  func getUpdatedRestaurants() async {
    guard let location = activeLocation else {
      return
    }
    requestBuilder.addQueryItems(
      for:
        (name: "latitude", value: String(location.coordinate.latitude)),
        (name: "longitude", value: String(location.coordinate.longitude))
    )
    let apiRequest = requestBuilder.retrieveRequest()
    do {
     let data = try await URLSession.shared.data(for: apiRequest)
     print(data) // still need to parse data
    } catch {
      print(error)
    }
  }
}

extension YelpAPIRequest<URLRequestBuilder> {
  static func preview() -> YelpRequest {
    YelpAPIRequest(
      requestBuilder: URLRequestBuilder(URL(string: "")!),
      locationProvider: LocationProvidingMock(),
      cloudKitServiceProvider: CloudKitServiceProvidingMock()
    )
  }
}
