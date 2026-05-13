//
//  MockUserRepository.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import XCTest
@testable import InterviewKA

final class MockUserRepository: UserRepositoryProtocol {

    var fetchUsersCalled = false
    var receivedCount: Int?

    var result: Result<[User], Error> = .success([])

    func fetchUsers(count: Int) async throws -> [User] {
        fetchUsersCalled = true
        receivedCount = count

        switch result {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
}
