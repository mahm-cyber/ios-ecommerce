//
//  AppConfigurationTests.swift
//  IOS EcommerceTests
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import Foundation
import Testing
@testable import IOS_Ecommerce

struct AppConfigurationTests {

    let validDictionary: [String: Any] = [
        "APP_ENVIRONMENT": "Dev",
        "API_BASE_URL": "https://api.example.com/",
        "API_VERSION": "v001",
        "API_ACCOUNT_ID": "28",
        "BRAND_SLUG": "sample-brand",
        "API_SECRET_KEY": "sample-secret",
    ]

    // MARK: - Valid input

    @Test func validDictionaryLoadsEveryValue() throws {
        let configuration = try AppConfiguration(dictionary: validDictionary)

        #expect(configuration.environment == .dev)
        #expect(configuration.baseURL == URL(string: "https://api.example.com/"))
        #expect(configuration.apiVersion == "v001")
        #expect(configuration.accountID == "28")
        #expect(configuration.brandSlug == "sample-brand")
        #expect(configuration.secretKey == "sample-secret")
    }

    @Test func prodEnvironmentIsRecognised() throws {
        var dictionary = validDictionary
        dictionary["APP_ENVIRONMENT"] = "Prod"

        let configuration = try AppConfiguration(dictionary: dictionary)

        #expect(configuration.environment == .prod)
    }

    @Test func surroundingWhitespaceIsTrimmed() throws {
        var dictionary = validDictionary
        dictionary["API_VERSION"] = "  v001\n"

        let configuration = try AppConfiguration(dictionary: dictionary)

        #expect(configuration.apiVersion == "v001")
    }

    // MARK: - Missing values

    @Test(arguments: [
        "APP_ENVIRONMENT",
        "API_BASE_URL",
        "API_VERSION",
        "API_ACCOUNT_ID",
        "BRAND_SLUG",
        "API_SECRET_KEY",
    ])
    func absentKeyThrowsMissingValue(key: String) {
        var dictionary = validDictionary
        dictionary[key] = nil

        #expect(throws: AppConfigurationError.missingValue(key: key)) {
            try AppConfiguration(dictionary: dictionary)
        }
    }

    @Test func emptySecretThrowsMissingValue() {
        var dictionary = validDictionary
        dictionary["API_SECRET_KEY"] = ""

        #expect(throws: AppConfigurationError.missingValue(key: "API_SECRET_KEY")) {
            try AppConfiguration(dictionary: dictionary)
        }
    }

    @Test func whitespaceOnlyValueThrowsMissingValue() {
        var dictionary = validDictionary
        dictionary["API_VERSION"] = "   "

        #expect(throws: AppConfigurationError.missingValue(key: "API_VERSION")) {
            try AppConfiguration(dictionary: dictionary)
        }
    }

    @Test func nonStringValueThrowsMissingValue() {
        var dictionary = validDictionary
        dictionary["API_ACCOUNT_ID"] = 28

        #expect(throws: AppConfigurationError.missingValue(key: "API_ACCOUNT_ID")) {
            try AppConfiguration(dictionary: dictionary)
        }
    }

    // MARK: - Invalid values

    @Test func unknownEnvironmentThrowsInvalidEnvironment() {
        var dictionary = validDictionary
        dictionary["APP_ENVIRONMENT"] = "prod"

        #expect(throws: AppConfigurationError.invalidEnvironment(value: "prod")) {
            try AppConfiguration(dictionary: dictionary)
        }
    }

    @Test(arguments: [
        "https:",
        "https:///",
        "http://api.example.com/",
        "api.example.com",
    ])
    func malformedBaseURLThrowsInvalidURL(value: String) {
        var dictionary = validDictionary
        dictionary["API_BASE_URL"] = value

        #expect(throws: AppConfigurationError.invalidURL(value: value)) {
            try AppConfiguration(dictionary: dictionary)
        }
    }
}
