//
//  RestaurantsNearMeAssembly.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation
import Networking
import CoreLocation

typealias YelpRequest = YelpAPIRequest<URLRequestBuilder>

class RestaurantsNearMeAssembly {
  private let locationManager = CLLocationManager()
  private var cloudKitService: CloudKitService!
  private var locationProvider: LocationProvider!

  @APIKeyProvider private var apiKeyProvider: APIKey
  var splashScreenViewModel: SplashScreenViewModel<YelpRequest>!
  var contentViewModel: RestaurantListViewModel<YelpRequest>!
  var urlRequestBuilder: URLRequestBuilder!
  var yelpAPIRequest: YelpRequest!
  
  init() {
    _apiKeyProvider = .init(.cloudKit)
  }
  
  func assemble() {
    locationProvider = LocationProvider(locationManager: locationManager)
    urlRequestBuilder = URLRequestBuilder(URL(string: "https://api.yelp.com/v3/businesses/search")!)
    cloudKitService = CloudKitService(apiKey: apiKeyProvider)
    yelpAPIRequest = YelpRequest(
      requestBuilder: urlRequestBuilder,
      locationProvider: locationProvider,
      cloudKitServiceProvider: cloudKitService
    )
    splashScreenViewModel = SplashScreenViewModel(
      cloudKitService: cloudKitService,
      apiRequesting: yelpAPIRequest
    )
    contentViewModel = RestaurantListViewModel(
      locationProvider: locationProvider,
      yelpRequest: yelpAPIRequest
    )
  }
}
