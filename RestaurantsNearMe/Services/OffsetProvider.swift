//
//  OffsetProvider.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-02-04.
//

import Foundation
import Combine

struct OffsetProvider: OffsetProviding {
  let currentPageOffset = CurrentValueSubject<Int, Never>(0)
}
