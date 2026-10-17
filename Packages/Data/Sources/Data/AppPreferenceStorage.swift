// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


public struct AppPreferenceStorage: PreferenceStorage, @unchecked Sendable {
    private let isFirstRunKey = "is_first_run"
    public var isFirstRun: Bool {
        get {
            if userDefaults.object(forKey: isFirstRunKey) == nil   {
                return true
            } else {
                return userDefaults.bool(forKey: isFirstRunKey)            }
        }

        set {

            userDefaults.set(newValue, forKey: isFirstRunKey)
        }
    }

    private let deviceIDKey = "device_id"

    public var deviceID: String {
        get {
            if  userDefaults.object(forKey: deviceIDKey) == nil {
                let uuid = UUID().uuidString

                userDefaults.set(uuid, forKey: deviceIDKey)
                return uuid
            } else {
                guard let deviceId = userDefaults.string(forKey: deviceIDKey) else {
                    return ""
                }
                return deviceId
            }
        }
    }

    private let selectedLanguageKey = "selected_language"
    public var selectedLanguage: String {
        get {
            if let savedLanguage = userDefaults.string(forKey: selectedLanguageKey) {
                return savedLanguage
            }

            let deviceLang = Locale.current.language.languageCode?.identifier ?? ""
            let supportedLanguages = ["ar", "en"]

            if supportedLanguages.contains(deviceLang) {
                return deviceLang
            }

            return "ar"
        }

        set {
            userDefaults.set(newValue, forKey: selectedLanguageKey)
        }
    }

    private let userDefaults: UserDefaults


    public init(userDefaults: UserDefaults = .standard) {
       self.userDefaults = userDefaults
    }


}
