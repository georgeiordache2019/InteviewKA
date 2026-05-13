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
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockUsersUseCase()
        sut = UsersViewModel(usersUseCase: mockUseCase)
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func test_getUsers_shouldPopulateUsersAndFilteredUsers() async {
        // Given
        let users = User.usersMock
        
        mockUseCase.users = users
        
        // When
        await sut.getUsers()
        
        // Then
        XCTAssertEqual(sut.users.count, 2)
        XCTAssertEqual(sut.filteredUsers.count, 2)
    }
    
    func test_searchText_shouldFilterByFirstName() async throws {
        // Given
        await sut.getUsers()
        
        // When
        sut.searchText = "john"
        
        // Wait for debounce
        try await Task.sleep(for: .milliseconds(600))
        
        // Then
        XCTAssertEqual(sut.filteredUsers.count, 1)
        XCTAssertEqual(sut.filteredUsers.first?.email, "john@test.com")
    }
    
    func test_searchText_shouldFilterByLastName() async throws {
        // Given
        await sut.getUsers()
        
        // When
        sut.searchText = "smith"
        
        // Wait for debounce
        try await Task.sleep(for: .milliseconds(600))
        
        // Then
        XCTAssertEqual(sut.filteredUsers.count, 1)
        XCTAssertEqual(sut.filteredUsers.first?.email, "jane@test.com")
    }
    
    func test_searchText_shouldFilterByEmail() async throws {
        // Given
        await sut.getUsers()
        
        // When
        sut.searchText = "john@test"
        
        // Wait for debounce
        try await Task.sleep(for: .milliseconds(600))
        
        // Then
        XCTAssertEqual(sut.filteredUsers.count, 1)
    }
    
    func test_searchText_empty_shouldReturnAllUsers() async throws {
        // Given
        await sut.getUsers()
        
        // When
        sut.searchText = ""
        
        // Wait for debounce
        try await Task.sleep(for: .milliseconds(600))
        
        // Then
        XCTAssertEqual(sut.filteredUsers.count, 2)
    }
}
