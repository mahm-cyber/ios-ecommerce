//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation


public struct AccountData: Codable, Sendable {
    public let accountsId: Int?
    public let accountsName: String?
    public let accountsSlug: String?
    public let accountsImgDashboard: String?
    public let accountsImgRtl: String?
    public let accountsImgLtr: String?
    public let accountsImgFavicon: String?
    public let accountsImgHeaderReverse: String?
    public let accountsShowBranches: String?
    public let accountsShowHierarchy: String?
    public let accountsShowAreas: String?
    public let accountsShowCoupons: String?
    public let accountsShowShippingMethods: String?
    public let accountsShowOrdersRatings: String?
    public let accountsSingleMenu: String?
    public let accountsCountry: String?
    public let accountsCountryCode: String?
    public let accountsMultipleCountries: String?
    public let accountsCountryMobileDigitsCount: Int?
    public let accountsTimezone: String?
    public let accountsCountryLatLong: String?
    public let accountsNoreplyEmail: String?
    public let accountsShowCalories: String?
    public let accountsShowProductType: String?
    public let accountsShowTestimonials: String?
    public let accountsShowQuestions: String?
    public let accountsShowPartners: String?
    public let accountsShowNews: String?
    public let accountsShowJobs: String?
    public let accountsShowArticles: String?
    public let accountsShowAlbums: String?
    public let accountsShowWallet: String?
    public let accountsShowLostSales: String?
    public let accountsShowPointsLevels: String?
    public let accountsShowChoices: String?
    public let accountsShowProductsNotifications: String?
    public let accountsShowProductsRatings: String?
    public let accountsShowProductsFiles: String?
    public let accountsShowProductDeliveryPeriod: String?
    public let accountsShowOffersMagazines: String?
    public let accountsShowBrands: String?
    public let accountsShowBrandPage: String?
    public let accountsShowOffers: String?
    public let accountsShowImportLogs: String?
    public let accountsShowStocks: String?
    public let accountsShowOrderShippings: String?
    public let accountsShowOrderReturnRequests: String?
    public let accountsShowPromotionalMessages: String?
    public let accountsShowPoints: String?
    public let accountsShowSimilarItems: String?
    public let accountsShowProductAssociations: String?
    public let accountsShowAttributes: String?
    public let accountsShowUploads: String?
    public let accountsShowDailyOffers: String?
    public let accountsShowHomeSettings: String?
    public let accountsShowAdvertisementsSettings: String?
    public let accountsMultiPriceForProduct: String?
    public let accountsMultiPayments: String?
    public let accountsOrdersScheduling: String?
    public let accountsOrdersPickup: String?
    public let accountsShowCashback: String?
    public let accountsShowOurClients: String?
    public let accountsOffersType: String?
    public let accountsShowBi: String?
    public let accountsFcmKey: String?
    public let accountsFcmApiKey: String?
    public let accountsFcmAuthDomain: String?
    public let accountsFcmDatabaseURL: String?
    public let accountsFcmProjectId: String?
    public let accountsFcmStorageBucket: String?
    public let accountsFcmMessagingSenderId: String?
    public let accountsFcmAppId: String?
    public let accountsFcmMeasurementId: String?
    public let accountsAndroidUrl: String?
    public let accountsIosUrl: String?
    public let accountsProductUrl: String?
    public let accountsGoogleMapKey: String?
    public let accountsWebsiteUrl: String?
    public let accountsNumberDecimalDigits: Int?
    public let accountsStatus: String?
    public let accountsPosition: Int?
    public let accountsWebServiceToken: String?
    public let accountsSocialLoginBtns: String?
    public let accountsShowRemoveAccount: String?
    public let accountsAppTheme: String?
    public let accountsAuthType: String?
    public let accountsCreatedAt: String?
    public let accountsUpdatedAt: String?
    public let accountsShowReels: String?
    public let productsTitle: String?
    public let mobileAppColors: MobileAppColors?


    public init(
        accountsId: Int? = nil,
        accountsName: String? = nil,
        accountsSlug: String? = nil,
        accountsImgDashboard: String? = nil,
        accountsImgRtl: String? = nil,
        accountsImgLtr: String? = nil,
        accountsImgFavicon: String? = nil,
        accountsImgHeaderReverse: String? = nil,
        accountsShowBranches: String? = nil,
        accountsShowHierarchy: String? = nil,
        accountsShowAreas: String? = nil,
        accountsShowCoupons: String? = nil,
        accountsShowShippingMethods: String? = nil,
        accountsShowOrdersRatings: String? = nil,
        accountsSingleMenu: String? = nil,
        accountsCountry: String? = nil,
        accountsCountryCode: String? = nil,
        accountsMultipleCountries: String? = nil,
        accountsCountryMobileDigitsCount: Int? = nil,
        accountsTimezone: String? = nil,
        accountsCountryLatLong: String? = nil,
        accountsNoreplyEmail: String? = nil,
        accountsShowCalories: String? = nil,
        accountsShowProductType: String? = nil,
        accountsShowTestimonials: String? = nil,
        accountsShowQuestions: String? = nil,
        accountsShowPartners: String? = nil,
        accountsShowNews: String? = nil,
        accountsShowJobs: String? = nil,
        accountsShowArticles: String? = nil,
        accountsShowAlbums: String? = nil,
        accountsShowWallet: String? = nil,
        accountsShowLostSales: String? = nil,
        accountsShowPointsLevels: String? = nil,
        accountsShowChoices: String? = nil,
        accountsShowProductsNotifications: String? = nil,
        accountsShowProductsRatings: String? = nil,
        accountsShowProductsFiles: String? = nil,
        accountsShowProductDeliveryPeriod: String? = nil,
        accountsShowOffersMagazines: String? = nil,
        accountsShowBrands: String? = nil,
        accountsShowBrandPage: String? = nil,
        accountsShowOffers: String? = nil,
        accountsShowImportLogs: String? = nil,
        accountsShowStocks: String? = nil,
        accountsShowOrderShippings: String? = nil,
        accountsShowOrderReturnRequests: String? = nil,
        accountsShowPromotionalMessages: String? = nil,
        accountsShowPoints: String? = nil,
        accountsShowSimilarItems: String? = nil,
        accountsShowProductAssociations: String? = nil,
        accountsShowAttributes: String? = nil,
        accountsShowUploads: String? = nil,
        accountsShowDailyOffers: String? = nil,
        accountsShowHomeSettings: String? = nil,
        accountsShowAdvertisementsSettings: String? = nil,
        accountsMultiPriceForProduct: String? = nil,
        accountsMultiPayments: String? = nil,
        accountsOrdersScheduling: String? = nil,
        accountsOrdersPickup: String? = nil,
        accountsShowCashback: String? = nil,
        accountsShowOurClients: String? = nil,
        accountsOffersType: String? = nil,
        accountsShowBi: String? = nil,
        accountsFcmKey: String? = nil,
        accountsFcmApiKey: String? = nil,
        accountsFcmAuthDomain: String? = nil,
        accountsFcmDatabaseURL: String? = nil,
        accountsFcmProjectId: String? = nil,
        accountsFcmStorageBucket: String? = nil,
        accountsFcmMessagingSenderId: String? = nil,
        accountsFcmAppId: String? = nil,
        accountsFcmMeasurementId: String? = nil,
        accountsAndroidUrl: String? = nil,
        accountsIosUrl: String? = nil,
        accountsProductUrl: String? = nil,
        accountsGoogleMapKey: String? = nil,
        accountsWebsiteUrl: String? = nil,
        accountsNumberDecimalDigits: Int? = nil,
        accountsStatus: String? = nil,
        accountsPosition: Int? = nil,
        accountsWebServiceToken: String? = nil,
        accountsSocialLoginBtns: String? = nil,
        accountsShowRemoveAccount: String? = nil,
        accountsAppTheme: String? = nil,
        accountsAuthType: String? = nil,
        accountsCreatedAt: String? = nil,
        accountsUpdatedAt: String? = nil,
        accountsShowReels: String? = nil,
        productsTitle: String? = nil,
        mobileAppColors: MobileAppColors? = nil
    ) {
        self.accountsId = accountsId
        self.accountsName = accountsName
        self.accountsSlug = accountsSlug
        self.accountsImgDashboard = accountsImgDashboard
        self.accountsImgRtl = accountsImgRtl
        self.accountsImgLtr = accountsImgLtr
        self.accountsImgFavicon = accountsImgFavicon
        self.accountsImgHeaderReverse = accountsImgHeaderReverse
        self.accountsShowBranches = accountsShowBranches
        self.accountsShowHierarchy = accountsShowHierarchy
        self.accountsShowAreas = accountsShowAreas
        self.accountsShowCoupons = accountsShowCoupons
        self.accountsShowShippingMethods = accountsShowShippingMethods
        self.accountsShowOrdersRatings = accountsShowOrdersRatings
        self.accountsSingleMenu = accountsSingleMenu
        self.accountsCountry = accountsCountry
        self.accountsCountryCode = accountsCountryCode
        self.accountsMultipleCountries = accountsMultipleCountries
        self.accountsCountryMobileDigitsCount = accountsCountryMobileDigitsCount
        self.accountsTimezone = accountsTimezone
        self.accountsCountryLatLong = accountsCountryLatLong
        self.accountsNoreplyEmail = accountsNoreplyEmail
        self.accountsShowCalories = accountsShowCalories
        self.accountsShowProductType = accountsShowProductType
        self.accountsShowTestimonials = accountsShowTestimonials
        self.accountsShowQuestions = accountsShowQuestions
        self.accountsShowPartners = accountsShowPartners
        self.accountsShowNews = accountsShowNews
        self.accountsShowJobs = accountsShowJobs
        self.accountsShowArticles = accountsShowArticles
        self.accountsShowAlbums = accountsShowAlbums
        self.accountsShowWallet = accountsShowWallet
        self.accountsShowLostSales = accountsShowLostSales
        self.accountsShowPointsLevels = accountsShowPointsLevels
        self.accountsShowChoices = accountsShowChoices
        self.accountsShowProductsNotifications = accountsShowProductsNotifications
        self.accountsShowProductsRatings = accountsShowProductsRatings
        self.accountsShowProductsFiles = accountsShowProductsFiles
        self.accountsShowProductDeliveryPeriod = accountsShowProductDeliveryPeriod
        self.accountsShowOffersMagazines = accountsShowOffersMagazines
        self.accountsShowBrands = accountsShowBrands
        self.accountsShowBrandPage = accountsShowBrandPage
        self.accountsShowOffers = accountsShowOffers
        self.accountsShowImportLogs = accountsShowImportLogs
        self.accountsShowStocks = accountsShowStocks
        self.accountsShowOrderShippings = accountsShowOrderShippings
        self.accountsShowOrderReturnRequests = accountsShowOrderReturnRequests
        self.accountsShowPromotionalMessages = accountsShowPromotionalMessages
        self.accountsShowPoints = accountsShowPoints
        self.accountsShowSimilarItems = accountsShowSimilarItems
        self.accountsShowProductAssociations = accountsShowProductAssociations
        self.accountsShowAttributes = accountsShowAttributes
        self.accountsShowUploads = accountsShowUploads
        self.accountsShowDailyOffers = accountsShowDailyOffers
        self.accountsShowHomeSettings = accountsShowHomeSettings
        self.accountsShowAdvertisementsSettings = accountsShowAdvertisementsSettings
        self.accountsMultiPriceForProduct = accountsMultiPriceForProduct
        self.accountsMultiPayments = accountsMultiPayments
        self.accountsOrdersScheduling = accountsOrdersScheduling
        self.accountsOrdersPickup = accountsOrdersPickup
        self.accountsShowCashback = accountsShowCashback
        self.accountsShowOurClients = accountsShowOurClients
        self.accountsOffersType = accountsOffersType
        self.accountsShowBi = accountsShowBi
        self.accountsFcmKey = accountsFcmKey
        self.accountsFcmApiKey = accountsFcmApiKey
        self.accountsFcmAuthDomain = accountsFcmAuthDomain
        self.accountsFcmDatabaseURL = accountsFcmDatabaseURL
        self.accountsFcmProjectId = accountsFcmProjectId
        self.accountsFcmStorageBucket = accountsFcmStorageBucket
        self.accountsFcmMessagingSenderId = accountsFcmMessagingSenderId
        self.accountsFcmAppId = accountsFcmAppId
        self.accountsFcmMeasurementId = accountsFcmMeasurementId
        self.accountsAndroidUrl = accountsAndroidUrl
        self.accountsIosUrl = accountsIosUrl
        self.accountsProductUrl = accountsProductUrl
        self.accountsGoogleMapKey = accountsGoogleMapKey
        self.accountsWebsiteUrl = accountsWebsiteUrl
        self.accountsNumberDecimalDigits = accountsNumberDecimalDigits
        self.accountsStatus = accountsStatus
        self.accountsPosition = accountsPosition
        self.accountsWebServiceToken = accountsWebServiceToken
        self.accountsSocialLoginBtns = accountsSocialLoginBtns
        self.accountsShowRemoveAccount = accountsShowRemoveAccount
        self.accountsAppTheme = accountsAppTheme
        self.accountsAuthType = accountsAuthType
        self.accountsCreatedAt = accountsCreatedAt
        self.accountsUpdatedAt = accountsUpdatedAt
        self.accountsShowReels = accountsShowReels
        self.productsTitle = productsTitle
        self.mobileAppColors = mobileAppColors
    }

    enum CodingKeys: String, CodingKey {
        case accountsId = "accounts_id"
        case accountsName = "accounts_name"
        case accountsSlug = "accounts_slug"
        case accountsImgDashboard = "accounts_img_dashboard"
        case accountsImgRtl = "accounts_img_rtl"
        case accountsImgLtr = "accounts_img_ltr"
        case accountsImgFavicon = "accounts_img_favicon"
        case accountsImgHeaderReverse = "accounts_img_header_reverse"
        case accountsShowBranches = "accounts_show_branches"
        case accountsShowHierarchy = "accounts_show_hierarchy"
        case accountsShowAreas = "accounts_show_areas"
        case accountsShowCoupons = "accounts_show_coupons"
        case accountsShowShippingMethods = "accounts_show_shipping_methods"
        case accountsShowOrdersRatings = "accounts_show_orders_ratings"
        case accountsSingleMenu = "accounts_single_menu"
        case accountsCountry = "accounts_country"
        case accountsCountryCode = "accounts_country_code"
        case accountsMultipleCountries = "accounts_multiple_countries"
        case accountsCountryMobileDigitsCount = "accounts_country_mobile_digits_count"
        case accountsTimezone = "accounts_timezone"
        case accountsCountryLatLong = "accounts_country_lat_long"
        case accountsNoreplyEmail = "accounts_noreply_email"
        case accountsShowCalories = "accounts_show_calories"
        case accountsShowProductType = "accounts_show_product_type"
        case accountsShowTestimonials = "accounts_show_testimonials"
        case accountsShowQuestions = "accounts_show_questions"
        case accountsShowPartners = "accounts_show_partners"
        case accountsShowNews = "accounts_show_news"
        case accountsShowJobs = "accounts_show_jobs"
        case accountsShowArticles = "accounts_show_articles"
        case accountsShowAlbums = "accounts_show_albums"
        case accountsShowWallet = "accounts_show_wallet"
        case accountsShowLostSales = "accounts_show_lost_sales"
        case accountsShowPointsLevels = "accounts_show_points_levels"
        case accountsShowChoices = "accounts_show_choices"
        case accountsShowProductsNotifications = "accounts_show_products_notifications"
        case accountsShowProductsRatings = "accounts_show_products_ratings"
        case accountsShowProductsFiles = "accounts_show_products_files"
        case accountsShowProductDeliveryPeriod = "accounts_show_product_delivery_period"
        case accountsShowOffersMagazines = "accounts_show_offers_magazines"
        case accountsShowBrands = "accounts_show_brands"
        case accountsShowBrandPage = "accounts_show_brand_page"
        case accountsShowOffers = "accounts_show_offers"
        case accountsShowImportLogs = "accounts_show_import_logs"
        case accountsShowStocks = "accounts_show_stocks"
        case accountsShowOrderShippings = "accounts_show_order_shippings"
        case accountsShowOrderReturnRequests = "accounts_show_order_return_requests"
        case accountsShowPromotionalMessages = "accounts_show_promotional_messages"
        case accountsShowPoints = "accounts_show_points"
        case accountsShowSimilarItems = "accounts_show_similar_items"
        case accountsShowProductAssociations = "accounts_show_product_associations"
        case accountsShowAttributes = "accounts_show_attributes"
        case accountsShowUploads = "accounts_show_uploads"
        case accountsShowDailyOffers = "accounts_show_daily_offers"
        case accountsShowHomeSettings = "accounts_show_home_settings"
        case accountsShowAdvertisementsSettings = "accounts_show_advertisements_settings"
        case accountsMultiPriceForProduct = "accounts_multi_price_for_product"
        case accountsMultiPayments = "accounts_multi_payments"
        case accountsOrdersScheduling = "accounts_orders_scheduling"
        case accountsOrdersPickup = "accounts_orders_pickup"
        case accountsShowCashback = "accounts_show_cashback"
        case accountsShowOurClients = "accounts_show_our_clients"
        case accountsOffersType = "accounts_offers_type"
        case accountsShowBi = "accounts_show_bi"
        case accountsFcmKey = "accounts_fcm_key"
        case accountsFcmApiKey = "accounts_fcm_apiKey"
        case accountsFcmAuthDomain = "accounts_fcm_authDomain"
        case accountsFcmDatabaseURL = "accounts_fcm_databaseURL"
        case accountsFcmProjectId = "accounts_fcm_projectId"
        case accountsFcmStorageBucket = "accounts_fcm_storageBucket"
        case accountsFcmMessagingSenderId = "accounts_fcm_messagingSenderId"
        case accountsFcmAppId = "accounts_fcm_appId"
        case accountsFcmMeasurementId = "accounts_fcm_measurementId"
        case accountsAndroidUrl = "accounts_android_url"
        case accountsIosUrl = "accounts_ios_url"
        case accountsProductUrl = "accounts_product_url"
        case accountsGoogleMapKey = "accounts_google_map_key"
        case accountsWebsiteUrl = "accounts_website_url"
        case accountsNumberDecimalDigits = "accounts_number_decimal_digits"
        case accountsStatus = "accounts_status"
        case accountsPosition = "accounts_position"
        case accountsWebServiceToken = "accounts_web_service_token"
        case accountsSocialLoginBtns = "accounts_social_login_btns"
        case accountsShowRemoveAccount = "accounts_show_remove_account"
        case accountsAppTheme = "accounts_app_theme"
        case accountsAuthType = "accounts_auth_type"
        case accountsCreatedAt = "accounts_created_at"
        case accountsUpdatedAt = "accounts_updated_at"
        case accountsShowReels = "accounts_show_reels"
        case productsTitle = "products_title"
        case mobileAppColors = "mobile_app_colors"
    }
}
