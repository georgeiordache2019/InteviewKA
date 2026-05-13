//
//  UsersViewModelTests.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import XCTest
@testable import InterviewKA

@MainActor
final class UsersViewModelTests: XCTestCase {
    
    private var sut: UsersViewModel!
    private var mockUseCase: MockUsersUseCase!
    private var mockStorage: MockUsersStorage!
    
    override func setUp() {
        super.setUp()
        
        mockUseCase = MockUsersUseCase()
        mockStorage = MockUsersStorage()
        
        sut = UsersViewModel(
            usersUseCase: mockUseCase,
            storage: mockStorage
        )
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        mockStorage = nil
        super.tearDown()
    }
        
    func test_getUsers_shouldPopulateUsersAndFilteredUsers() async {
        // Given
        mockUseCase.users = User.usersMock
        
        // When
        await sut.getUsers()
        
        // Then
        XCTAssertEqual(sut.users.count, 2)
        XCTAssertEqual(sut.filteredUsers.count, 2)
        XCTAssertEqual(mockStorage.savedUsers.count, 2)
    }
    
    func test_getUsers_shouldNotDuplicateExistingUsers() async {
        // Given
        let existing = [User.usersMock[0]]
        mockStorage.savedUsers = existing
        
        sut = UsersViewModel(usersUseCase: mockUseCase, storage: mockStorage)
        mockUseCase.users = User.usersMock
        
        // When
        await sut.getUsers()
        
        // Then
        XCTAssertEqual(sut.users.count, 2)
    }
    
    func test_getUsers_shouldExcludeDeletedUsers() async {
        // Given
        mockStorage.deletedEmails = ["john@test.com"]
        mockUseCase.users = User.usersMock
        
        // When
        await sut.getUsers()
        
        // Then
        XCTAssertEqual(sut.users.count, 1)
        XCTAssertEqual(sut.users.first?.email, "jane@test.com")
    }
    
    // MARK: - Search
    
    func test_search_shouldFilterByFirstName() async throws {
        await sut.getUsers()
        
        sut.searchText = "john"
        try await Task.sleep(for: .milliseconds(600))
        
        XCTAssertEqual(sut.filteredUsers.count, 1)
        XCTAssertEqual(sut.filteredUsers.first?.email, "john@test.com")
    }
    
    func test_search_shouldFilterByLastName() async throws {
        await sut.getUsers()
        
        sut.searchText = "smith"
        try await Task.sleep(for: .milliseconds(600))
        
        XCTAssertEqual(sut.filteredUsers.count, 1)
        XCTAssertEqual(sut.filteredUsers.first?.email, "jane@test.com")
    }
    
    func test_search_shouldFilterByEmail() async throws {
        await sut.getUsers()
        
        sut.searchText = "john@test"
        try await Task.sleep(for: .milliseconds(600))
        
        XCTAssertEqual(sut.filteredUsers.count, 1)
    }
    
    func test_search_empty_shouldReturnAllUsers() async throws {
        await sut.getUsers()
        
        sut.searchText = ""
        try await Task.sleep(for: .milliseconds(600))
        
        XCTAssertEqual(sut.filteredUsers.count, 2)
    }
    
    // MARK: - Delete
    
    func test_deleteUser_shouldRemoveFromListsAndPersist() async {
        // Given
        await sut.getUsers()
        let user = User.usersMock.first!
        
        // When
        sut.deleteUser(user)
        
        // Then
        XCTAssertFalse(sut.users.contains(where: { $0.email == user.email }))
        XCTAssertFalse(sut.filteredUsers.contains(where: { $0.email == user.email }))
        XCTAssertTrue(mockStorage.deletedEmails.contains(user.email))
        XCTAssertEqual(mockStorage.savedUsers.count, 1)
    }
}
