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
    do {
      try await cloudKitService.fetchAPIKeyByID()
    } catch let ckError where ckError is CloudKitServiceError {
      fetchingError = String(describing: ckError)
    }
  }

  init(cloudKitService: some CloudKitServiceProviding) {
    self.cloudKitService = cloudKitService
    cloudKitService.isFetchingFromCloudKit.receive(on: DispatchQueue.main).sink {
      self.isFetching = $0
    }.store(in: &cancellables)
  }
}

/*extension SplashScreenViewModel {
  static func preview() -> SplashScreenViewModel {
    //SplashScreenViewModel(cloudKitService: MockCloudKitService())
  }
}*/
