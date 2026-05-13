//
//  User+Ext.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

extension User {
    init(dto: UserDTO) {
        self.gender = dto.gender
        self.name = Name(dto: dto.name)
        self.email = dto.email
        self.phone = dto.phone
        self.cell = dto.cell
        self.picture = Picture(dto: dto.picture)
    }
}

extension Name {
    init (dto: NameDTO) {
        self.title = dto.title
        self.first = dto.first
        self.last = dto.last
    }
}

extension Picture {
    init (dto: PictureDTO) {
        self.large = dto.large
        self.medium = dto.medium
        self.thumbnail = dto.thumbnail
    }
}
