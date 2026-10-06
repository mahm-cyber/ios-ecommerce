//
//  AppConfiguration.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import Foundation
 

enum AppEnvironment: String, Sendable {
    case dev = "Dev"
    case prod = "Prod"
}

enum AppConfigurationError: Error, Equatable {
    case missingValue(key: String)
    case invalidEnvironment(value: String)
    case invalidURL(value: String)
}

struct AppConfiguration: Equatable, Sendable {
    let environment: AppEnvironment
    let baseURL: URL
    let apiVersion: String
    let accountID: String
    let brandSlug: String
    let secretKey: String
    
    static let sample = {
        do {
        let example =   try  AppConfiguration(
                dictionary: [
                    "API_VERSION" : "1.0.0",
                    "API_ACCOUNT_ID":"28",
                    "BRAND_SLUG": "cuddluxe",
                    "APP_ENVIRONMENT":"Dev",
                    "API_BASE_URL":"https://polaris-max.nmait.net/",
                    "API_SECRET_KEY":"EmptyKey",
                ]
            )
            return example
        } catch {
            fatalError("Can't Create a preview Sample")
        }
    }()

    init(dictionary: [String: Any]) throws {
        let environmentValue = try Self.string(for: .environment, in: dictionary)
        guard let environment = AppEnvironment(rawValue: environmentValue) else {
            throw AppConfigurationError.invalidEnvironment(value: environmentValue)
        }

        let urlValue = try Self.string(for: .baseURL, in: dictionary)
        guard let baseURL = URL(string: urlValue),
              baseURL.scheme == "https",
              baseURL.host() != nil
        else {
            throw AppConfigurationError.invalidURL(value: urlValue)
        }

        self.environment = environment
        self.baseURL = baseURL
        self.apiVersion = try Self.string(for: .apiVersion, in: dictionary)
        self.accountID = try Self.string(for: .accountID, in: dictionary)
        self.brandSlug = try Self.string(for: .brandSlug, in: dictionary)
        self.secretKey = try Self.string(for: .secretKey, in: dictionary)
    }

    static func fromMainBundle() throws -> AppConfiguration {
        try AppConfiguration(dictionary: Bundle.main.infoDictionary ?? [:])
    }

    private enum Key: String {
        case environment = "APP_ENVIRONMENT"
        case baseURL = "API_BASE_URL"
        case apiVersion = "API_VERSION"
        case accountID = "API_ACCOUNT_ID"
        case brandSlug = "BRAND_SLUG"
        case secretKey = "API_SECRET_KEY"
    }

    private static func string(for key: Key, in dictionary: [String: Any]) throws -> String {
        guard let value = dictionary[key.rawValue] as? String else {
            throw AppConfigurationError.missingValue(key: key.rawValue)
        }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            throw AppConfigurationError.missingValue(key: key.rawValue)
        }
        return trimmed
    }
}
