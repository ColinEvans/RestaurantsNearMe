//
//  CloudKitServiceProviding.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-27.
//

import Foundation
import Combine
import CloudKit

protocol CloudKitServiceProviding {
  var applicationContainer: CKContainer { get }
  var accountStatus: AnyPublisher<CKAccountStatus, Never> { get }

  func fetchAPIKeyByID() async throws
  func refreshAccountStatus() async throws
}
