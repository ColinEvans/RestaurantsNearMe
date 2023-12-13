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
      if splashScreenViewModel.isFetching {
        SplashScreenView(
          viewModel: splashScreenViewModel,
          errorToPresent: splashScreenViewModel.fetchingError
        )
      } else {
        Text("Loading Complete")
      }
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
