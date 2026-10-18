//
//  AppContainer.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import Foundation
import Networking
import Data

final class AppContainer {
    let appConfiguration: AppConfiguration
    let networkClient: NetworkClient
    public var preferenceStorage: PreferenceStorage
    public let keychainStorage: KeychainStorage

    init(
        appConfiguration: AppConfiguration,
        preferenceStorage: PreferenceStorage = AppPreferenceStorage(),
        keychainStorage: KeychainStorage = SystemKeychainStorage()
    ) {
        self.preferenceStorage = preferenceStorage
        self.keychainStorage = keychainStorage
        if preferenceStorage.isFirstRun {
            try? keychainStorage.wipeAll()
            self.preferenceStorage.isFirstRun = false
        }
        
        self.appConfiguration = appConfiguration

        let requestBuilder = RequestBuilder(
            APIConfiguration(
                baseURL: appConfiguration.baseURL,
                apiVersion: appConfiguration.apiVersion,
                accountId: appConfiguration.accountID,
                secretKey: appConfiguration.secretKey
            )
        )

        self.networkClient = NetworkClient(
            builder: requestBuilder,
            languageSupplier: {
                preferenceStorage.selectedLanguage
            },
            tokenSupplier: {
                try? keychainStorage.readString(key: "auth_token")
            },
            deviceIDSupplier: {
                preferenceStorage.deviceID
            },
            
        )
    }
}
