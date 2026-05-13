//
//  MockHTTPClient.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import XCTest
@testable import InterviewKA

// MARK: - Mock Client

final class MockHTTPClient: KAHTTPClient {

    var resultToReturn: Any?
    var errorToThrow: Error?
    var receivedEndpoint: Any?

    func send<T>(_ endpoint: any KAEndpoint) async throws -> T where T : Decodable {

        receivedEndpoint = endpoint

        if let error = errorToThrow {
            throw error
        }

        guard let result = resultToReturn as? T else {
            fatalError("Mock not configured properly for type \(T.self)")
        }

        return result
    }
}
