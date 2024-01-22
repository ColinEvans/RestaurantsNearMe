//
//  ContentView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-08-24.
//

import SwiftUI
import Combine
import CoreLocation
import Networking

struct ContentView: View {
  @ObservedObject var splashScreenViewModel: SplashScreenViewModel
  @ObservedObject var restaurantListViewModel: RestaurantListViewModel
  
  @State private var hasTransitionCompleted: Bool = false
  
  private var shouldTransition: Bool {
    !splashScreenViewModel.isLoading
      && hasTransitionCompleted
  }

  var body: some View {
    Group {
      if shouldTransition {
        RestaurantListView(viewModel: restaurantListViewModel)
      } else {
        LoadingView(viewModel: splashScreenViewModel)
          .deferredLoading(
            isLoading: splashScreenViewModel.isLoading,
            hasCompleted: $hasTransitionCompleted
          )
      }
    }
    .background(Color.background)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      splashScreenViewModel: .preview(),
      restaurantListViewModel: .preview()
    )
  }
}
