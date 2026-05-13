//
//  User.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation

struct User: Codable {
    let gender: String
    let name: Name
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
    
    var fullName: String {
        return "\(first) \(last)"
    }
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

extension Picture {
    var urlImage: URL? {
        return URL(string: medium)
    }
}
