//
//  RestaurantsNearMeAssembly.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation
import Networking
import CoreLocation

class RestaurantsNearMeAssembly {
  private let locationManager = CLLocationManager()
  private var cloudKitService: CloudKitService!
  private var locationProvider: LocationProvider!

  @APIKeyProvider private var apiKeyProvider: APIKey
  var splashScreenViewModel: SplashScreenViewModel!
  var restaurantListViewModel: RestaurantListViewModel!
  var urlRequestBuilder: URLRequestBuilder!
  var yelpAPIRequestProvider: YelpRequestProvider!
  var client = AsyncHTTPClient()
  var restaurantListProvider: RestaurantListProvider!
  var offsetProvider: OffsetProvider!
  
  init() {
    _apiKeyProvider = .init(.cloudKit)
  }
  
  func assemble() {
    locationProvider = LocationProvider(locationManager: locationManager)
    cloudKitService = CloudKitService(apiKey: apiKeyProvider)
    offsetProvider = OffsetProvider()
    yelpAPIRequestProvider = YelpRequestProvider(
      locationProvider: locationProvider,
      cloudKitServiceProvider: cloudKitService,
      offsetProvider: offsetProvider,
      baseURLPath: URLs.baseSearch
    )
    restaurantListProvider = RestaurantListProvider(
      requestProvider: yelpAPIRequestProvider.activeRequest.eraseToAnyPublisher(),
      client: client
    )
    splashScreenViewModel = SplashScreenViewModel(
      cloudKitService: cloudKitService
    )
    restaurantListViewModel = RestaurantListViewModel(
      locationProvider: locationProvider,
      restaurantsListProvider: restaurantListProvider,
      offsetProvider: offsetProvider
    )
  }
}
