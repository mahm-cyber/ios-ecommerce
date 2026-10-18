//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

public
struct Setting: Codable, Sendable {
    public let settingsId: Int?
    public let fKAccountsId: Int?
    public let settingsDefaultLanguage: String?
    public let allowBrowserLang: Int?
    public let settingsPaginationCount: Int?
    public let settingsPaginationCountDashboard: Int?
    public let durationNewlyArrivedProducts: Int?
    public let productCardImageHeightWeb: Int?
    public let productCardImageHeightMobile: Int?
    public let inactiveCustomerDays: Int?
    public let settingsDeliveryCost: Int?
    public let walletRegistrationBonus: String?
    public let cashbackValue: Int?
    public let allowCashbackOnDiscountedProducts: Int?
    public let allowCashbackOnCoupons: Int?
    public let packagingWeight: String?
    public let taxNumber: String?
    public let taxValue: String?
    public let commercialRecord: String?
    public let settingsMinOrder: String?
    public let stopOrder: Int?
    public let websiteStatus: Int?
    public let accountsEmail: String?
    public let schedulingTimeFrom: String?
    public let schedulingTimeTo: String?
    public let clientsCodeType: String?
    public let clientsCodeValue: String?
    public let clientsCodeLimit: String?
    public let clientsCodeAmount: String?
    public let robotTxt: String?
    public let llmsTxt: String?
    public let sitemap: String?
    public let maroofNo: String?
    public let vatFile: String?
    public let gtagsId: String?
    public let gtagsConversionSendTo: String?
    public let gtmId: String?
    public let clarityId: String?
    public let googleSiteVerification: String?
    public let facebookDomainVerification: String?
    public let snapPixelId: String?
    public let headScript: String?
    public let bodyScript: String?
    public let menuShowLang: String?
    public let addressFields: String?
    public let iosVersion: String?
    public let androidVersion: String?
    public let settingsCreatedAt: String?
    public let settingsUpdatedAt: String?
    public let showProductAssociationsInProductDetails: Int?
    public let showProductAssociationsInCart: Int?
    public let acceptReturnPolicy: Int?
    public let currencyDirection: String?
    public let settingsDeliveryCostNew: String?
    public let settingsCurrency: String?
    public let orderTimeMsg: String?
    public let stopOrderMsg: String?
    public let stopWebsiteMsg: String?
    public let homeProductsTitle: String?
    public let accountsName: String?
    public let cartNotes: String?
    public let contentScrollingBanner: [String?]?


    public init(
        settingsId: Int? = nil,
        fKAccountsId: Int? = nil,
        settingsDefaultLanguage: String? = nil,
        allowBrowserLang: Int? = nil,
        settingsPaginationCount: Int? = nil,
        settingsPaginationCountDashboard: Int? = nil,
        durationNewlyArrivedProducts: Int? = nil,
        productCardImageHeightWeb: Int? = nil,
        productCardImageHeightMobile: Int? = nil,
        inactiveCustomerDays: Int? = nil,
        settingsDeliveryCost: Int? = nil,
        walletRegistrationBonus: String? = nil,
        cashbackValue: Int? = nil,
        allowCashbackOnDiscountedProducts: Int? = nil,
        allowCashbackOnCoupons: Int? = nil,
        packagingWeight: String? = nil,
        taxNumber: String? = nil,
        taxValue: String? = nil,
        commercialRecord: String? = nil,
        settingsMinOrder: String? = nil,
        stopOrder: Int? = nil,
        websiteStatus: Int? = nil,
        accountsEmail: String? = nil,
        schedulingTimeFrom: String? = nil,
        schedulingTimeTo: String? = nil,
        clientsCodeType: String? = nil,
        clientsCodeValue: String? = nil,
        clientsCodeLimit: String? = nil,
        clientsCodeAmount: String? = nil,
        robotTxt: String? = nil,
        llmsTxt: String? = nil,
        sitemap: String? = nil,
        maroofNo: String? = nil,
        vatFile: String? = nil,
        gtagsId: String? = nil,
        gtagsConversionSendTo: String? = nil,
        gtmId: String? = nil,
        clarityId: String? = nil,
        googleSiteVerification: String? = nil,
        facebookDomainVerification: String? = nil,
        snapPixelId: String? = nil,
        headScript: String? = nil,
        bodyScript: String? = nil,
        menuShowLang: String? = nil,
        addressFields: String? = nil,
        iosVersion: String? = nil,
        androidVersion: String? = nil,
        settingsCreatedAt: String? = nil,
        settingsUpdatedAt: String? = nil,
        showProductAssociationsInProductDetails: Int? = nil,
        showProductAssociationsInCart: Int? = nil,
        acceptReturnPolicy: Int? = nil,
        currencyDirection: String? = nil,
        settingsDeliveryCostNew: String? = nil,
        settingsCurrency: String? = nil,
        orderTimeMsg: String? = nil,
        stopOrderMsg: String? = nil,
        stopWebsiteMsg: String? = nil,
        homeProductsTitle: String? = nil,
        accountsName: String? = nil,
        cartNotes: String? = nil,
        contentScrollingBanner: [String?]? = nil
    ) {
        self.settingsId = settingsId
        self.fKAccountsId = fKAccountsId
        self.settingsDefaultLanguage = settingsDefaultLanguage
        self.allowBrowserLang = allowBrowserLang
        self.settingsPaginationCount = settingsPaginationCount
        self.settingsPaginationCountDashboard = settingsPaginationCountDashboard
        self.durationNewlyArrivedProducts = durationNewlyArrivedProducts
        self.productCardImageHeightWeb = productCardImageHeightWeb
        self.productCardImageHeightMobile = productCardImageHeightMobile
        self.inactiveCustomerDays = inactiveCustomerDays
        self.settingsDeliveryCost = settingsDeliveryCost
        self.walletRegistrationBonus = walletRegistrationBonus
        self.cashbackValue = cashbackValue
        self.allowCashbackOnDiscountedProducts = allowCashbackOnDiscountedProducts
        self.allowCashbackOnCoupons = allowCashbackOnCoupons
        self.packagingWeight = packagingWeight
        self.taxNumber = taxNumber
        self.taxValue = taxValue
        self.commercialRecord = commercialRecord
        self.settingsMinOrder = settingsMinOrder
        self.stopOrder = stopOrder
        self.websiteStatus = websiteStatus
        self.accountsEmail = accountsEmail
        self.schedulingTimeFrom = schedulingTimeFrom
        self.schedulingTimeTo = schedulingTimeTo
        self.clientsCodeType = clientsCodeType
        self.clientsCodeValue = clientsCodeValue
        self.clientsCodeLimit = clientsCodeLimit
        self.clientsCodeAmount = clientsCodeAmount
        self.robotTxt = robotTxt
        self.llmsTxt = llmsTxt
        self.sitemap = sitemap
        self.maroofNo = maroofNo
        self.vatFile = vatFile
        self.gtagsId = gtagsId
        self.gtagsConversionSendTo = gtagsConversionSendTo
        self.gtmId = gtmId
        self.clarityId = clarityId
        self.googleSiteVerification = googleSiteVerification
        self.facebookDomainVerification = facebookDomainVerification
        self.snapPixelId = snapPixelId
        self.headScript = headScript
        self.bodyScript = bodyScript
        self.menuShowLang = menuShowLang
        self.addressFields = addressFields
        self.iosVersion = iosVersion
        self.androidVersion = androidVersion
        self.settingsCreatedAt = settingsCreatedAt
        self.settingsUpdatedAt = settingsUpdatedAt
        self.showProductAssociationsInProductDetails = showProductAssociationsInProductDetails
        self.showProductAssociationsInCart = showProductAssociationsInCart
        self.acceptReturnPolicy = acceptReturnPolicy
        self.currencyDirection = currencyDirection
        self.settingsDeliveryCostNew = settingsDeliveryCostNew
        self.settingsCurrency = settingsCurrency
        self.orderTimeMsg = orderTimeMsg
        self.stopOrderMsg = stopOrderMsg
        self.stopWebsiteMsg = stopWebsiteMsg
        self.homeProductsTitle = homeProductsTitle
        self.accountsName = accountsName
        self.cartNotes = cartNotes
        self.contentScrollingBanner = contentScrollingBanner
    }

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
