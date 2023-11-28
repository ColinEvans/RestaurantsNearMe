//
//  MockCloudKitService.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-24.
//

import Foundation
import Combine
import CloudKit

class MockCloudKitService: CloudKitServiceProviding {
  let applicationContainer = CKContainer.default()
  let accountStatus = CurrentValueSubject<CKAccountStatus, Never>(.couldNotDetermine).eraseToAnyPublisher()

  func refreshAccountStatus() async {}
  func fetchAPIKeyByID() async throws {}
}
