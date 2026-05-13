//
//  FetchUsersUseCase.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

protocol FetchUsersUseCase {
    func execute(count: Int) async throws -> [User]
}

final class DefaultFetchUsersUseCase: FetchUsersUseCase {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(count: Int) async throws -> [User] {
        try await repository.fetchUsers(count: count)
    }
}
