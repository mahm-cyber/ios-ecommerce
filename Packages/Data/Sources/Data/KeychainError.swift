//
//  File.swift
//  Data
//
//  Created by mahmoud on 16/10/2026.
//

import Foundation

public enum KeychainError: Error, Sendable, Equatable  {

    case unhandledError(status: OSStatus)
    case unexpectedData
}
