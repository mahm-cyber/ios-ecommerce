//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation


public struct Info: Codable {
    let infosId: Int?
    let fKAccountsId: Int?
    let infosPhone1: String?
    let infosPhone2: String?
    let infosPhone3: String?
    let infosGps: String?
    let infosFacebook: String?
    let infosTwitter: String?
    let infosYoutube: String?
    let infosInstagram: String?
    let infosSnapchat: String?
    let infosWhatsapp: String?
    let infosFoursquare: String?
    let infosMessengerAccount: String?
    let infosCreatedAt: String?
    let infosUpdatedAt: String?
    let infosTelegram: String?
    let infosTiktok: String?
    let infosEmail: String?
    let infosLinkedin: String?
    let infosPinterest: String?
    let infosThreads: String?
    let infosAbout: String?
    let infosPrivacyPolicy: String?
    let infosReturnExchangePolicy: String?
    let infosTermsConditions: String?
    let infosContacts: String?

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
