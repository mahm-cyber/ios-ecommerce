//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public struct HomeSettings: Codable, Sendable {
    public let homeSettingsId: Int?
    public let fKAccountsId: Int?
    public let homeSettingsDevice: String?
    public let homeSettingsKey: String?
    public let homeSettingsStatus: String?
    public let homeSettingsPosition: Int?
    public let homeSettingsCreatedAt: String?
    public let homeSettingsUpdatedAt: String?
    public let homeSettingsTitle: String?
    public let homeSettingsSubTitle: String?
    public let staticPage: StaticPage?

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
