//
//  NetworkError.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case transport(Error)
    case server(statusCode: Int, data: Data)
    case decoding(Error)
}
