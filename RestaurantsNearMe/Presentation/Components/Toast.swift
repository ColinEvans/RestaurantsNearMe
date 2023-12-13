//
//  Toast.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import SwiftUI

struct Toast: View {
  let message: String
  var parentSize: CGSize

  var body: some View {
      RoundedRectangle(cornerRadius: 10.0)
        .strokeBorder()
        .fill(Color.clear)
        .frame(
          width: parentSize.width * UIConstants.toastWidthRatio,
          height: isLandscape(parentSize)
            ? parentSize.height * UIConstants.toastHeightRatioLandscape
            : parentSize.height * UIConstants.toastHeightRatioPortrait
        ).overlay {
          Text(message)
            .font(.largeTitle)
            .bold()
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
  Toast(
    message: "Testing toast",
    parentSize: CGSize(width: 400, height: 400)
  )
}
