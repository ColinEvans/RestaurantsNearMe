//
//  ContentView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-08-24.
//

import SwiftUI
import Combine

struct ContentView<D: DeviceOrientationProviding>: View {
  @ObservedObject var splashScreenViewModel: SplashScreenViewModel
  let orientationProvider: D

  @State private var orientation: UIDeviceOrientation = .unknown

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
    .onReceive(orientationProvider.currentDeviceOrientation) {
      orientation = $0
    }
    .deviceOrientation(orientation)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      splashScreenViewModel: SplashScreenViewModel.preview(),
      orientationProvider: DeviceOrientationProvider()
    )
  }
}
