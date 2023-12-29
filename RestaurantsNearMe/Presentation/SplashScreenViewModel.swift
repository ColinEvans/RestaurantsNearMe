//
//  SplashScreenViewModel.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-11-24.
//

// TODO: Figure out where to refresh account status then from there we can call fetch


import Foundation
import Combine
import CloudKit

class SplashScreenViewModel: ObservableObject {
  private var isFetching = PassthroughSubject<Bool, Never>()
  @Published var fetchingError: String?
  @Published var showLoadingView = true
  
  private var cancellables = Set<AnyCancellable>()
  private let cloudKitService: any CloudKitServiceProviding
  
  init(cloudKitService: some CloudKitServiceProviding) {
    self.cloudKitService = cloudKitService
    cloudKitService.isFetchingFromCloudKit
      .receive(on: DispatchQueue.main)
      .sink { self.isFetching.send($0) }
      .store(in: &cancellables)

    isFetching
      .combineLatest($fetchingError)
      .receive(on: DispatchQueue.main)
      .map { $0 || $1 != nil }
      .assign(to: &$showLoadingView)
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
    mock.underlyingAccountStatus = CurrentValueSubject<CKAccountStatus, Never>(.available)
    mock.underlyingIsFetchingFromCloudKit = PassthroughSubject<Bool, Never>().eraseToAnyPublisher()
    
    return SplashScreenViewModel(cloudKitService: mock)
  }
}
