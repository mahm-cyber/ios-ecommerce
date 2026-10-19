//
//  BootstrapRepositoryTests.swift
//  DataTests
//
//  Created by NamaaIT Apple3 on 19/10/2026.
//

import Foundation
import Testing
import Core
import Networking
@testable import Data

struct BootstrapRepositoryTests {

    private func makeClient(transport: HTTPTransport) -> NetworkClient {
        let config = APIConfiguration(
            baseURL: URL(string: "https://example.com")!,
            apiVersion: "v006",
            accountId: "28",
            secretKey: "test_key"
        )
        let builder = RequestBuilder(config)
        return NetworkClient(
            builder: builder,
            transport: transport,
            languageSupplier: { "ar" },
            tokenSupplier: { nil },
            deviceIDSupplier: { "test-device-uuid" }
        )
    }

    private func makeInitialJSON(
        websiteStatus: Int = 1,
        stopWebsiteMsg: String? = nil,
        stopOrder: Int = 0,
        stopOrderMsg: String? = nil,
        currency: String = "SAR",
        currencyDirection: String = "right",
        themeName: String = "theme4",
        primaryColorHex: String = "#FF5500",
        logoURL: String = "https://example.com/logo.png",
        iosVersion: String = "1.0.0",
        defaultLanguage: String = "ar"
    ) -> Data {
        let stopWebsiteMsgJson = stopWebsiteMsg != nil ? "\"\(stopWebsiteMsg!)\"" : "null"
        let stopOrderMsgJson = stopOrderMsg != nil ? "\"\(stopOrderMsg!)\"" : "null"

        let json = """
        {
            "status": 200,
            "message": "Success",
            "data": {
                "setting": {
                    "website_status": \(websiteStatus),
                    "stop_website_msg": \(stopWebsiteMsgJson),
                    "stop_order": \(stopOrder),
                    "stop_order_msg": \(stopOrderMsgJson),
                    "settings_currency": "\(currency)",
                    "currency_direction": "\(currencyDirection)",
                    "ios_version": "\(iosVersion)",
                    "settings_default_language": "\(defaultLanguage)"
                },
                "account": {
                    "accounts_app_theme": "\(themeName)",
                    "accounts_img_rtl": "\(logoURL)",
                    "mobile_app_colors": {
                        "accounts_colors_background_1": "\(primaryColorHex)"
                    }
                }
            }
        }
        """
        return Data(json.utf8)
    }

    @Test
    func initialStateIsIdle() {
        let client = makeClient(transport: TestTransport.returning())
        let repository = AppBootstrapRepository(networkClient: client)

        #expect(repository.state == .idle)
    }

    @Test
    func loadActiveStoreSucceeds() async throws {
        let json = makeInitialJSON(websiteStatus: 1, stopOrder: 0, currency: "SAR", currencyDirection: "right")
        let client = makeClient(transport: TestTransport.returning(statusCode: 200, data: json))
        let repository = AppBootstrapRepository(networkClient: client)

        try await repository.load()

        let expectedData = BootstrapData(
            storeStatus: .active,
            currency: CurrencyConfig(code: "SAR", isLeading: false),
            theme: ThemeConfig(themeName: "theme4", primaryColorHex: "#FF5500", logoURL: "https://example.com/logo.png"),
            minIosVersion: "1.0.0",
            defaultLanguage: "ar"
        )

        #expect(repository.state == .loaded(expectedData))
    }

    @Test
    func loadMaintenanceStoreSetsMaintenanceStatus() async throws {
        let json = makeInitialJSON(websiteStatus: 0, stopWebsiteMsg: "Under maintenance until 6 PM")
        let client = makeClient(transport: TestTransport.returning(statusCode: 200, data: json))
        let repository = AppBootstrapRepository(networkClient: client)

        try await repository.load()

        if case .loaded(let data) = repository.state {
            #expect(data.storeStatus == .maintenance(message: "Under maintenance until 6 PM"))
        } else {
            Issue.record("Expected .loaded state, got \(repository.state)")
        }
    }

    @Test
    func loadOrdersDisabledStoreSetsOrdersDisabledStatus() async throws {
        let json = makeInitialJSON(websiteStatus: 1, stopOrder: 1, stopOrderMsg: "Store busy")
        let client = makeClient(transport: TestTransport.returning(statusCode: 200, data: json))
        let repository = AppBootstrapRepository(networkClient: client)

        try await repository.load()

        if case .loaded(let data) = repository.state {
            #expect(data.storeStatus == .ordersDisabled(message: "Store busy"))
        } else {
            Issue.record("Expected .loaded state, got \(repository.state)")
        }
    }

    @Test
    func currencyLeadingDirectionResolvesTrueWhenLeft() async throws {
        let json = makeInitialJSON(currency: "USD", currencyDirection: "left")
        let client = makeClient(transport: TestTransport.returning(statusCode: 200, data: json))
        let repository = AppBootstrapRepository(networkClient: client)

        try await repository.load()

        if case .loaded(let data) = repository.state {
            #expect(data.currency.isLeading == true)
            #expect(data.currency.code == "USD")
        } else {
            Issue.record("Expected .loaded state, got \(repository.state)")
        }
    }

    @Test
    func loadFailureSetsFailedStateAndThrows() async {
        let client = makeClient(transport: TestTransport { _ in
            throw URLError(.notConnectedToInternet)
        })
        let repository = AppBootstrapRepository(networkClient: client)

        await #expect(throws: NetworkError.self) {
            try await repository.load()
        }

        #expect(repository.state == .failed(.noInternet))
    }
}
