//
//  Image_Extensions.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-24.
//

import SwiftUI

extension Image {
  func iconImage() -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fill)
      .clipShape(.circle)
  }
}
