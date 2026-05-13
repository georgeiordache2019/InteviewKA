//
//  UserDTOMock.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import XCTest
@testable import InterviewKA

extension UserDTO {

    static func mock() -> UserDTO {

        return UserDTO(gender: "male",
                       name: NameDTO.mock(),
                       email: "lee.fuller@example.com",
                       phone: "01618189583",
                       cell: "0783-416-873",
                       picture: PictureDTO.mock())
    }
}

extension NameDTO {
    static func mock() -> NameDTO {
        NameDTO(title: "mr",
                first: "lee",
                last: "fuller")
    }
}

extension PictureDTO {
    static func mock() -> PictureDTO {
        PictureDTO(large: "https://randomuser.me/api/portraits/men/63.jpg",
                   medium: "https://randomuser.me/api/portraits/med/men/63.jpg",
                   thumbnail: "https://randomuser.me/api/portraits/thumb/men/63.jpg")
    }
}
