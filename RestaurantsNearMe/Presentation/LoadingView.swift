//
//  LoadingView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-24.
//

import SwiftUI

struct LoadingView: View {
  var errorToPresent: String?
  @ObservedObject var viewModel: SplashScreenViewModel

  var body: some View {
    GeometryReader { proxy in
      ScrollView(.vertical) {
        VStack {
          Text("Restaurants Near Me")
            .font(.title)
          
          if let errorToPresent {
            Toast(message: errorToPresent)
          } else {
            ProgressView()
          }
        }.frame(
          width: proxy.size.width,
          height: proxy.size.height
        )
      }
      .scrollIndicatorsFlash(trigger: errorToPresent)
      .refreshable {
        viewModel.refresh()
      }
    }
  }
}

#Preview {
  Group {
    let viewModel = SplashScreenViewModel.preview()
    LoadingView(
      errorToPresent: "Testing Toast, 2 lines",
      viewModel: viewModel
    )
  }
}
