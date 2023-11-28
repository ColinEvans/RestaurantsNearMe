//
//  SplashScreenView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-24.
//

import SwiftUI

struct SplashScreenView: View {
  @ObservedObject var viewModel: SplashScreenViewModel
  var errorToPresent: String?

  var body: some View {
    VStack {
      Text("Restaurants Near Me")
        .font(.title)
      
      if let errorToPresent {
        Toast(message: errorToPresent)
      } else {
        ProgressView()
      }
    }.task {
      try? await viewModel.fetch()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background()
  }
}

#Preview {
  Group {
    let viewModel = SplashScreenViewModel.preview()
    SplashScreenView(viewModel: viewModel)
    SplashScreenView(viewModel: viewModel, errorToPresent: "Error")
      .environment(\.colorScheme, .dark)
  }
}
