//
//  UsersStorageProtocol.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation

protocol UsersStorageProtocol {
    func save(users: [User])
    func loadUsers() -> [User]
    
    func saveDeletedUser(email: String)
    func loadDeletedUsers() -> [String]
}


import Foundation

final class UsersStorage: UsersStorageProtocol {
    
    private enum Keys {
        static let users = "saved_users"
        static let deletedUsers = "deleted_users"
    }
    
    func save(users: [User]) {
        do {
            let data = try JSONEncoder().encode(users)
            UserDefaults.standard.set(data, forKey: Keys.users)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadUsers() -> [User] {
        guard
            let data = UserDefaults.standard.data(forKey: Keys.users),
            let users = try? JSONDecoder().decode([User].self, from: data)
        else {
            return []
        }
        
        return users
    }
    
    func saveDeletedUser(email: String) {
        var deletedUsers = loadDeletedUsers()
        
        if !deletedUsers.contains(email) {
            deletedUsers.append(email)
        }
        
        UserDefaults.standard.set(deletedUsers, forKey: Keys.deletedUsers)
    }
    
    func loadDeletedUsers() -> [String] {
        UserDefaults.standard.stringArray(forKey: Keys.deletedUsers) ?? []
    }
}
