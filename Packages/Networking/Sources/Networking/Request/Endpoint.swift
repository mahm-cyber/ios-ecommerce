//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 12/10/2026.
//

import Foundation




public struct Endpoint<Response: Decodable & Sendable> : Sendable {
      let path: String
      let method: HTTPMethod
      let queries: [URLQueryItem]
      public let body: Data?

    public init(
        path: String,
        method: HTTPMethod = .get,
        queries: [URLQueryItem] = [],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.queries = queries
        self.body = body
    }

}
