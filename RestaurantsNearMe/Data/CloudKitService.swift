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
  @APIKeyProvider private var apiKeyProvider: APIKey
  private lazy var cloudKitServiceActor = CloudKitServiceActor(_isFetchingFromCloudKit)
  
  let accountStatus = CurrentValueSubject<CKAccountStatus, Never>(.couldNotDetermine)
  private let _isFetchingFromCloudKit = PassthroughSubject<Bool, Never>()
  
  init(apiKeySource: APIKey.Source) {
    _apiKeyProvider = .init(apiKeySource)
  }
  
  private func performCloudKitAction(_ interaction: () async throws -> Void) async throws {
    guard await !cloudKitServiceActor.isFetching else {
      throw CloudKitServiceError.fetchFailed
    }
    await cloudKitServiceActor.updateIsFetching(to: true)
    
    do {
      try await interaction()
      await cloudKitServiceActor.updateIsFetching(to: false)
    } catch {
      await cloudKitServiceActor.updateIsFetching(to: false)
      throw error
    }
  }
}

extension CloudKitService: CloudKitServiceProviding {
  var isFetchingFromCloudKit: AnyPublisher<Bool, Never> {
    _isFetchingFromCloudKit.eraseToAnyPublisher()
  }
  
  func fetchAPIKeyByID() async throws {
    try await performCloudKitAction {
      let id = CKRecord.ID(recordName: apiKeyProvider.keyId.uuidString)
      do {
        let apiRecord = try await applicationContainer.publicCloudDatabase.record(for: id)
        guard let recordValue = apiRecord.object(forKey: "keyName") as? String else {
          await cloudKitServiceActor.updateIsFetching(to: false)
          throw CloudKitServiceError.incorrectDataFormat
        }

        apiKeyProvider.value = recordValue
      } catch {
        throw CloudKitServiceError.fetchFailed
      }
    }
  }
  
  func refreshAccountStatus() async throws {
    try await performCloudKitAction {
      do {
        let status = try await applicationContainer.accountStatus()
        accountStatus.send(status)
      } catch {
        throw CloudKitServiceError.containerNotAvailable
      }
    }
  }
}
