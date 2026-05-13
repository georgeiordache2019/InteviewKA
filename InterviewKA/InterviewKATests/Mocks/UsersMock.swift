//
//  UsersMock.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//
import XCTest
@testable import InterviewKA

extension User {
    static var usersMock: [User] {
        return [
            User(
                gender: "male",
                name: Name(
                    title: "Mr",
                    first: "John",
                    last: "Doe"
                ),
                email: "john@test.com",
                phone: "123456789",
                cell: "987654321",
                picture: Picture(
                    large: "https://example.com/john-large.jpg",
                    medium: "https://example.com/john-medium.jpg",
                    thumbnail: "https://example.com/john-thumb.jpg"
                )
            ),
            
            User(
                gender: "female",
                name: Name(
                    title: "Mrs",
                    first: "Jane",
                    last: "Smith"
                ),
                email: "jane@test.com",
                phone: "111222333",
                cell: "444555666",
                picture: Picture(
                    large: "https://example.com/jane-large.jpg",
                    medium: "https://example.com/jane-medium.jpg",
                    thumbnail: "https://example.com/jane-thumb.jpg"
                )
            )
        ]
    }
}
