//
//  RestaurantListView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-31.
//

import SwiftUI

struct RestaurantListView: View {
  @ObservedObject var viewModel: RestaurantListViewModel
  
  var body: some View {
    NavigationStack {
      List(viewModel.restaurants) { rest in
        NavigationLink {
          Text("More detail for \(rest.name)")
        } label: {
          RestaurantListRow(restaurant: rest)
            .frame(height: 80)
        }
      }
    }
    .onAppear {
      viewModel.askLocationPermissionsIfNeeded()
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
