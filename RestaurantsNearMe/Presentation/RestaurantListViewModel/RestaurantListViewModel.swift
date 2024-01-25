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
  private let restaurantsListProvider: any RestaurantListProviding
  
  init(
    locationProvider: some LocationProviding,
    restaurantsListProvider: some RestaurantListProviding
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
  
  func getNextRestaurants() async {
    // update the query
  }
  
  func shouldLoadData(_ id: String) -> Bool {
    return restaurants.firstIndex(where: { $0.id == id }) == restaurants.count - 2
  }
}

extension RestaurantListViewModel {
  static func preview() -> RestaurantListViewModel {
    let viewModel = RestaurantListViewModel(
      locationProvider: LocationProvidingMock(),
      restaurantsListProvider: RestaurantListProvidingMock()
    )
    viewModel.restaurants = Array<Restaurant>(repeating: .preview(), count: 10)
    return viewModel
  }
}
