//
//  UserRepositoryTests.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import XCTest
@testable import InterviewKA

@MainActor
final class UserRepositoryTests: XCTestCase {

    private var client: MockHTTPClient!
    private var sut: UserRepository!

    override func setUp() {
        super.setUp()
        client = MockHTTPClient()
        sut = UserRepository(client: client)
    }

    override func tearDown() {
        client = nil
        sut = nil
        super.tearDown()
    }

    func test_fetchUsers_returnsMappedUsers() async throws {
        // Given
        let dto = UserDTO.mock()

        client.resultToReturn = RandomUserResponse(results: [dto])

        // When
        let users = try await sut.fetchUsers(count: 1)

        // Then
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.email, dto.email)
        XCTAssertEqual(users.first?.name.first, dto.name.first)
    }

    func test_fetchUsers_sendsCorrectCountInEndpoint() async throws {
        // Given
        client.resultToReturn = RandomUserResponse(results: [])

        // When
        _ = try await sut.fetchUsers(count: 5)

        // Then
        guard let endpoint = client.receivedEndpoint as? RandomUsersEndpoint else {
            return XCTFail("Wrong endpoint type")
        }

        XCTAssertEqual(endpoint.results, 5)
    }

    func test_fetchUsers_propagatesError() async {
        // Given
        struct DummyError: Error {}
        client.errorToThrow = DummyError()

        // When / Then
        do {
            _ = try await sut.fetchUsers(count: 3)
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(error is DummyError)
        }
    }
}
