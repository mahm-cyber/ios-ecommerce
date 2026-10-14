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
        query: [URLQueryItem] = [],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.queries = query
        self.body = body
    }
    
//    static let questions = Endpoint<>(path: "Question")
}


extension Endpoint where Response == ConcreteType {
    public static var endpointName: Endpoint {
        Endpoint(path: )
    }
}
