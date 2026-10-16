//
//  File.swift
//  Networking
//
//  Created by mahmoud on 13/10/2026.
//

import Foundation


public enum NetworkError: Error, Sendable, Equatable {
    case serverError(statusCode: Int, message: String?)
    case invalidResponse
    case invalidURL
    case sessionExpired
    case noData
    case noInternet
    case timeout
}
