//
//  RestaurantListViewModel.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-30.
//

import Foundation
import Networking
import UIKit
import Combine

class RestaurantListViewModel: ObservableObject {
  @Published var locationError: String?
  @Published var requestError: String?
  @Published var showLocationRedirect = false
  @Published var areLocationPermissionsValid = false
  @Published var restaurants = [Restaurant]()
  @Published private (set) var isLoading = false
  
  // MARK: - Infinite Scroll
  private let itemsFromEndThreshold = 3
  private var totalItemsAvailable: Int?
  private var itemsLoadedCount = 0
  
  // MARK: - Location
  private let locationProvider: any LocationProviding
  private let restaurantsListProvider: any RestaurantListProviding
  private let offsetProvider: any OffsetProviding
  
  private var cancellables = Set<AnyCancellable>()
  
  init(
    locationProvider: some LocationProviding,
    restaurantsListProvider: some RestaurantListProviding,
    offsetProvider: some OffsetProviding
  ) {
    self.locationProvider = locationProvider
    self.restaurantsListProvider = restaurantsListProvider
    self.offsetProvider = offsetProvider
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
      .sink { [weak self] in
        guard let self = self else { return }
        self.restaurants += $0
        self.itemsLoadedCount = self.restaurants.count
      }.store(in: &cancellables)
    restaurantsListProvider.fetchingError
      .compactMap({ $0 })
      .receive(on: DispatchQueue.main)
      .assign(to: &$requestError)
    restaurantsListProvider.isLoading
      .receive(on: DispatchQueue.main)
      .assign(to: &$isLoading)
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
  
  func loadMoreDataIfNeeded(for index: Int) {
    guard !isLoading else { return }
    if itemsLoadedCount - index <= itemsFromEndThreshold {
      var itemsToLoad = itemsLoadedCount
      if let totalItemsAvailable,
        totalItemsAvailable - itemsToLoad < 20 {
        itemsToLoad = totalItemsAvailable - itemsToLoad
      }
      offsetProvider.currentPageOffset.send(itemsToLoad)
    }
  }
}

extension RestaurantListViewModel {
  static func preview() -> RestaurantListViewModel {
    let viewModel = RestaurantListViewModel(
      locationProvider: LocationProvidingMock(),
      restaurantsListProvider: RestaurantListProvidingMock(),
      offsetProvider: OffsetProvidingMock()
    )
    viewModel.restaurants = Array<Restaurant>(repeating: .preview(), count: 10)
    return viewModel
  }
}
