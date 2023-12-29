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
