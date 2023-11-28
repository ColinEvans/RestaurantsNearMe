//
//  DeviceOrientationProvider.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-25.
//

import Foundation
import UIKit
import Combine

struct DeviceOrientationProvider {
  let _currentDeviceOrientation = PassthroughSubject<UIDeviceOrientation, Never>()
  private var cancellables = Set<AnyCancellable>()

  init() {
    NotificationCenter.default
      .publisher(for: UIDevice.orientationDidChangeNotification)
      .receive(on: DispatchQueue.main)
      .sink { [_currentDeviceOrientation] _ in
        _currentDeviceOrientation.send(UIDevice.current.orientation)
      }.store(in: &cancellables)
  }
}

extension DeviceOrientationProvider: DeviceOrientationProviding {
  var currentDeviceOrientation: AnyPublisher<UIDeviceOrientation, Never> {
    _currentDeviceOrientation.eraseToAnyPublisher()
  }
}
