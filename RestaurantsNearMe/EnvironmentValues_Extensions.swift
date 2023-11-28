//
//  EnvironmentValues_Extensions.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
  var deviceOrientation: UIDeviceOrientation {
    get { self[DeviceOrientationEnvironmentKey.self] }
    set { self[DeviceOrientationEnvironmentKey.self] = newValue }
  }
}
