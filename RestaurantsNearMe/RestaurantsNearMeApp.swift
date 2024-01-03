//
//  RestaurantsNearMeApp.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-08-24.
//

import SwiftUI

@main
struct RestaurantsNearMeApp: App {
  let assembly = RestaurantsNearMeAssembly()

  init() {
    assembly.assemble()
  }

  var body: some Scene {
    WindowGroup {
      ContentView(
        splashScreenViewModel: assembly.splashScreenViewModel,
        restaurantListViewModel: assembly.contentViewModel
      )
    }
  }
}
