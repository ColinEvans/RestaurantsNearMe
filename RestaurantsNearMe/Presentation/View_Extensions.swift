//
//  View_Extensions.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import Foundation
import SwiftUI

extension View {
  func deviceOrientation(_ orientation: UIDeviceOrientation) -> some View {
    environment(\.deviceOrientation, orientation)
  }
}
