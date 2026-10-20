//
//  StaticPage.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 20/10/2026.
//

import Foundation

public struct StaticPage: Codable, Sendable {
    public let staticPagesId: Int?
    public let fKAccountsId: Int?
    public let staticPagesTitle: String?
    public let staticPagesContent: String?
    public let staticPagesSlug: String?
    public let staticPagesType: String?
    public let staticPagesStatus: String?
    public let staticPagesPositions: Int?
    public let staticPagesCreatedAt: String?
    public let staticPagesUpdatedAt: String?
    public let staticPagesSeoTitle: String?
    public let staticPagesSeoDesc: String?

    public init(
        staticPagesId: Int? = nil,
        fKAccountsId: Int? = nil,
        staticPagesTitle: String? = nil,
        staticPagesContent: String? = nil,
        staticPagesSlug: String? = nil,
        staticPagesType: String? = nil,
        staticPagesStatus: String? = nil,
        staticPagesPositions: Int? = nil,
        staticPagesCreatedAt: String? = nil,
        staticPagesUpdatedAt: String? = nil,
        staticPagesSeoTitle: String? = nil,
        staticPagesSeoDesc: String? = nil
    ) {
        self.staticPagesId = staticPagesId
        self.fKAccountsId = fKAccountsId
        self.staticPagesTitle = staticPagesTitle
        self.staticPagesContent = staticPagesContent
        self.staticPagesSlug = staticPagesSlug
        self.staticPagesType = staticPagesType
        self.staticPagesStatus = staticPagesStatus
        self.staticPagesPositions = staticPagesPositions
        self.staticPagesCreatedAt = staticPagesCreatedAt
        self.staticPagesUpdatedAt = staticPagesUpdatedAt
        self.staticPagesSeoTitle = staticPagesSeoTitle
        self.staticPagesSeoDesc = staticPagesSeoDesc
    }

    enum CodingKeys: String, CodingKey {
        case staticPagesId = "static_pages_id"
        case fKAccountsId = "FK_accounts_id"
        case staticPagesTitle = "static_pages_title"
        case staticPagesContent = "static_pages_content"
        case staticPagesSlug = "static_pages_slug"
        case staticPagesType = "static_pages_type"
        case staticPagesStatus = "static_pages_status"
        case staticPagesPositions = "static_pages_positions"
        case staticPagesCreatedAt = "static_pages_created_at"
        case staticPagesUpdatedAt = "static_pages_updated_at"
        case staticPagesSeoTitle = "static_pages_seo_title"
        case staticPagesSeoDesc = "static_pages_seo_desc"
    }
}
