//
//  AppContainer.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import Foundation
import UIKit
import Networking
import Data

final class AppContainer {
    let appConfiguration: AppConfiguration
    let networkClient: NetworkClient
    public var preferenceStorage: PreferenceStorage
    public let keychainStorage: KeychainStorage
    public let sessionRepository: SessionRepository
    public let bootstrapRepository: BootstrapRepository
    public let faqRepository: FAQRepository
    public let categoriesRepository: CategoriesRepository
    public let productsRepository: ProductsRepository

    init(
        appConfiguration: AppConfiguration,
        preferenceStorage: PreferenceStorage = AppPreferenceStorage(),
        keychainStorage: KeychainStorage = SystemKeychainStorage(),
        sessionRepository: SessionRepository? = nil,
        bootstrapRepository: BootstrapRepository? = nil,
        faqRepository: FAQRepository? = nil,
        categoriesRepository: CategoriesRepository? = nil,
        productsRepository:ProductsRepository? = nil
    ) {
        self.preferenceStorage = preferenceStorage
        self.keychainStorage = keychainStorage
        if preferenceStorage.isFirstRun {
            try? keychainStorage.wipeAll()
            self.preferenceStorage.isFirstRun = false
        }
        
        self.appConfiguration = appConfiguration

        let resolvedSession = sessionRepository ?? AppSessionRepository(keychainStorage: self.keychainStorage)
        self.sessionRepository = resolvedSession

        let userAgent = UserAgent.current(
            deviceId: UIDevice.current.identifierForVendor?.uuidString ?? preferenceStorage.deviceID
        )

        let requestBuilder = RequestBuilder(
            APIConfiguration(
                baseURL: appConfiguration.baseURL,
                apiVersion: appConfiguration.apiVersion,
                accountId: appConfiguration.accountID,
                secretKey: appConfiguration.secretKey
            ),
            userAgent: userAgent
        )

        let client = NetworkClient(
            builder: requestBuilder,
            languageSupplier: {
                preferenceStorage.selectedLanguage
            },
            tokenSupplier: {
                resolvedSession.token
            },
            deviceIDSupplier: {
                preferenceStorage.deviceID
            }
        )
        self.networkClient = client

        self.bootstrapRepository = bootstrapRepository ?? AppBootstrapRepository(
            networkClient: client
        )

        self.faqRepository = faqRepository ?? AppFAQRepository(
            networkingClient: client
        )
        self.categoriesRepository = categoriesRepository ?? AppCategoriesRepository(
            bootstrapRepository: self.bootstrapRepository
        )
        
        self.productsRepository = productsRepository ?? AppProductsRepository(
            client: client
        )
    }
}
