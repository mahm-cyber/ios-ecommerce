//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation
import Observation

@Observable
public final class AppSessionRepository: SessionRepository, @unchecked Sendable {
    public private(set) var state: SessionState

    public var token: String?  {
        get {
            switch state {
            case .unauthenticated:
                return nil
            case .authenticated(let token):
                return token
            }
        }
    }

    public func signIn(token: String) throws {
        try keychainStorage.save(key: "auth_token", string: token)
        state = .authenticated(token: token)
    }

    public func signOut() throws {
        try keychainStorage.delete(key: "auth_token")
        state = .unauthenticated
    }
    
    private let keychainStorage: KeychainStorage
    
    public init(keychainStorage: KeychainStorage) {
        self.keychainStorage = keychainStorage
        
        do {
            if let token = try  keychainStorage.readString(key: "auth_token") {
                state = .authenticated(token: token)
            } else {
                state = .unauthenticated
            }
        } catch {
            state = .unauthenticated
        }
    }
      

    
}
