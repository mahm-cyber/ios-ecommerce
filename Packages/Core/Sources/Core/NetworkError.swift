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
    case unknown
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverError(_, let message):
            return message ?? "An unexpected server error occurred."
        case .invalidResponse:
            return "Invalid server response."
        case .invalidURL:
            return "Invalid URL."
        case .sessionExpired:
            return "Session expired. Please sign in again."
        case .noData:
            return "No data received from the server."
        case .noInternet:
            return "No internet connection. Please check your network."
        case .timeout:
            return "Request timed out. Please try again."
        case .unknown:
            return "An unknown network error occurred."
        }
    }
}
