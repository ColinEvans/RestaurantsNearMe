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
  
  init() {
    _apiKeyProvider = .init(.cloudKit)
  }
  
  func assemble() {
    locationProvider = LocationProvider(locationManager: locationManager)
    cloudKitService = CloudKitService(apiKey: apiKeyProvider)
    yelpAPIRequestProvider = YelpRequestProvider(
      locationProvider: locationProvider,
      cloudKitServiceProvider: cloudKitService,
      baseURLPath: "https://api.yelp.com/v3/businesses/search"
    )
    restaurantListProvider = RestaurantListProvider(
      requestProvider: yelpAPIRequestProvider.activeRequest,
      client: client
    )
    splashScreenViewModel = SplashScreenViewModel(
      cloudKitService: cloudKitService
    )
    restaurantListViewModel = RestaurantListViewModel(
      locationProvider: locationProvider,
      restaurantsListProvider: restaurantListProvider
    )
  }
}
