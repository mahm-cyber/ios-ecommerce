//
//  AppContainerTests.swift
//  IOS EcommerceTests
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation
import Testing
import Data
@testable import IOS_Ecommerce

// MARK: - Test Doubles

private final class InMemoryPreferenceStorage: PreferenceStorage, @unchecked Sendable {
    var isFirstRun: Bool
    var deviceID: String
    var selectedLanguage: String

    init(
        isFirstRun: Bool = true,
        deviceID: String = "test-device-uuid",
        selectedLanguage: String = "ar"
    ) {
        self.isFirstRun = isFirstRun
        self.deviceID = deviceID
        self.selectedLanguage = selectedLanguage
    }
}

private final class InMemoryKeychainStorage: KeychainStorage, @unchecked Sendable {
    var storage: [String: Data] = [:]

    func save(key: String, data: Data) throws {
        storage[key] = data
    }

    func read(key: String) throws -> Data? {
        storage[key]
    }

    func delete(key: String) throws {
        storage.removeValue(forKey: key)
    }

    func wipeAll() throws {
        storage.removeAll()
    }
}

// MARK: - AppContainerTests

struct AppContainerTests {

    @Test
    func firstRunWipesKeychainAndSetsFlagToFalse() throws {
        // Arrange: isFirstRun is true and Keychain holds a leftover token from a previous installation
        let prefs = InMemoryPreferenceStorage(isFirstRun: true)
        let keychain = InMemoryKeychainStorage()
        try keychain.save(key: "auth_token", string: "stale_token_from_old_install")

        // Act: Container initializes on fresh app launch
        let container = AppContainer(
            appConfiguration: .sample,
            preferenceStorage: prefs,
            keychainStorage: keychain
        )

        // Assert:
        // 1. Stale token in Keychain must be wiped
        #expect(try keychain.readString(key: "auth_token") == nil)
        // 2. isFirstRun must now be flipped to false
        #expect(container.preferenceStorage.isFirstRun == false)
        #expect(prefs.isFirstRun == false)
    }

    @Test
    func subsequentRunPreservesKeychainTokens() throws {
        // Arrange: User has already launched the app before (isFirstRun == false) and is logged in
        let prefs = InMemoryPreferenceStorage(isFirstRun: false)
        let keychain = InMemoryKeychainStorage()
        try keychain.save(key: "auth_token", string: "active_user_token_abc")

        // Act: Container initializes on normal app launch
        let container = AppContainer(
            appConfiguration: .sample,
            preferenceStorage: prefs,
            keychainStorage: keychain
        )

        // Assert:
        // 1. Keychain token must NOT be wiped
        #expect(try keychain.readString(key: "auth_token") == "active_user_token_abc")
        // 2. isFirstRun remains false
        #expect(container.preferenceStorage.isFirstRun == false)
    }

    @Test
    func sessionSuppliersReadLiveStorageValues() throws {
        // Arrange
        let prefs = InMemoryPreferenceStorage(
            isFirstRun: false,
            deviceID: "custom-device-id",
            selectedLanguage: "en"
        )
        let keychain = InMemoryKeychainStorage()
        try keychain.save(key: "auth_token", string: "bearer_xyz")

        // Act
        let container = AppContainer(
            appConfiguration: .sample,
            preferenceStorage: prefs,
            keychainStorage: keychain
        )

        // Assert: Storage values are live and wired
        #expect(container.preferenceStorage.selectedLanguage == "en")
        #expect(container.preferenceStorage.deviceID == "custom-device-id")
        #expect(try container.keychainStorage.readString(key: "auth_token") == "bearer_xyz")
    }
}
