//
//  Toast.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import SwiftUI

struct Toast: View {
  let message: String
  @Environment(\.deviceOrientation) var deviceOrientation

  var body: some View {
    RoundedRectangle(cornerRadius: 10.0)
      .strokeBorder()
      .fill(Color.clear)
      .containerRelativeFrame(.horizontal) { layout, _ in
        layout * UIConstants.toastWidthRatio
      }
      .containerRelativeFrame(.vertical) { layout, _ in
        deviceOrientation == .portrait
          ? layout * UIConstants.toastHeightRatioPortrait
          : layout * UIConstants.toastHeightRatioLandscape
      }.overlay {
        Text(message)
          .font(.largeTitle)
          .bold()
      }
  }
  
  private struct UIConstants {
    static let toastWidthRatio: CGFloat = 0.8
    static let toastHeightRatioPortrait: CGFloat = 0.1
    static let toastHeightRatioLandscape: CGFloat = 0.3
  }
}

#Preview {
  Toast(message: "Testing toast")
}
