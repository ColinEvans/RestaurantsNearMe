//
//  DeviceOrientationEnvironmentKey.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import Foundation
import SwiftUI

struct DeviceOrientationEnvironmentKey: EnvironmentKey {
  static let defaultValue: UIDeviceOrientation = .unknown
}
