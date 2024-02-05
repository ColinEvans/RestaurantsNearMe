//
//  OffsetProviding.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-02-04.
//

import Foundation
import Combine

// sourcery: AutoMockable
protocol OffsetProviding {
  var currentPageOffset: CurrentValueSubject<Int, Never> { get }
}
