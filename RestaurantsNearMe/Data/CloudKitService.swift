//
//  CloudKitService.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-27.
//

import Foundation
import Combine
import CloudKit

class CloudKitService: CloudKitServiceProviding {
  let applicationContainer = CKContainer.default()
  private let _fetchingStatus = PassthroughSubject<Bool, Never>()

  private let _accountStatus = CurrentValueSubject<CKAccountStatus, Never>(.couldNotDetermine)
  var accountStatus: AnyPublisher<CKAccountStatus, Never> {
    _accountStatus.eraseToAnyPublisher()
  }
  
  init() {
    Task.init {
      try? await refreshAccountStatus()
    }
  }
  
  func fetchAPIKeyByID() async throws {
    let id = CKRecord.ID(recordName: APIKey.name)
    guard _accountStatus.value == .available else {
      throw CloudKitServiceError.containerNotAvailable
    }
    
    do {
      let apiRecord = try await applicationContainer.publicCloudDatabase.record(for: id)
      guard let recordValue = apiRecord.object(forKey: APIKeyNames.keyName.rawValue) as? String else {
        throw CloudKitServiceError.incorrectDataFormat
      }

      APIKeyProvider.key = APIKey(keyName: recordValue)
    } catch {
      throw CloudKitServiceError.fetchFailed
    }
  }
  
  func refreshAccountStatus() async throws {
    defer { _fetchingStatus.send(false) }
      
    do {
      let status = try await applicationContainer.accountStatus()
      _accountStatus.send(status)
    } catch {
      throw CloudKitServiceError.containerNotAvailable
    }
  }
}
