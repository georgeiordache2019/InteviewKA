//
//  MockUsersStorage.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import XCTest
@testable import InterviewKA

final class MockUsersStorage: UsersStorageProtocol {
    
    var savedUsers: [User] = []
    var deletedEmails: [String] = []
    
    func save(users: [User]) {
        savedUsers = users
    }
    
    func loadUsers() -> [User] {
        savedUsers
    }
    
    func saveDeletedUser(email: String) {
        if !deletedEmails.contains(email) {
            deletedEmails.append(email)
        }
    }
    
    func loadDeletedUsers() -> [String] {
        deletedEmails
    }
}
