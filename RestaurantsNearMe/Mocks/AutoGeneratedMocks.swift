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
    var fetchedAPIKey: AnyPublisher<APIKey, Never> {
        get { return underlyingFetchedAPIKey }
        set(value) { underlyingFetchedAPIKey = value }
    }
    var underlyingFetchedAPIKey: (AnyPublisher<APIKey, Never>)!


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
class RestaurantListProvidingMock: RestaurantListProviding {


    var restaurants: AnyPublisher<[Restaurant], Never> {
        get { return underlyingRestaurants }
        set(value) { underlyingRestaurants = value }
    }
    var underlyingRestaurants: (AnyPublisher<[Restaurant], Never>)!
    var fetchingError: AnyPublisher<String, Never> {
        get { return underlyingFetchingError }
        set(value) { underlyingFetchingError = value }
    }
    var underlyingFetchingError: (AnyPublisher<String, Never>)!


    //MARK: - updateRestaurants

    var updateRestaurantsCallsCount = 0
    var updateRestaurantsCalled: Bool {
        return updateRestaurantsCallsCount > 0
    }
    var updateRestaurantsClosure: (() async -> Void)?

    func updateRestaurants() async {
        updateRestaurantsCallsCount += 1
        await updateRestaurantsClosure?()
    }

}
