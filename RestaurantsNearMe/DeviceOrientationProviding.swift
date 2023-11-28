//
//  DeviceOrientationProviding.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import Foundation
import UIKit
import Combine

protocol DeviceOrientationProviding {
  var currentDeviceOrientation: AnyPublisher<UIDeviceOrientation,Never> { get }
}
