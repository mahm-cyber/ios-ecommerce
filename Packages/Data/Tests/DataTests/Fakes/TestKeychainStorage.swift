//
//  TestKeychainStorage.swift
//  Data
//
//  Created by mahmoud on 17/10/2026.
//

import Foundation
import Data

public final class TestKeychainStorage: KeychainStorage, @unchecked Sendable {
    private let lock = NSLock()
    private var storage: [String: Data] = [:]

    public init(initialData: [String: Data] = [:]) {
        self.storage = initialData
    }

    public func save(key: String, data: Data) throws {
        lock.lock()
        defer { lock.unlock() }
        storage[key] = data
    }

    public func read(key: String) throws -> Data? {
        lock.lock()
        defer { lock.unlock() }
        return storage[key]
    }

    public func delete(key: String) throws {
        lock.lock()
        defer { lock.unlock() }
        storage.removeValue(forKey: key)
    }

    public func wipeAll() throws {
        lock.lock()
        defer { lock.unlock() }
        storage.removeAll()
    }
}
