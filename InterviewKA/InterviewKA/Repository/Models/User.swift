//
//  User.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

struct User {
    let gender: String
    let name: Name
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
}

struct Name {
    let title: String
    let first: String
    let last: String
}

struct Picture {
    let large: String
    let medium: String
    let thumbnail: String
}
