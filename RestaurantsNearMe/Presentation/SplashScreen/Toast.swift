//
//  Toast.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import SwiftUI

struct Toast: View {
  let message: String

  var body: some View {
    GeometryReader { proxy in
      ZStack {
        RoundedRectangle(cornerRadius: 10.0)
          .strokeBorder()
        Text(message)
          .font(.largeTitle)
          .bold()
          .padding()
      }
      .frame(
        width: proxy.size.width * UIConstants.toastWidthRatio
      )
      .frame(
        maxWidth: .infinity,
        minHeight: proxy.size.height * 0.1,
        maxHeight: proxy.size.height * 0.25
      )
    }
  }
  
  private func isLandscape(_ size: CGSize) -> Bool {
    size.width > size.height
  }
  
  private struct UIConstants {
    static let toastWidthRatio: CGFloat = 0.8
    static let toastHeightRatioPortrait: CGFloat = 0.1
    static let toastHeightRatioLandscape: CGFloat = 0.3
  }
}

#Preview {
  Toast(message: "Testing toast, Should be two lines")
}
