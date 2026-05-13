//
//  RandomUsersEndpoint.swift
//  InterviewKA
//
//  Created by George on 13.05.2026.
//

struct RandomUsersEndpoint: KAEndpoint {

    let results: Int

    var host: String {
        "api.randomuser.me"
    }

    var path: String {
        "/"
    }

    var method: HTTPMethod {
        .get
    }

    var queryParameters: KAQueryParameters? {
        [
            "results": "\(results)"
        ]
    }
}
