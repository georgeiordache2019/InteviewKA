//
//  FetchUsersUseCaseTests.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import XCTest
@testable import InterviewKA

@MainActor
final class FetchUsersUseCaseTests: XCTestCase {

    private var repository: MockUserRepository!
    private var useCase: UsersUseCase!

    override func setUp() {
        super.setUp()
        repository = MockUserRepository()
        useCase = UsersUseCase(repository: repository)
    }

    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }

    func test_execute_returnsUsers() async throws {

        // Given
        let expectedUsers = [
            User(gender: "male",
                 name: .init(title: "title",
                             first: "first",
                             last: "last"),
                 email: "john@example.com",
                 phone: "09123124112",
                 cell: "09132131211",
                 picture: .init(large: "large",
                                medium: "mediu",
                                thumbnail: "thumbnail"))
        ]

        repository.result = .success(expectedUsers)

        // When
        let result = try await useCase.execute(count: 1)

        // Then
        XCTAssertTrue(repository.fetchUsersCalled)
        XCTAssertEqual(repository.receivedCount, 1)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.email, "john@example.com")
    }
    
    func test_execute_throwsError() async {

        // Given
        struct DummyError: Error {}
        repository.result = .failure(DummyError())

        // When / Then
        do {
            _ = try await useCase.execute(count: 5)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(repository.fetchUsersCalled)
        }
    }
}
