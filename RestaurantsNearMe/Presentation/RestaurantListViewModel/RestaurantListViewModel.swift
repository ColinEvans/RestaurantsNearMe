//
//  RestaurantListViewModel.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation
import UIKit

class RestaurantListViewModel<Y: YelpAPIRequesting>: ObservableObject {
  @Published var locationError: String?
  @Published var showLocationRedirect = false
  @Published var areLocationPermissionsValid = false
  
  private let locationProvider: any LocationProviding
  private let yelpRequest: Y
  
  init(
    locationProvider: some LocationProviding,
    yelpRequest: Y
  ) {
    self.locationProvider = locationProvider
    self.yelpRequest = yelpRequest
    locationProvider.locationErrorPropogator
      .receive(on: DispatchQueue.main)
      .map { String(describing: $0) }
      .assign(to: &$locationError)
    locationProvider.areLocationPermissionsValid
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .assign(to: &$areLocationPermissionsValid)
    $locationError
      .receive(on: DispatchQueue.main)
      .map { $0 != nil }
      .assign(to: &$showLocationRedirect)
  }
  
  func askLocationPermissions() {
    locationProvider.askLocationPermissions()
  }
  
  func goToSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    
    UIApplication.shared.open(settingsURL)
  }
  
  func retrieveRestaurants() async {
    await yelpRequest.getUpdatedRestaurants()
  }
}

extension RestaurantListViewModel {
  static func preview() -> RestaurantListViewModel<YelpRequest> {
    RestaurantListViewModel<YelpAPIRequest>(
      locationProvider: LocationProvidingMock(),
      yelpRequest:  .preview()
    )
  }
}
