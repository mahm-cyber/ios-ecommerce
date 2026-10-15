//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 15/10/2026.
//

import Foundation


public protocol HTTPTransport: Sendable {
    func send(_ request: URLRequest) async throws -> (Data, URLResponse)
}


extension URLSession: HTTPTransport {
    public func send(_ request: URLRequest) async throws -> (
        Data,
        URLResponse
    ) {
        try await self.data(for: request)
    }
}
