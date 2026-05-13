//
//  UsersViewModel.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation
import Combine

final class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var searchText: String = ""
    
    private let usersUseCase: UsersUseCaseProtocol
    private let storage: UsersStorageProtocol
    private var cancellables = Set<AnyCancellable>()
    private let count = 10
    
    init(usersUseCase: UsersUseCaseProtocol = UsersUseCase(repository: UserRepository()),
         storage: UsersStorageProtocol = UsersStorage()) {
        self.usersUseCase = usersUseCase
        self.storage = storage
        setupSearch()
        loadPersistedUsers()
    }
    
    func getUsers() async {
        do {
            let response = try await usersUseCase.execute(count: 10)
            let deletedEmails = storage.loadDeletedUsers()
            
            let filteredResponse = response.filter {
                !deletedEmails.contains($0.email)
            }
            
            let existingEmails = Set(users.map(\.email))
            
            let newUsers = filteredResponse.filter {
                !existingEmails.contains($0.email)
            }
            
            users.append(contentsOf: newUsers)
            
            storage.save(users: users)
            await MainActor.run {
                filterUsers(with: searchText)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUser(_ user: User) {
        users.removeAll { $0.email == user.email }
        filteredUsers.removeAll { $0.email == user.email }
        
        storage.saveDeletedUser(email: user.email)
        storage.save(users: users)
    }
    
    private func loadPersistedUsers() {
        users = storage.loadUsers()
        filteredUsers = users
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
