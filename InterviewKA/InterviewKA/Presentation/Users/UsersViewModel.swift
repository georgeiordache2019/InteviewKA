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
    @Published var filteredUsers: [User] = []
    @Published var searchText: String = ""
    
    private let usersUseCase: UsersUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(usersUseCase: UsersUseCaseProtocol = UsersUseCase(repository: UserRepository())) {
        self.usersUseCase = usersUseCase
        setupSearch()
    }
    
    func getUsers() async {
        do {
            let userResponse = try await usersUseCase.execute(count: 10)
            self.users.append(contentsOf: userResponse)
            self.filteredUsers = userResponse
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.filterUsers(with: value)
            }
            .store(in: &cancellables)
    }
    
    private func filterUsers(with query: String) {
        guard !query.isEmpty else {
            filteredUsers = users
            return
        }
        
        let lowercasedQuery = query.lowercased()
        
        filteredUsers = users.filter { user in
            user.name.first.lowercased().contains(lowercasedQuery) ||
            user.name.last.lowercased().contains(lowercasedQuery) ||
            user.email.lowercased().contains(lowercasedQuery)
        }
    }
}
