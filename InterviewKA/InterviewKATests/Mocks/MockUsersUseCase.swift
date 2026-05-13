//
//  MockUsersUseCase.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//


import XCTest
@testable import InterviewKA

final class MockUsersUseCase: UsersUseCaseProtocol {
    
    var users: [User] = User.usersMock
    
    func execute(count: Int) async throws -> [User] {
        users
    }
}
