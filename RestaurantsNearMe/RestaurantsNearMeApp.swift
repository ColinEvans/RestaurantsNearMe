//
//  RestaurantsNearMeApp.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-08-24.
//

import SwiftUI

@main
struct RestaurantsNearMeApp: App {
  let cloudKitService = CloudKitService()
  let splashScreenViewModel: SplashScreenViewModel

  init() {
    splashScreenViewModel = SplashScreenViewModel(cloudKitService: cloudKitService)
  }

  var body: some Scene {
    WindowGroup {
      ContentView(
        splashScreenViewModel: splashScreenViewModel
      )
    }
  }
}
