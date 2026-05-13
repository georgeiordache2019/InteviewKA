//
//  UserRepository.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

protocol UserRepositoryProtocol {
    func fetchUsers(count: Int) async throws -> [User]
}

final class UserRepository: UserRepositoryProtocol {

    private let client: KAHTTPClient

    init(client: KAHTTPClient = DefaultKAHTTPClient()) {
        self.client = client
    }

    func fetchUsers(count: Int) async throws -> [User] {

        let endpoint = RandomUsersEndpoint(results: count)
        let response: RandomUserResponse = try await client.send(endpoint)
        return response.results.map(User.init(dto:))
    }
}
