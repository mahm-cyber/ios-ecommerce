//
//  InitialData.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public struct InitialData: Codable, Sendable {
    public let version: Int?
    public let account: AccountData?
    public let info: Info?
    public let setting: Setting?
    public let promotionalMessages: [PromotionalMessages?]?
    public let defaultLang: String?
    public let payments: [Payments?]?
    public let categories: [Categories?]?
    public let offerMagazine: String?
    public let haveBranch: Bool?
    public let hasOffers: Bool?
    public let formsSettings: [FormsSettings?]?
    public let homeSettings: [HomeSettings?]?
    public let allowedCountries: String?

    public init(
        version: Int? = nil,
        account: AccountData? = nil,
        info: Info? = nil,
        setting: Setting? = nil,
        promotionalMessages: [PromotionalMessages?]? = nil,
        defaultLang: String? = nil,
        payments: [Payments?]? = nil,
        categories: [Categories?]? = nil,
        offerMagazine: String? = nil,
        haveBranch: Bool? = nil,
        hasOffers: Bool? = nil,
        formsSettings: [FormsSettings?]? = nil,
        homeSettings: [HomeSettings?]? = nil,
        allowedCountries: String? = nil
    ) {
        self.version = version
        self.account = account
        self.info = info
        self.setting = setting
        self.promotionalMessages = promotionalMessages
        self.defaultLang = defaultLang
        self.payments = payments
        self.categories = categories
        self.offerMagazine = offerMagazine
        self.haveBranch = haveBranch
        self.hasOffers = hasOffers
        self.formsSettings = formsSettings
        self.homeSettings = homeSettings
        self.allowedCountries = allowedCountries
    }

    enum CodingKeys: String, CodingKey {
        case version
        case account
        case info
        case setting
        case promotionalMessages = "promotional_messages"
        case defaultLang
        case payments
        case categories
        case offerMagazine = "offer_magazine"
        case haveBranch
        case hasOffers = "has_offers"
        case formsSettings = "forms_settings"
        case homeSettings = "home_settings"
        case allowedCountries = "allowed_countries"
    }
}
