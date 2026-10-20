//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public struct APIResponse<T: Decodable & Sendable>: Decodable, Sendable {
    public let status: Int?
    public let message: String?
    public let data: T?
    public let errors: ServerErrorPayload?

    public init(
        status: Int? = 200,
        message: String? = nil,
        data: T? = nil,
        errors: ServerErrorPayload? = nil
    ) {
        self.status = status
        self.message = message
        self.data = data
        self.errors = errors
    }
}
