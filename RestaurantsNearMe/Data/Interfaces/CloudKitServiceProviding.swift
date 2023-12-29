//
//  CloudKitServiceProviding.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-27.
//

import Foundation
import Combine
import CloudKit

// sourcery: AutoMockable
protocol CloudKitServiceProviding {
  var accountStatus: CurrentValueSubject<CKAccountStatus, Never> { get }
  var isFetchingFromCloudKit: AnyPublisher<Bool, Never> { get }

  func fetchAPIKeyByID() async throws
  func refreshAccountStatus() async throws
}
