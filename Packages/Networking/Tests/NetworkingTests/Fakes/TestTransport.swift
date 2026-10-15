//
//  Test.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 15/10/2026.
//

import Testing
import Networking
import Foundation


public struct TestTransport: HTTPTransport {
    public var handler: @Sendable (URLRequest) throws -> (Data, URLResponse)
    
    public init(
        handler: @Sendable @escaping (URLRequest) throws -> (Data, URLResponse)
    ) {
        self.handler = handler
    }
    
    public func send(_ request: URLRequest) async throws -> (
        Data,
        URLResponse
    ) {
        try handler(request)
    }
}

 
extension TestTransport {
    public static func returning(
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
