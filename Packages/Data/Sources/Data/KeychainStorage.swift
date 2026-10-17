//
//  File.swift
//  Data
//
//  Created by mahmoud on 16/10/2026.
//

import Foundation


public protocol KeychainStorage: Sendable {

    func save(key: String, data: Data) throws
    func read(key: String) throws -> Data?
    func delete(key: String) throws
    func wipeAll() throws
}


public extension KeychainStorage {
    func save(key: String, string: String) throws {
       try  save(key: key, data: Data(string.utf8))
    }

    func readString(key: String) throws -> String? {

        if let data = try read(key: key) {
            let value = String(data: data, encoding: .utf8)
            return value
        } else {
            return nil
        }
    }
}
