//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation


public enum SessionState: Equatable, Sendable {
    case unauthenticated
    case authenticated(token: String)
}
