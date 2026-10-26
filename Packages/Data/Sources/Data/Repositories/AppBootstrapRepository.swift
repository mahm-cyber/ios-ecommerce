//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 19/10/2026.
//

import Foundation
import Observation
import Networking
import Core

@Observable
public final class AppBootstrapRepository: BootstrapRepository, @unchecked Sendable {
    
    
    public private(set) var state: BootstrapState = .idle
    let networkClient: NetworkClient
    
    
    public init(state: BootstrapState = .idle, networkClient: NetworkClient) {
        self.state = state
        self.networkClient = networkClient
    }
    
    
    //    public func load() async {
    
    //
    //    }
    public func load() async throws {
        state = .loading
        
        do {
            let initialData =  try  await networkClient.send(.initial)
            let bootstrapData = map(initialData)
            state = .loaded(bootstrapData)
        } catch let error as NetworkError {
            state = .failed(error)
            throw error
        } catch {
            #if DEBUG
            print("❌ [Bootstrap Error] \(error)")
            #endif
            state = .failed(.serverError(statusCode: -1, message: error.localizedDescription))
            throw error
        }
    }
    
    private func map(_ initial: InitialData) -> BootstrapData {
        // 1. Store Status
        let status: StoreStatus
        if let setting = initial.setting {
            if setting.websiteStatus == 0 {
                status = .maintenance(message: setting.stopWebsiteMsg)
            } else if setting.stopOrder == 1 {
                status = .ordersDisabled(message: setting.stopOrderMsg)
            } else {
                status = .active
            }
        } else {
            status = .active
        }

        // 2. Currency
        let isLeading = (initial.setting?.currencyDirection?.lowercased() == "left" ||
                         initial.setting?.currencyDirection?.lowercased() == "ltr")
        let currency = CurrencyConfig(
            code: initial.setting?.settingsCurrency ?? "SAR",
            isLeading: isLeading
        )

        // 3. Theme
        let theme = ThemeConfig(
            themeName: initial.account?.accountsAppTheme ?? "theme4",
            primaryColorHex: initial.account?.mobileAppColors?.accountsColorsBackground1,
            logoURL: initial.account?.accountsImgRtl ?? initial.account?.accountsImgLtr
        )
        
        // 4. Categories
        let categories = initial.categories?
            .compactMap { $0 }
            .compactMap{ mapCategory($0) } ?? []

        return BootstrapData(
            storeStatus: status,
            currency: currency,
            theme: theme,
            minIosVersion: initial.setting?.iosVersion,
            defaultLanguage: initial.setting?.settingsDefaultLanguage ?? initial.defaultLang,
            categories: categories
        )
    }
    
    private func mapCategory(_ dto: Categories) -> CategoryItem? {
        guard let id = dto.categoriesId,
              let title = dto.categoriesTitle,
              !title.isEmpty else {
            return nil
        }
        
        let subcategories = dto.subcategories?
            .compactMap { mapCategory($0) } ?? []
        
        return CategoryItem(
            id: id,
            title: title,
            slug: dto.categoriesSlug ?? "",
            imageName: dto.categoriesImg,
            bannerImageName: dto.categoriesBannerImg,
            parentId: dto.categoriesParentId,
            subcategories: subcategories
        )
    }
}
