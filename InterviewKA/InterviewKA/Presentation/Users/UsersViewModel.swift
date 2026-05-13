//
//  UsersViewModel.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation
import Combine

@MainActor
final class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    private let usersUseCase: UsersUseCaseProtocol
    
    init(usersUseCase: UsersUseCaseProtocol = UsersUseCase(repository: UserRepository())) {
        self.usersUseCase = usersUseCase
    }
    
    func getUsers() async {
        do {
            let userResponse = try await usersUseCase.execute(count: 10)
            self.users = userResponse
        } catch {
            print(error.localizedDescription)
        }
    }
}
