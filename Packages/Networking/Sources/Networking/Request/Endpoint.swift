//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 12/10/2026.
//

import Foundation


public struct Endpoint<Response: Decodable> : Sendable {
      let path: String
      let method: HTTPMethod
      let queries: [URLQueryItem]

    public init(
        path: String,
        method: HTTPMethod = .get,
        query: [URLQueryItem] = []
    ) {
        self.path = path
        self.method = method
        self.queries = query
    }
}
