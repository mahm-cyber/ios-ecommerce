//
//  TestTransport.swift
//  DataTests
//
//  Created by NamaaIT Apple3 on 19/10/2026.
//

import Foundation
import Networking

struct TestTransport: HTTPTransport {
    var handler: @Sendable (URLRequest) throws -> (Data, URLResponse)

    init(handler: @Sendable @escaping (URLRequest) throws -> (Data, URLResponse)) {
        self.handler = handler
    }

    func send(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try handler(request)
    }
}

extension TestTransport {
    static func returning(
        statusCode: Int = 200,
        data: Data = Data()
    ) -> TestTransport {
        TestTransport { request in
            let response = HTTPURLResponse(
                url: request.url ?? URL(string: "https://example.com")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            return (data, response)
        }
    }
}
