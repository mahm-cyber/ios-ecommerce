//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation


public protocol SessionRepository: Sendable {
    var state: SessionState { get }
    var token: String? { get }
    func signIn(token: String ) throws
    func signOut() throws
}
