//
//  RandomUserResponse.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation

struct RandomUserResponse: Decodable {
    let results: [UserDTO]
}

struct UserDTO: Decodable {
    let gender: String
    let name: NameDTO
    let email: String
    let phone: String
    let cell: String
    let picture: PictureDTO
    
    init(gender: String, name: NameDTO, email: String, phone: String, cell: String, picture: PictureDTO) {
        self.gender = gender
        self.name = name
        self.email = email
        self.phone = phone
        self.cell = cell
        self.picture = picture
    }
}

struct NameDTO: Decodable {
    let title: String
    let first: String
    let last: String
    
    init(title: String, first: String, last: String) {
        self.title = title
        self.first = first
        self.last = last
    }
}

struct PictureDTO: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
    
    init(large: String, medium: String, thumbnail: String) {
        self.large = large
        self.medium = medium
        self.thumbnail = thumbnail
    }
}
