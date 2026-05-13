//
//  AnyEncodable.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation

struct AnyEncodable: Encodable {

    private let encodeClosure: (Encoder) throws -> Void

    init(_ encodable: Encodable) {
        self.encodeClosure = encodable.encode
    }

    func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}
