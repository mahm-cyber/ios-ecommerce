//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation


struct MobileAppColors: Codable {
    let accountsColorsId: Int?
    let fKAccountsId: Int?
    let accountsColorsType: String?
    let accountsColorsBackground1: String?
    let accountsColorsBackground2: String?
    let accountsColorsBackground3: String?
    let accountsColorsBackground4: String?
    let accountsColorsBackground5: String?
    let accountsColorsBackground6: String?
    let accountsColorsBackground7: String?
    let accountsColorsBackground8: String?
    let accountsColorsText1: String?
    let accountsColorsText2: String?
    let accountsColorsText3: String?
    let accountsColorsText4: String?
    let accountsColorsText5: String?
    let accountsColorsText6: String?
    let accountsColorsText7: String?
    let accountsColorsBorder1: String?
    let accountsColorsBorder2: String?
    let accountsColorsShadow1: String?
    let accountsColorsShadow2: String?

    enum CodingKeys: String, CodingKey {
        case accountsColorsId = "accounts_colors_id"
        case fKAccountsId = "FK_accounts_id"
        case accountsColorsType = "accounts_colors_type"
        case accountsColorsBackground1 = "accounts_colors_background_1"
        case accountsColorsBackground2 = "accounts_colors_background_2"
        case accountsColorsBackground3 = "accounts_colors_background_3"
        case accountsColorsBackground4 = "accounts_colors_background_4"
        case accountsColorsBackground5 = "accounts_colors_background_5"
        case accountsColorsBackground6 = "accounts_colors_background_6"
        case accountsColorsBackground7 = "accounts_colors_background_7"
        case accountsColorsBackground8 = "accounts_colors_background_8"
        case accountsColorsText1 = "accounts_colors_text_1"
        case accountsColorsText2 = "accounts_colors_text_2"
        case accountsColorsText3 = "accounts_colors_text_3"
        case accountsColorsText4 = "accounts_colors_text_4"
        case accountsColorsText5 = "accounts_colors_text_5"
        case accountsColorsText6 = "accounts_colors_text_6"
        case accountsColorsText7 = "accounts_colors_text_7"
        case accountsColorsBorder1 = "accounts_colors_border_1"
        case accountsColorsBorder2 = "accounts_colors_border_2"
        case accountsColorsShadow1 = "accounts_colors_shadow_1"
        case accountsColorsShadow2 = "accounts_colors_shadow_2"
    }
}
