//
//  CloudKitService.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-27.
//

import Foundation
import Combine
import CloudKit

final class CloudKitService {
  private let applicationContainer = CKContainer.default()
  @APIKeyProvider private var apiKeyProvider: APIKey?
  private lazy var cloudKitServiceActor = CloudKitServiceActor(_isFetchingFromCloudKit)
  
  private let _accountStatus = CurrentValueSubject<CKAccountStatus, Never>(.couldNotDetermine)
  private let _isFetchingFromCloudKit = PassthroughSubject<Bool, Never>()
}

extension CloudKitService: CloudKitServiceProviding {
  var accountStatus: AnyPublisher<CKAccountStatus, Never> {
    _accountStatus.eraseToAnyPublisher()
  }
  
  var isFetchingFromCloudKit: AnyPublisher<Bool, Never> {
    _isFetchingFromCloudKit.eraseToAnyPublisher()
  }
  
  func fetchAPIKeyByID() async throws {
    await cloudKitServiceActor.updateIsFetching(to: true)
    
    let id = CKRecord.ID(recordName: APIKey.name)
    guard _accountStatus.value == .available else {
      await cloudKitServiceActor.updateIsFetching(to: false)
      throw CloudKitServiceError.containerNotAvailable
    }
    
    do {
      let apiRecord = try await applicationContainer.publicCloudDatabase.record(for: id)
      guard let recordValue = apiRecord.object(forKey: APIKeyNames.keyName.rawValue) as? String else {
        await cloudKitServiceActor.updateIsFetching(to: false)
        throw CloudKitServiceError.incorrectDataFormat
      }

      apiKeyProvider = APIKey(keyName: recordValue)
      await cloudKitServiceActor.updateIsFetching(to: false)
    } catch {
      await cloudKitServiceActor.updateIsFetching(to: false)
      throw CloudKitServiceError.fetchFailed
    }
  }
  
  func refreshAccountStatus() async throws {
    guard await !cloudKitServiceActor.isFetching else {
      throw CloudKitServiceError.fetchFailed
    }
    
    async let status = applicationContainer.accountStatus()
    do {
      try await _accountStatus.send(status)
      await cloudKitServiceActor.updateIsFetching(to: false)
    } catch {
      await cloudKitServiceActor.updateIsFetching(to: false)
      throw CloudKitServiceError.containerNotAvailable
    }
  }
}
