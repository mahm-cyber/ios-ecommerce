//
//  MobileColors.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public struct MobileAppColors: Codable, Sendable {
    public let accountsColorsId: Int?
    public let fKAccountsId: Int?
    public let accountsColorsType: String?
    public let accountsColorsBackground1: String?
    public let accountsColorsBackground2: String?
    public let accountsColorsBackground3: String?
    public let accountsColorsBackground4: String?
    public let accountsColorsBackground5: String?
    public let accountsColorsBackground6: String?
    public let accountsColorsBackground7: String?
    public let accountsColorsBackground8: String?
    public let accountsColorsText1: String?
    public let accountsColorsText2: String?
    public let accountsColorsText3: String?
    public let accountsColorsText4: String?
    public let accountsColorsText5: String?
    public let accountsColorsText6: String?
    public let accountsColorsText7: String?
    public let accountsColorsBorder1: String?
    public let accountsColorsBorder2: String?
    public let accountsColorsShadow1: String?
    public let accountsColorsShadow2: String?

    public init(
        accountsColorsId: Int? = nil,
        fKAccountsId: Int? = nil,
        accountsColorsType: String? = nil,
        accountsColorsBackground1: String? = nil,
        accountsColorsBackground2: String? = nil,
        accountsColorsBackground3: String? = nil,
        accountsColorsBackground4: String? = nil,
        accountsColorsBackground5: String? = nil,
        accountsColorsBackground6: String? = nil,
        accountsColorsBackground7: String? = nil,
        accountsColorsBackground8: String? = nil,
        accountsColorsText1: String? = nil,
        accountsColorsText2: String? = nil,
        accountsColorsText3: String? = nil,
        accountsColorsText4: String? = nil,
        accountsColorsText5: String? = nil,
        accountsColorsText6: String? = nil,
        accountsColorsText7: String? = nil,
        accountsColorsBorder1: String? = nil,
        accountsColorsBorder2: String? = nil,
        accountsColorsShadow1: String? = nil,
        accountsColorsShadow2: String? = nil
    ) {
        self.accountsColorsId = accountsColorsId
        self.fKAccountsId = fKAccountsId
        self.accountsColorsType = accountsColorsType
        self.accountsColorsBackground1 = accountsColorsBackground1
        self.accountsColorsBackground2 = accountsColorsBackground2
        self.accountsColorsBackground3 = accountsColorsBackground3
        self.accountsColorsBackground4 = accountsColorsBackground4
        self.accountsColorsBackground5 = accountsColorsBackground5
        self.accountsColorsBackground6 = accountsColorsBackground6
        self.accountsColorsBackground7 = accountsColorsBackground7
        self.accountsColorsBackground8 = accountsColorsBackground8
        self.accountsColorsText1 = accountsColorsText1
        self.accountsColorsText2 = accountsColorsText2
        self.accountsColorsText3 = accountsColorsText3
        self.accountsColorsText4 = accountsColorsText4
        self.accountsColorsText5 = accountsColorsText5
        self.accountsColorsText6 = accountsColorsText6
        self.accountsColorsText7 = accountsColorsText7
        self.accountsColorsBorder1 = accountsColorsBorder1
        self.accountsColorsBorder2 = accountsColorsBorder2
        self.accountsColorsShadow1 = accountsColorsShadow1
        self.accountsColorsShadow2 = accountsColorsShadow2
    }

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
