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
    GeometryReader { proxy in
      VStack {
        Text("Restaurants Near Me")
          .font(.title)
        
        if let errorToPresent {
          Toast(
            message: errorToPresent,
            parentSize: proxy.size
          )
        } else {
          ProgressView()
        }
      }.frame(
        maxWidth: .infinity,
        maxHeight: .infinity
      )
      .task {
        try? await viewModel.fetch()
      }
    }
  }
}

#Preview {
  Group {
    let viewModel = SplashScreenViewModel.preview()
    SplashScreenView(
      viewModel: viewModel,
      errorToPresent: "Testing Toast"
    )
    SplashScreenView(
      viewModel: viewModel,
      errorToPresent: nil
    )
  }
}
