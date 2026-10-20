//
//  RequestBuilderTests.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 15/10/2026.
//

import Testing
import Foundation
@testable import Networking

struct RequestBuilderTests {

    private func makeBuilder(
        baseURLString: String = "https://example.com",
        accountId: String = "27",
        secretKey: String = "test_secret",
        userAgent: String? = "PolarisMax-iOS"
    ) -> RequestBuilder {
        let config = APIConfiguration(
            baseURL: URL(string: baseURLString)!,
            apiVersion: "v006",
            accountId: accountId,
            secretKey: secretKey
        )
        return RequestBuilder(config, userAgent: userAgent)
    }

    // MARK: - URL Construction & Language

    @Test(arguments: ["en", "ar", "de"])
    func languageChangesSuccess(language: String) throws {
        let builder = makeBuilder()
        let request = try builder.buildURLRequest(for: .initial, language: language)
        let urlString = request.url?.absoluteString ?? ""

        #expect(urlString.contains("/\(language)/api/v006/initial"))
    }

    @Test
    func baseURLNormalization() throws {
        let builderWithoutSlash = makeBuilder(baseURLString: "https://example.com")
        let builderWithSlash = makeBuilder(baseURLString: "https://example.com/")

        let requestWithoutSlash = try builderWithoutSlash.buildURLRequest(
            for: .initial,
            language: "en"
        )
        let requestWithSlash = try builderWithSlash.buildURLRequest(
            for: .initial,
            language: "en"
        )

        #expect(requestWithSlash.url == requestWithoutSlash.url)
        #expect(requestWithSlash.url?.absoluteString.contains("//en") == false)
    }

    // MARK: - Fixed Headers

    @Test
    func fixedHeadersAreAlwaysPresent() throws {
        let builder = makeBuilder(secretKey: "my_secret_key")
        let request = try builder.buildURLRequest(for: .initial, language: "en")

        #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
        #expect(request.value(forHTTPHeaderField: "Secretkey") == "my_secret_key")
        #expect(request.value(forHTTPHeaderField: "User-Agent") == "PolarisMax-iOS")
        #expect(request.value(forHTTPHeaderField: "X-Requested-With") == "XMLHttpRequest")
    }

    @Test
    func customUserAgentIsApplied() throws {
        let builder = makeBuilder(userAgent: "Custom-UA-123")
        let request = try builder.buildURLRequest(for: .initial, language: "en")
        #expect(request.value(forHTTPHeaderField: "User-Agent") == "Custom-UA-123")
    }

    @Test
    func defaultUserAgentIsAppliedWhenNil() throws {
        let config = APIConfiguration(
            baseURL: URL(string: "https://example.com")!,
            apiVersion: "v006",
            accountId: "27",
            secretKey: "test_secret"
        )
        let builder = RequestBuilder(config)
        let request = try builder.buildURLRequest(for: .initial, language: "en")
        #if canImport(UIKit)
        #expect(request.value(forHTTPHeaderField: "User-Agent")?.contains("FlutterApp/") == true)
        #expect(request.value(forHTTPHeaderField: "User-Agent")?.contains("DeviceId/") == true)
        #else
        #expect(request.value(forHTTPHeaderField: "User-Agent") == "PolarisMax-iOS")
        #endif
    }

    // MARK: - Conditional Headers

    @Test
    func authorizationHeaderBehavior() throws {
        let builder = makeBuilder()

        let requestWithToken = try builder.buildURLRequest(
            for: .initial,
            language: "en",
            token: "valid_token_123"
        )
        #expect(requestWithToken.value(forHTTPHeaderField: "Authorization") == "Bearer valid_token_123")

        let requestWithoutToken = try builder.buildURLRequest(
            for: .initial,
            language: "en",
            token: nil
        )
        #expect(requestWithoutToken.value(forHTTPHeaderField: "Authorization") == nil)

        let requestWithEmptyToken = try builder.buildURLRequest(
            for: .initial,
            language: "en",
            token: ""
        )
        #expect(requestWithEmptyToken.value(forHTTPHeaderField: "Authorization") == nil)
    }

    @Test
    func deviceTokenHeaderBehavior() throws {
        let builder = makeBuilder()

        let requestWithDeviceID = try builder.buildURLRequest(
            for: .initial,
            language: "en",
            deviceID: "device_uuid_999"
        )
        #expect(requestWithDeviceID.value(forHTTPHeaderField: "device_token") == "device_uuid_999")

        let requestWithoutDeviceID = try builder.buildURLRequest(
            for: .initial,
            language: "en",
            deviceID: nil
        )
        #expect(requestWithoutDeviceID.value(forHTTPHeaderField: "device_token") == nil)

        let requestWithEmptyDeviceID = try builder.buildURLRequest(
            for: .initial,
            language: "en",
            deviceID: ""
        )
        #expect(requestWithEmptyDeviceID.value(forHTTPHeaderField: "device_token") == nil)
    }

    // MARK: - Query Parameters

    @Test
    func getRequestCarriesAccountId() throws {
        let builder = makeBuilder(accountId: "42")
        let request = try builder.buildURLRequest(for: .initial, language: "en")

        let queryString = request.url?.query() ?? ""
        #expect(queryString.contains("accountId=42"))
    }

    @Test
    func getRequestPreservesEndpointQueries() throws {
        let builder = makeBuilder(accountId: "42")
        let pagedEndpoint = Endpoint<InitialData>(
            path: "initial",
            method: .get,
            queries: [URLQueryItem(name: "page", value: "3")]
        )
        let request = try builder.buildURLRequest(for: pagedEndpoint, language: "en")

        let queryString = request.url?.query() ?? ""
        #expect(queryString.contains("page=3"))
        #expect(queryString.contains("accountId=42"))
    }

    @Test
    func postRequestDoesNotCarryAccountId() throws {
        let builder = makeBuilder(accountId: "42")
        let postEndpoint = Endpoint<InitialData>(
            path: "checkout",
            method: .post
        )
        let request = try builder.buildURLRequest(for: postEndpoint, language: "en")

        let queryString = request.url?.query() ?? ""
        #expect(queryString.contains("accountId") == false)
    }

    // MARK: - Timeout

    @Test
    func timeoutIntervalIs30Seconds() throws {
        let builder = makeBuilder()
        let request = try builder.buildURLRequest(for: .initial, language: "en")

        #expect(request.timeoutInterval == 30.0)
    }
}
