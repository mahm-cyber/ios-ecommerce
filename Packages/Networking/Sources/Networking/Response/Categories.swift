//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation



public struct Categories: Codable, Sendable {
    let categoriesId: Int?
    let categoriesCode: String?
    let categoriesParentId: Int?
    let categoriesImg: String?
    let categoriesBannerImg: String?
    let categoriesWebBannerImg: String?
    let categoriesFollowDeliveryTime: String?
    let categoriesShowInMenu: String?
    let categoriesTitle: String?
    let categoriesSlug: String?
    let subcategories: [Categories]?

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
