//
//  File.swift
//  Core
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation


public enum StoreStatus: Sendable, Equatable {
    case active
    case maintenance(message: String?)
    case ordersDisabled(message: String?)
    
 
}

public struct CurrencyConfig: Sendable, Equatable {
    public let code: String
    public let isLeading: Bool
    
    public init(code: String, isLeading: Bool) {
        self.code = code
        self.isLeading = isLeading
    }
    
    public static let `default` = CurrencyConfig(code: "SAR", isLeading: false)
}

public struct ThemeConfig: Sendable, Equatable {
    public let themeName: String
    public let primaryColorHex: String?
    public let logoURL: String?
    
    public init(themeName: String, primaryColorHex: String?, logoURL: String?) {
        self.themeName = themeName
        self.primaryColorHex = primaryColorHex
        self.logoURL = logoURL
    }
}

public struct BootstrapData: Equatable, Sendable {
    public let storeStatus: StoreStatus
    public let currency: CurrencyConfig
    public let theme: ThemeConfig
    public let minIosVersion: String?
    public let defaultLanguage: String?
    public let categories: [CategoryItem]
    
    public init(
        storeStatus: StoreStatus,
        currency: CurrencyConfig,
        theme: ThemeConfig,
        minIosVersion: String?,
        defaultLanguage: String?,
        categories: [CategoryItem] = []
    ) {
        self.storeStatus = storeStatus
        self.currency = currency
        self.theme = theme
        self.minIosVersion = minIosVersion
        self.defaultLanguage = defaultLanguage
        self.categories = categories
    }
}
