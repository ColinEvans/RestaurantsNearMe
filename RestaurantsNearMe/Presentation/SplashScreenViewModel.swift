//
//  SplashScreenViewModel.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-24.
//

import Foundation
import Combine
import CloudKit

class SplashScreenViewModel: ObservableObject {
  @Published var isFetching = false
  @Published var fetchingError: String?
  
  private var cancellables = Set<AnyCancellable>()
  private let cloudKitService: any CloudKitServiceProviding
  
  func fetch() async throws {
    defer { isFetching = false }
    isFetching = true
    do {
      try await cloudKitService.fetchAPIKeyByID()
    } catch {
      if let cloudKitError = error as? CloudKitServiceError {
        fetchingError = cloudKitError.toErrorString()
      }
    }
  }

  init(cloudKitService: some CloudKitServiceProviding) {
    self.cloudKitService = cloudKitService
  }
}

extension SplashScreenViewModel {
  static func preview() -> SplashScreenViewModel {
    SplashScreenViewModel(cloudKitService: MockCloudKitService())
  }
}
