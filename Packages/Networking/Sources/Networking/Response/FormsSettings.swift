//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public
struct FormsSettingsFields: Codable, Sendable {
    let name: String?
    let type: String?
    let validation: String?
}


public
struct Names: Codable, Sendable {
    let name: String?
    let phone: String?
    let mail: String?
    let subject: String?
    let message: String?
}


public
struct Subject: Codable, Sendable {
    let inquiry: String?
    let complaint: String?
    let suggestion: String?
}


public
struct Options: Codable, Sendable {
    let subject: Subject?
}

public
struct FormsSettingsFieldsTrans: Codable, Sendable {
    let names: Names?
    let options: Options?
}

public
struct FormsSettings: Codable, Sendable {
    let formsSettingsId: Int?
    let fKAccountsId: Int?
    let formsSettingsFields: [FormsSettingsFields?]
    let formsSettingsType: String?
    let formsSettingsPosition: Int?
    let formsSettingsCreatedAt: String?
    let formsSettingsUpdatedAt: String?
    let formsSettingsName: String?
    let formsSettingsDesc: String?
    let formsSettingsFieldsTrans: FormsSettingsFieldsTrans?
    let formsSettingsSeoTitle: String?
    let formsSettingsSeoDesc: String?

    enum CodingKeys: String, CodingKey {
        case formsSettingsId = "forms_settings_id"
        case fKAccountsId = "FK_accounts_id"
        case formsSettingsFields = "forms_settings_fields"
        case formsSettingsType = "forms_settings_type"
        case formsSettingsPosition = "forms_settings_position"
        case formsSettingsCreatedAt = "forms_settings_created_at"
        case formsSettingsUpdatedAt = "forms_settings_updated_at"
        case formsSettingsName = "forms_settings_name"
        case formsSettingsDesc = "forms_settings_desc"
        case formsSettingsFieldsTrans = "forms_settings_fields_trans"
        case formsSettingsSeoTitle = "forms_settings_seo_title"
        case formsSettingsSeoDesc = "forms_settings_seo_desc"
    }
}
