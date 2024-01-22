//
//  LoadingView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-24.
//

import SwiftUI

struct LoadingView: View {
  @ObservedObject var viewModel: SplashScreenViewModel

  var body: some View {
    GeometryReader { proxy in
      ScrollView(.vertical) {
        VStack {
          Text("Restaurants Near Me")
            .font(.title)
            .foregroundStyle(Color.white)
          
          if let error = viewModel.fetchingError {
            Toast(message: error)
          } else {
            ProgressView()
          }
        }.frame(
          width: proxy.size.width,
          height: proxy.size.height
        )
      }
      .task {
        await viewModel.fetch()
      }
      .refreshable {
        viewModel.refresh()
      }
    }
  }
}

#Preview {
  Group {
    LoadingView(
      viewModel: .preview()
    )
  }
}
