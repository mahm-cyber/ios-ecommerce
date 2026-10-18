//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation


public struct Info: Codable, Sendable {
    public let infosId: Int?
    public let fKAccountsId: Int?
    public let infosPhone1: String?
    public let infosPhone2: String?
    public let infosPhone3: String?
    public let infosGps: String?
    public let infosFacebook: String?
    public let infosTwitter: String?
    public let infosYoutube: String?
    public let infosInstagram: String?
    public let infosSnapchat: String?
    public let infosWhatsapp: String?
    public let infosFoursquare: String?
    public let infosMessengerAccount: String?
    public let infosCreatedAt: String?
    public let infosUpdatedAt: String?
    public let infosTelegram: String?
    public let infosTiktok: String?
    public let infosEmail: String?
    public let infosLinkedin: String?
    public let infosPinterest: String?
    public let infosThreads: String?
    public let infosAbout: String?
    public let infosPrivacyPolicy: String?
    public let infosReturnExchangePolicy: String?
    public let infosTermsConditions: String?
    public let infosContacts: String?


    public init(
        infosId: Int? = nil,
        fKAccountsId: Int? = nil,
        infosPhone1: String? = nil,
        infosPhone2: String? = nil,
        infosPhone3: String? = nil,
        infosGps: String? = nil,
        infosFacebook: String? = nil,
        infosTwitter: String? = nil,
        infosYoutube: String? = nil,
        infosInstagram: String? = nil,
        infosSnapchat: String? = nil,
        infosWhatsapp: String? = nil,
        infosFoursquare: String? = nil,
        infosMessengerAccount: String? = nil,
        infosCreatedAt: String? = nil,
        infosUpdatedAt: String? = nil,
        infosTelegram: String? = nil,
        infosTiktok: String? = nil,
        infosEmail: String? = nil,
        infosLinkedin: String? = nil,
        infosPinterest: String? = nil,
        infosThreads: String? = nil,
        infosAbout: String? = nil,
        infosPrivacyPolicy: String? = nil,
        infosReturnExchangePolicy: String? = nil,
        infosTermsConditions: String? = nil,
        infosContacts: String? = nil
    ) {
        self.infosId = infosId
        self.fKAccountsId = fKAccountsId
        self.infosPhone1 = infosPhone1
        self.infosPhone2 = infosPhone2
        self.infosPhone3 = infosPhone3
        self.infosGps = infosGps
        self.infosFacebook = infosFacebook
        self.infosTwitter = infosTwitter
        self.infosYoutube = infosYoutube
        self.infosInstagram = infosInstagram
        self.infosSnapchat = infosSnapchat
        self.infosWhatsapp = infosWhatsapp
        self.infosFoursquare = infosFoursquare
        self.infosMessengerAccount = infosMessengerAccount
        self.infosCreatedAt = infosCreatedAt
        self.infosUpdatedAt = infosUpdatedAt
        self.infosTelegram = infosTelegram
        self.infosTiktok = infosTiktok
        self.infosEmail = infosEmail
        self.infosLinkedin = infosLinkedin
        self.infosPinterest = infosPinterest
        self.infosThreads = infosThreads
        self.infosAbout = infosAbout
        self.infosPrivacyPolicy = infosPrivacyPolicy
        self.infosReturnExchangePolicy = infosReturnExchangePolicy
        self.infosTermsConditions = infosTermsConditions
        self.infosContacts = infosContacts
    }

    enum CodingKeys: String, CodingKey {
        case infosId = "infos_id"
        case fKAccountsId = "FK_accounts_id"
        case infosPhone1 = "infos_phone1"
        case infosPhone2 = "infos_phone2"
        case infosPhone3 = "infos_phone3"
        case infosGps = "infos_gps"
        case infosFacebook = "infos_facebook"
        case infosTwitter = "infos_twitter"
        case infosYoutube = "infos_youtube"
        case infosInstagram = "infos_instagram"
        case infosSnapchat = "infos_snapchat"
        case infosWhatsapp = "infos_whatsapp"
        case infosFoursquare = "infos_foursquare"
        case infosMessengerAccount = "infos_messenger_account"
        case infosCreatedAt = "infos_created_at"
        case infosUpdatedAt = "infos_updated_at"
        case infosTelegram = "infos_telegram"
        case infosTiktok = "infos_tiktok"
        case infosEmail = "infos_email"
        case infosLinkedin = "infos_linkedin"
        case infosPinterest = "infos_pinterest"
        case infosThreads = "infos_threads"
        case infosAbout = "infos_about"
        case infosPrivacyPolicy = "infos_privacy_policy"
        case infosReturnExchangePolicy = "infos_return_exchange_policy"
        case infosTermsConditions = "infos_terms_conditions"
        case infosContacts = "infos_contacts"
    }
}
