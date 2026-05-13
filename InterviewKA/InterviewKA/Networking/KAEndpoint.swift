//
//  KAEndpoint.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

import Foundation

enum KAHTTPHeaderValue: String {
    case applicationJSON = "application/json"
}

enum KAHTTPHeaderKey: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case accept = "Accept"
}

typealias KAHTTPHeaders = [KAHTTPHeaderKey: String]
typealias KAQueryParameters = [String: String]

protocol KAEndpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: KAHTTPHeaders { get }
    var queryParameters: KAQueryParameters? { get }
    var body: Encodable? { get }

    func makeRequest() throws -> URLRequest
}

extension KAEndpoint {

    var scheme: String {
        "https"
    }

    var headers: KAHTTPHeaders {
        [
            .contentType: KAHTTPHeaderValue.applicationJSON.rawValue,
            .accept: KAHTTPHeaderValue.applicationJSON.rawValue
        ]
    }

    var queryParameters: KAQueryParameters? {
        nil
    }

    var body: Encodable? {
        nil
    }

    func makeRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        if let queryParameters {
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key.rawValue)
        }

        if let body {
            request.httpBody = try JSONEncoder().encode(AnyEncodable(body))
        }

        return request
    }
}
