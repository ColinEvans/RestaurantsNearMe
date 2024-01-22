//
//  SplashScreenViewModel.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-24.
//

import Foundation
import Combine
import CloudKit
import Networking

class SplashScreenViewModel: ObservableObject {
  @Published var fetchingError: String?
  @Published var isLoading = false
  
  private var cancellables = Set<AnyCancellable>()
  private let cloudKitService: any CloudKitServiceProviding
  
  init(cloudKitService: some CloudKitServiceProviding) {
    self.cloudKitService = cloudKitService
    cloudKitService.isFetchingFromCloudKit
      .combineLatest($fetchingError)
      .receive(on: DispatchQueue.main)
      .map { $0 || $1 != nil }
      .assign(to: &$isLoading)
  }

  func fetch() async {
    do {
      try await cloudKitService.fetchAPIKeyByID()
    } catch let ckError where ckError is CloudKitServiceError {
      DispatchQueue.main.async {
        self.fetchingError = String(describing: ckError)
      }
    } catch {
      print("Unexpected error occured")
    }
  }

  @MainActor func refresh() {
    fetchingError = nil
    Task.detached {
      await self.fetch()
    }
  }
}

extension SplashScreenViewModel {
  static func preview() -> SplashScreenViewModel {
    let mock = CloudKitServiceProvidingMock()
    mock.underlyingAccountStatus
    = CurrentValueSubject<CKAccountStatus, Never>(.available)
    mock.underlyingIsFetchingFromCloudKit = PassthroughSubject<Bool, Never>().eraseToAnyPublisher()
    
    return SplashScreenViewModel(
      cloudKitService: mock
    )
  }
}
