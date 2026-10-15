//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public
struct HomeSettings: Codable, Sendable{
    let homeSettingsId: Int?
    let fKAccountsId: Int?
    let homeSettingsDevice: String?
    let homeSettingsKey: String?
    let homeSettingsStatus: String?
    let homeSettingsPosition: Int?
    let homeSettingsCreatedAt: String?
    let homeSettingsUpdatedAt: String?
    let homeSettingsTitle: String?
    let homeSettingsSubTitle: String?
    let staticPage: String?

    enum CodingKeys: String, CodingKey {
        case homeSettingsId = "home_settings_id"
        case fKAccountsId = "FK_accounts_id"
        case homeSettingsDevice = "home_settings_device"
        case homeSettingsKey = "home_settings_key"
        case homeSettingsStatus = "home_settings_status"
        case homeSettingsPosition = "home_settings_position"
        case homeSettingsCreatedAt = "home_settings_created_at"
        case homeSettingsUpdatedAt = "home_settings_updated_at"
        case homeSettingsTitle = "home_settings_title"
        case homeSettingsSubTitle = "home_settings_sub_title"
        case staticPage = "static_page"
    }
}
