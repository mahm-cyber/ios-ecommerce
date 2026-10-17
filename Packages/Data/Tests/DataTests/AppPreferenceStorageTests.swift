//
//  AppPreferenceStorageTests.swift
//  Data
//
//  Created by mahmoud on 17/10/2026.
//

import Foundation
import Testing
@testable import Data

struct AppPreferenceStorageTests {

    private func makeCleanDefaults(name: String = #function) -> UserDefaults {
        let suiteName = "AppPreferenceStorageTests-\(name)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }

    @Test
    func isFirstRunDefaultsToTrue() {
        let defaults = makeCleanDefaults()
        let storage = AppPreferenceStorage(userDefaults: defaults)

        #expect(storage.isFirstRun == true)
    }

    @Test
    func isFirstRunPersistsValue() {
        let defaults = makeCleanDefaults()
        var storage = AppPreferenceStorage(userDefaults: defaults)

        storage.isFirstRun = false
        #expect(storage.isFirstRun == false)

        // Read again through a new instance with the same defaults
        let freshInstance = AppPreferenceStorage(userDefaults: defaults)
        #expect(freshInstance.isFirstRun == false)
    }

    @Test
    func deviceIDGeneratesAndPersists() {
        let defaults = makeCleanDefaults()
        let storage = AppPreferenceStorage(userDefaults: defaults)

        let firstRead = storage.deviceID
        #expect(!firstRead.isEmpty)

        let secondRead = storage.deviceID
        #expect(firstRead == secondRead)

        // A new instance connected to the same defaults should read the exact same UUID
        let newInstance = AppPreferenceStorage(userDefaults: defaults)
        #expect(newInstance.deviceID == firstRead)
    }

    @Test
    func selectedLanguageDefaultsAndUpdates() {
        let defaults = makeCleanDefaults()
        var storage = AppPreferenceStorage(userDefaults: defaults)

        // Initial language should be supported
        let initialLang = storage.selectedLanguage
        #expect(initialLang == "ar" || initialLang == "en")

        // Update to english
        storage.selectedLanguage = "en"
        #expect(storage.selectedLanguage == "en")

        // Update to arabic
        storage.selectedLanguage = "ar"
        #expect(storage.selectedLanguage == "ar")
    }
}
