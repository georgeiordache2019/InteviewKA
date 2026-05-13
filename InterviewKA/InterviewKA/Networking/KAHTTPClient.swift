//
//  KAHTTPClient.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation

protocol KAHTTPClient {
    func send<T: Decodable>(
        _ endpoint: KAEndpoint
    ) async throws -> T
}

final class DefaultKAHTTPClient: KAHTTPClient {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    func send<T: Decodable>(
        _ endpoint: KAEndpoint
    ) async throws -> T {

        let request = try endpoint.makeRequest()

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.server(
                    statusCode: httpResponse.statusCode,
                    data: data
                )
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }

        } catch {
            throw NetworkError.transport(error)
        }
        
    }
}
