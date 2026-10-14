//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public
struct Setting: Codable {
    let settingsId: Int?
    let fKAccountsId: Int?
    let settingsDefaultLanguage: String?
    let allowBrowserLang: Int?
    let settingsPaginationCount: Int?
    let settingsPaginationCountDashboard: Int?
    let durationNewlyArrivedProducts: Int?
    let productCardImageHeightWeb: Int?
    let productCardImageHeightMobile: Int?
    let inactiveCustomerDays: Int?
    let settingsDeliveryCost: Int?
    let walletRegistrationBonus: String?
    let cashbackValue: Int?
    let allowCashbackOnDiscountedProducts: Int?
    let allowCashbackOnCoupons: Int?
    let packagingWeight: String?
    let taxNumber: String?
    let taxValue: String?
    let commercialRecord: String?
    let settingsMinOrder: String?
    let stopOrder: Int?
    let websiteStatus: Int?
    let accountsEmail: String?
    let schedulingTimeFrom: String?
    let schedulingTimeTo: String?
    let clientsCodeType: String?
    let clientsCodeValue: String?
    let clientsCodeLimit: String?
    let clientsCodeAmount: String?
    let robotTxt: String?
    let llmsTxt: String?
    let sitemap: String?
    let maroofNo: String?
    let vatFile: String?
    let gtagsId: String?
    let gtagsConversionSendTo: String?
    let gtmId: String?
    let clarityId: String?
    let googleSiteVerification: String?
    let facebookDomainVerification: String?
    let snapPixelId: String?
    let headScript: String?
    let bodyScript: String?
    let menuShowLang: String?
    let addressFields: String?
    let iosVersion: String?
    let androidVersion: String?
    let settingsCreatedAt: String?
    let settingsUpdatedAt: String?
    let showProductAssociationsInProductDetails: Int?
    let showProductAssociationsInCart: Int?
    let acceptReturnPolicy: Int?
    let currencyDirection: String?
    let settingsDeliveryCostNew: String?
    let settingsCurrency: String?
    let orderTimeMsg: String?
    let stopOrderMsg: String?
    let stopWebsiteMsg: String?
    let homeProductsTitle: String?
    let accountsName: String?
    let cartNotes: String?
    let contentScrollingBanner: [String?]

    enum CodingKeys: String, CodingKey {
        case settingsId = "settings_id"
        case fKAccountsId = "FK_accounts_id"
        case settingsDefaultLanguage = "settings_default_language"
        case allowBrowserLang = "allow_browser_lang"
        case settingsPaginationCount = "settings_pagination_count"
        case settingsPaginationCountDashboard = "settings_pagination_count_dashboard"
        case durationNewlyArrivedProducts = "duration_newly_arrived_products"
        case productCardImageHeightWeb = "product_card_image_height_web"
        case productCardImageHeightMobile = "product_card_image_height_mobile"
        case inactiveCustomerDays = "inactive_customer_days"
        case settingsDeliveryCost = "settings_delivery_cost"
        case walletRegistrationBonus = "wallet_registration_bonus"
        case cashbackValue = "cashback_value"
        case allowCashbackOnDiscountedProducts = "allow_cashback_on_discounted_products"
        case allowCashbackOnCoupons = "allow_cashback_on_coupons"
        case packagingWeight = "packaging_weight"
        case taxNumber = "tax_number"
        case taxValue = "tax_value"
        case commercialRecord = "commercial_record"
        case settingsMinOrder = "settings_min_order"
        case stopOrder = "stop_order"
        case websiteStatus = "website_status"
        case accountsEmail = "accounts_email"
        case schedulingTimeFrom = "scheduling_time_from"
        case schedulingTimeTo = "scheduling_time_to"
        case clientsCodeType = "clients_code_type"
        case clientsCodeValue = "clients_code_value"
        case clientsCodeLimit = "clients_code_limit"
        case clientsCodeAmount = "clients_code_amount"
        case robotTxt
        case llmsTxt
        case sitemap
        case maroofNo = "maroof_no"
        case vatFile = "vat_file"
        case gtagsId = "gtags_id"
        case gtagsConversionSendTo = "gtags_conversion_send_to"
        case gtmId = "gtm_id"
        case clarityId = "clarity_id"
        case googleSiteVerification = "google_site_verification"
        case facebookDomainVerification = "facebook_domain_verification"
        case snapPixelId = "snap_pixel_id"
        case headScript = "head_script"
        case bodyScript = "body_script"
        case menuShowLang = "menu_show_lang"
        case addressFields = "address_fields"
        case iosVersion = "ios_version"
        case androidVersion = "android_version"
        case settingsCreatedAt = "settings_created_at"
        case settingsUpdatedAt = "settings_updated_at"
        case showProductAssociationsInProductDetails = "show_product_associations_in_product_details"
        case showProductAssociationsInCart = "show_product_associations_in_cart"
        case acceptReturnPolicy = "accept_return_policy"
        case currencyDirection = "currency_direction"
        case settingsDeliveryCostNew = "settings_delivery_cost_new"
        case settingsCurrency = "settings_currency"
        case orderTimeMsg = "order_time_msg"
        case stopOrderMsg = "stop_order_msg"
        case stopWebsiteMsg = "stop_website_msg"
        case homeProductsTitle = "home_products_title"
        case accountsName = "accounts_name"
        case cartNotes = "cart_notes"
        case contentScrollingBanner = "content_scrolling_banner"
    }
}
