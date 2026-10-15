//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation


struct AccountData: Codable, Sendable {
    let accountsId: Int?
    let accountsName: String?
    let accountsSlug: String?
    let accountsImgDashboard: String?
    let accountsImgRtl: String?
    let accountsImgLtr: String?
    let accountsImgFavicon: String?
    let accountsImgHeaderReverse: String?
    let accountsShowBranches: String?
    let accountsShowHierarchy: String?
    let accountsShowAreas: String?
    let accountsShowCoupons: String?
    let accountsShowShippingMethods: String?
    let accountsShowOrdersRatings: String?
    let accountsSingleMenu: String?
    let accountsCountry: String?
    let accountsCountryCode: String?
    let accountsMultipleCountries: String?
    let accountsCountryMobileDigitsCount: Int?
    let accountsTimezone: String?
    let accountsCountryLatLong: String?
    let accountsNoreplyEmail: String?
    let accountsShowCalories: String?
    let accountsShowProductType: String?
    let accountsShowTestimonials: String?
    let accountsShowQuestions: String?
    let accountsShowPartners: String?
    let accountsShowNews: String?
    let accountsShowJobs: String?
    let accountsShowArticles: String?
    let accountsShowAlbums: String?
    let accountsShowWallet: String?
    let accountsShowLostSales: String?
    let accountsShowPointsLevels: String?
    let accountsShowChoices: String?
    let accountsShowProductsNotifications: String?
    let accountsShowProductsRatings: String?
    let accountsShowProductsFiles: String?
    let accountsShowProductDeliveryPeriod: String?
    let accountsShowOffersMagazines: String?
    let accountsShowBrands: String?
    let accountsShowBrandPage: String?
    let accountsShowOffers: String?
    let accountsShowImportLogs: String?
    let accountsShowStocks: String?
    let accountsShowOrderShippings: String?
    let accountsShowOrderReturnRequests: String?
    let accountsShowPromotionalMessages: String?
    let accountsShowPoints: String?
    let accountsShowSimilarItems: String?
    let accountsShowProductAssociations: String?
    let accountsShowAttributes: String?
    let accountsShowUploads: String?
    let accountsShowDailyOffers: String?
    let accountsShowHomeSettings: String?
    let accountsShowAdvertisementsSettings: String?
    let accountsMultiPriceForProduct: String?
    let accountsMultiPayments: String?
    let accountsOrdersScheduling: String?
    let accountsOrdersPickup: String?
    let accountsShowCashback: String?
    let accountsShowOurClients: String?
    let accountsOffersType: String?
    let accountsShowBi: String?
    let accountsFcmKey: String?
    let accountsFcmApiKey: String?
    let accountsFcmAuthDomain: String?
    let accountsFcmDatabaseURL: String?
    let accountsFcmProjectId: String?
    let accountsFcmStorageBucket: String?
    let accountsFcmMessagingSenderId: String?
    let accountsFcmAppId: String?
    let accountsFcmMeasurementId: String?
    let accountsAndroidUrl: String?
    let accountsIosUrl: String?
    let accountsProductUrl: String?
    let accountsGoogleMapKey: String?
    let accountsWebsiteUrl: String?
    let accountsNumberDecimalDigits: Int?
    let accountsStatus: String?
    let accountsPosition: Int?
    let accountsWebServiceToken: String?
    let accountsSocialLoginBtns: String?
    let accountsShowRemoveAccount: String?
    let accountsAppTheme: String?
    let accountsAuthType: String?
    let accountsCreatedAt: String?
    let accountsUpdatedAt: String?
    let accountsShowReels: String?
    let productsTitle: String?
    let mobileAppColors: MobileAppColors?

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
