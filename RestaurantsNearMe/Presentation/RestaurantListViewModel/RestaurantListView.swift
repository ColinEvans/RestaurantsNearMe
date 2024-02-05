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
    VStack {
      listView
      if viewModel.isLoading {
        ProgressView()
      }
    }.background(Color.white)
  }
  
  private var listView: some View {
    NavigationStack {
      let items = viewModel.restaurants.enumerated().map { $0 }
      List(items, id: \.element.id) { index, rest in
        NavigationLink {
          Text("More detail for \(rest.name)")
        } label: {
          RestaurantListRow(restaurant: rest)
            .frame(height: 80)
            .onAppear {
              viewModel.loadMoreDataIfNeeded(for: index)
            }
        }
      }
    }
    .onAppear {
      viewModel.askLocationPermissionsIfNeeded()
    }
    .alert(isPresented: $viewModel.showLocationRedirect) {
      locationRedirectAlert
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
