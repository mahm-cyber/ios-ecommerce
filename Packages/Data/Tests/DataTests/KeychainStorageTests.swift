//
//  KeychainStorageTests.swift
//  Data
//
//  Created by mahmoud on 17/10/2026.
//

import Foundation
import Testing
@testable import Data

struct KeychainStorageTests {

    private func makeCleanStorage(name: String = #function) -> SystemKeychainStorage {
        let testService = "com.namaait.cuddluxe.tests.\(UUID().uuidString)"
        let storage = SystemKeychainStorage(service: testService)
        try? storage.wipeAll()
        return storage
    }

    @Test
    func saveAndReadData() throws {
        let storage = makeCleanStorage()
        defer { try? storage.wipeAll() }

        let testKey = "test_data_key"
        let testData = Data([0x01, 0x02, 0x03, 0x04])

        try storage.save(key: testKey, data: testData)
        let readData = try storage.read(key: testKey)

        #expect(readData == testData)
    }

    @Test
    func saveAndReadString() throws {
        let storage = makeCleanStorage()
        defer { try? storage.wipeAll() }

        let testKey = "test_auth_token"
        let token = "sample_bearer_token_xyz_123"

        try storage.save(key: testKey, string: token)
        let readToken = try storage.readString(key: testKey)

        #expect(readToken == token)
    }

    @Test
    func overwritingKeyUpdatesValue() throws {
        let storage = makeCleanStorage()
        defer { try? storage.wipeAll() }

        let testKey = "overwrite_key"

        try storage.save(key: testKey, string: "first_value")
        #expect(try storage.readString(key: testKey) == "first_value")

        try storage.save(key: testKey, string: "second_value")
        #expect(try storage.readString(key: testKey) == "second_value")
    }

    @Test
    func readNonexistentKeyReturnsNil() throws {
        let storage = makeCleanStorage()
        defer { try? storage.wipeAll() }

        let result = try storage.read(key: "non_existent_key_\(UUID().uuidString)")
        #expect(result == nil)
    }

    @Test
    func deleteRemovesKey() throws {
        let storage = makeCleanStorage()
        defer { try? storage.wipeAll() }

        let testKey = "to_delete_key"
        try storage.save(key: testKey, string: "some_data")

        try storage.delete(key: testKey)
        let afterDelete = try storage.read(key: testKey)
        #expect(afterDelete == nil)
    }

    @Test
    func deleteNonexistentKeyDoesNotThrow() throws {
        let storage = makeCleanStorage()
        defer { try? storage.wipeAll() }

        // Deleting a key that does not exist should be a no-op, not throw
        try storage.delete(key: "never_saved_key")
    }

    @Test
    func wipeAllRemovesAllKeys() throws {
        let storage = makeCleanStorage()
        defer { try? storage.wipeAll() }

        try storage.save(key: "key_one", string: "val_one")
        try storage.save(key: "key_two", string: "val_two")

        try storage.wipeAll()

        #expect(try storage.read(key: "key_one") == nil)
        #expect(try storage.read(key: "key_two") == nil)
    }
}
