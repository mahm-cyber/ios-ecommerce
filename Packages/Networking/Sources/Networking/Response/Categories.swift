//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation



public struct Categories: Codable, Sendable {
    public let categoriesId: Int?
    public let categoriesCode: String?
    public let categoriesParentId: Int?
    public  let categoriesImg: String?
    public let categoriesBannerImg: String?
    public let categoriesWebBannerImg: String?
    public let categoriesFollowDeliveryTime: String?
    public let categoriesShowInMenu: String?
    public let categoriesTitle: String?
    public let categoriesSlug: String?
    public let subcategories: [Categories]?
    
    public init(
        categoriesId: Int? = nil,
        categoriesCode: String? = nil,
        categoriesParentId: Int? = nil,
        categoriesImg: String? = nil,
        categoriesBannerImg: String? = nil,
        categoriesWebBannerImg: String? = nil,
        categoriesFollowDeliveryTime: String? = nil,
        categoriesShowInMenu: String? = nil,
        categoriesTitle: String? = nil,
        categoriesSlug: String? = nil,
        subcategories: [Categories]? = nil
    ) {
        self.categoriesId = categoriesId
        self.categoriesCode = categoriesCode
        self.categoriesParentId = categoriesParentId
        self.categoriesImg = categoriesImg
        self.categoriesBannerImg = categoriesBannerImg
        self.categoriesWebBannerImg = categoriesWebBannerImg
        self.categoriesFollowDeliveryTime = categoriesFollowDeliveryTime
        self.categoriesShowInMenu = categoriesShowInMenu
        self.categoriesTitle = categoriesTitle
        self.categoriesSlug = categoriesSlug
        self.subcategories = subcategories
    }

    enum CodingKeys: String, CodingKey {
        case categoriesId = "categories_id"
        case categoriesCode = "categories_code"
        case categoriesParentId = "categories_parent_id"
        case categoriesImg = "categories_img"
        case categoriesBannerImg = "categories_banner_img"
        case categoriesWebBannerImg = "categories_web_banner_img"
        case categoriesFollowDeliveryTime = "categories_follow_delivery_time"
        case categoriesShowInMenu = "categories_show_in_menu"
        case categoriesTitle = "categories_title"
        case categoriesSlug = "categories_slug"
        case subcategories
    }
}
