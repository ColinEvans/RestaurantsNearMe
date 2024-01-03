//
//  ContentView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-08-24.
//

import SwiftUI
import Combine
import CoreLocation
import Networking

/*
 /*
  TODO: - Review ViewBuilders
  */


 /*
  Reducing the use of loading indicators can improve preceived performance or fluidity
   - We can implement this by having 4 tiles that flash animations while loading
  // i.e private var data: [MyDataType] {
    isLoading ? Datatype.placeHolders : api.loadedData
  
  // Deferred Loading. / Hide Loading states with animations
     If the loading takes a relativly small amount of time then we can defer showing the indicator
     at all (aka we can show an animation in place instead)
  // Make a deferred loading modifier that caps the amount of time needed before showing the indicator
  
  what should you do if you encounter an error?
  - very app specific, but i'm thinking maybe the viewController animation from error => retry
  
  Deferred Navigation?
  - small period of time between an action and reaction in an application where the user doesn't notice
  - add intentional delay to preload resource before pushing it (either onto the navigation stack or other transition)
  
  
  prefetching images with blur-hash? for placeholders empty placeholder -> blur hash -> simple transition animation -> image
  
  }
  */
 */



struct ContentView: View {
  @ObservedObject var splashScreenViewModel: SplashScreenViewModel<YelpRequest>
  @ObservedObject var restaurantListViewModel: RestaurantListViewModel<YelpRequest>
  
  @State private var hasTransitionCompleted: Bool = false
  
  private var shouldTransition: Bool {
    !splashScreenViewModel.isLoading
      && hasTransitionCompleted
  }

  var body: some View {
    Group {
      if shouldTransition {
        RestaurantListView(viewModel: restaurantListViewModel)
      } else {
        LoadingView(viewModel: splashScreenViewModel)
          .deferredLoading(
            isLoading: splashScreenViewModel.isLoading,
            hasCompleted: $hasTransitionCompleted
          )
      }
    }
    .background(Color.background)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      splashScreenViewModel: .preview(),
      restaurantListViewModel: .preview()
    )
  }
}
