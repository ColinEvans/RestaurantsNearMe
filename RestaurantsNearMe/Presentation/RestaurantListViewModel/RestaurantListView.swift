//
//  RestaurantListView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-31.
//

import SwiftUI

struct RestaurantListView: View {
  @ObservedObject var viewModel: RestaurantListViewModel<YelpRequest>
  
  var body: some View {
    ScrollView(.vertical) {
      Text("Loading Complete")
        .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.5)))
        .foregroundStyle(Color.white)
    }
    .onAppear {
      if !viewModel.areLocationPermissionsValid {
        viewModel.askLocationPermissions()
      }
    }
    .alert(isPresented: $viewModel.showLocationRedirect) {
      locationRedirectAlert
    }
    .task(id: viewModel.areLocationPermissionsValid){
      if viewModel.areLocationPermissionsValid {
        await viewModel.retrieveRestaurants()
      }
    }
  }

  private var locationRedirectAlert: Alert {
    Alert(
      title: Text("Location Needed"),
      message: Text(viewModel.locationError ?? ""),
      dismissButton: .default(Text("Go to Settings")) {
        viewModel.goToSettings()
      }
    )
  }
}

#Preview {
  Group {
    RestaurantListView(
      viewModel: .preview()
    )
  }
}
