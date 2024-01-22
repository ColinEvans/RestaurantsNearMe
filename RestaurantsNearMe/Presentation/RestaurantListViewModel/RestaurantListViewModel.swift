//
//  RestaurantListViewModel.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation
import Networking
import UIKit

class RestaurantListViewModel: ObservableObject {
  @Published var locationError: String?
  @Published var showLocationRedirect = false
  @Published var areLocationPermissionsValid = false
  @Published var restaurants = [Restaurant]()
  @Published var requestError: String?
  
  private let locationProvider: any LocationProviding
  private let restaurantsListProvider: any RestaurantListProving
  
  init(
    locationProvider: some LocationProviding,
    restaurantsListProvider: some RestaurantListProving
  ) {
    self.locationProvider = locationProvider
    self.restaurantsListProvider = restaurantsListProvider
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

    restaurantsListProvider.restaurants
      .receive(on: DispatchQueue.main)
      .assign(to: &$restaurants)
    restaurantsListProvider.fetchingError
      .compactMap({ $0 })
      .receive(on: DispatchQueue.main)
      .assign(to: &$requestError)
  }
  
  func askLocationPermissionsIfNeeded() {
    if !areLocationPermissionsValid {
      locationProvider.askLocationPermissions()
    }
  }

  func goToSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    
    UIApplication.shared.open(settingsURL)
  }
  
  func retrieveRestaurants() async {
    await restaurantsListProvider.updateRestaurants()
  }
}

extension RestaurantListViewModel {
  static func preview() -> RestaurantListViewModel {
    RestaurantListViewModel(
      locationProvider: LocationProvidingMock(),
      restaurantsListProvider: RestaurantListProvingMock()
    )
  }
}
