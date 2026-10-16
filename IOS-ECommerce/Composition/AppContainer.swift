//
//  AppContainer.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import Foundation
import Networking

final class AppContainer {
    let appConfiguration: AppConfiguration
    let networkClient: NetworkClient

    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration

        let requestBuilder = RequestBuilder(
            APIConfiguration(
                baseURL: appConfiguration.baseURL,
                apiVersion: appConfiguration.apiVersion,
                accountId: appConfiguration.accountID,
                secretKey: appConfiguration.secretKey
            )
        )

        self.networkClient = NetworkClient(builder: requestBuilder)
    }
}
