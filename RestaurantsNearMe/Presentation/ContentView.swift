//
//  ContentView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-08-24.
//

import SwiftUI
import Combine

struct ContentView: View {
  @ObservedObject var splashScreenViewModel: SplashScreenViewModel

  var body: some View {
    Group {
      if splashScreenViewModel.showLoadingView {
        LoadingView(
          errorToPresent: splashScreenViewModel.fetchingError,
          viewModel: splashScreenViewModel
        )
      } else {
        Text("Loading Complete")
      }
    }.task {
      await splashScreenViewModel.fetch()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      splashScreenViewModel: SplashScreenViewModel.preview()
    )
  }
}
