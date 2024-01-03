// Generated using Sourcery 2.1.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import CloudKit
import Combine























class CloudKitServiceProvidingMock: CloudKitServiceProviding {


    var accountStatus: CurrentValueSubject<CKAccountStatus, Never> {
        get { return underlyingAccountStatus }
        set(value) { underlyingAccountStatus = value }
    }
    var underlyingAccountStatus: (CurrentValueSubject<CKAccountStatus, Never>)!
    var isFetchingFromCloudKit: AnyPublisher<Bool, Never> {
        get { return underlyingIsFetchingFromCloudKit }
        set(value) { underlyingIsFetchingFromCloudKit = value }
    }
    var underlyingIsFetchingFromCloudKit: (AnyPublisher<Bool, Never>)!
    var apiKey: APIKey {
        get { return underlyingApiKey }
        set(value) { underlyingApiKey = value }
    }
    var underlyingApiKey: (APIKey)!


    //MARK: - fetchAPIKeyByID

    var fetchAPIKeyByIDThrowableError: Error?
    var fetchAPIKeyByIDCallsCount = 0
    var fetchAPIKeyByIDCalled: Bool {
        return fetchAPIKeyByIDCallsCount > 0
    }
    var fetchAPIKeyByIDClosure: (() async throws -> Void)?

    func fetchAPIKeyByID() async throws {
        if let error = fetchAPIKeyByIDThrowableError {
            throw error
        }
        fetchAPIKeyByIDCallsCount += 1
        try await fetchAPIKeyByIDClosure?()
    }

    //MARK: - refreshAccountStatus

    var refreshAccountStatusThrowableError: Error?
    var refreshAccountStatusCallsCount = 0
    var refreshAccountStatusCalled: Bool {
        return refreshAccountStatusCallsCount > 0
    }
    var refreshAccountStatusClosure: (() async throws -> Void)?

    func refreshAccountStatus() async throws {
        if let error = refreshAccountStatusThrowableError {
            throw error
        }
        refreshAccountStatusCallsCount += 1
        try await refreshAccountStatusClosure?()
    }

}
class LocationProvidingMock: LocationProviding {


    var locationErrorPropogator: AnyPublisher<LocationError, Never> {
        get { return underlyingLocationErrorPropogator }
        set(value) { underlyingLocationErrorPropogator = value }
    }
    var underlyingLocationErrorPropogator: (AnyPublisher<LocationError, Never>)!
    var currentLocation: AnyPublisher<CLLocation, Never> {
        get { return underlyingCurrentLocation }
        set(value) { underlyingCurrentLocation = value }
    }
    var underlyingCurrentLocation: (AnyPublisher<CLLocation, Never>)!
    var areLocationPermissionsValid: AnyPublisher<Bool, Never> {
        get { return underlyingAreLocationPermissionsValid }
        set(value) { underlyingAreLocationPermissionsValid = value }
    }
    var underlyingAreLocationPermissionsValid: (AnyPublisher<Bool, Never>)!


    //MARK: - askLocationPermissions

    var askLocationPermissionsCallsCount = 0
    var askLocationPermissionsCalled: Bool {
        return askLocationPermissionsCallsCount > 0
    }
    var askLocationPermissionsClosure: (() -> Void)?

    func askLocationPermissions() {
        askLocationPermissionsCallsCount += 1
        askLocationPermissionsClosure?()
    }

}
class YelpAPIRequestingMock: YelpAPIRequesting {




    //MARK: - updateAPIKey

    var updateAPIKeyCallsCount = 0
    var updateAPIKeyCalled: Bool {
        return updateAPIKeyCallsCount > 0
    }
    var updateAPIKeyClosure: (() -> Void)?

    func updateAPIKey() {
        updateAPIKeyCallsCount += 1
        updateAPIKeyClosure?()
    }

    //MARK: - getUpdatedRestaurants

    var getUpdatedRestaurantsCallsCount = 0
    var getUpdatedRestaurantsCalled: Bool {
        return getUpdatedRestaurantsCallsCount > 0
    }
    var getUpdatedRestaurantsClosure: (() async -> Void)?

    func getUpdatedRestaurants() async {
        getUpdatedRestaurantsCallsCount += 1
        await getUpdatedRestaurantsClosure?()
    }

}
