//
//  TestPreferenceStorage.swift
//  Data
//
//  Created by mahmoud on 17/10/2026.
//

import Foundation
import Data

public final class TestPreferenceStorage: PreferenceStorage, @unchecked Sendable {
    private let lock = NSLock()
    private var _isFirstRun: Bool
    private var _deviceID: String
    private var _selectedLanguage: String

    public var isFirstRun: Bool {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _isFirstRun
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _isFirstRun = newValue
        }
    }

    public var deviceID: String {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _deviceID
        }
    }

    public var selectedLanguage: String {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _selectedLanguage
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _selectedLanguage = newValue
        }
    }

    public init(
        isFirstRun: Bool = true,
        deviceID: String = "test-device-uuid-1234",
        selectedLanguage: String = "ar"
    ) {
        self._isFirstRun = isFirstRun
        self._deviceID = deviceID
        self._selectedLanguage = selectedLanguage
    }
}
