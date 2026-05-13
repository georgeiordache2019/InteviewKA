//
//  UsersUseCase.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

protocol UsersUseCaseProtocol {
    func execute(count: Int) async throws -> [User]
}

final class UsersUseCase: UsersUseCaseProtocol {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol = UserRepository(client: DefaultKAHTTPClient())) {
        self.repository = repository
    }

    func execute(count: Int) async throws -> [User] {
        try await repository.fetchUsers(count: count)
    }
}
