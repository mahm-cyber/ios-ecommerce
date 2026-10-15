//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation


public struct InitialData: Codable, Sendable {
    let version: Int?
    let account: AccountData?
    let info: Info?
    let setting: Setting?
    let promotionalMessages: [PromotionalMessages?]
    let defaultLang: String?
    let payments: [Payments?]
    let categories: [Categories?]
    let offerMagazine: String?
    let haveBranch: Bool?
    let hasOffers: Bool?
    let formsSettings: [FormsSettings?]
    let homeSettings: [HomeSettings?]
    let allowedCountries: String?

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
