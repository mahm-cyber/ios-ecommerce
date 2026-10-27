//
//  PaginationDTO.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation

public struct PaginationLinkDTO: Decodable, Sendable {
    public let url: String?
    public let label: String?
    public let active: Bool?

    public init(
        url: String? = nil,
        label: String? = nil,
        active: Bool? = nil
    ) {
        self.url = url
        self.label = label
        self.active = active
    }

    enum CodingKeys: String, CodingKey {
        case url
        case label
        case active
    }
}

public struct PaginationDTO: Decodable, Sendable {
    public let currentPage: Int?
    public let firstPageUrl: String?
    public let from: Int?
    public let lastPage: Int?
    public let lastPageUrl: String?
    public let links: [PaginationLinkDTO]?
    public let nextPageUrl: String?
    public let path: String?
    public let perPage: Int?
    public let prevPageUrl: String?
    public let to: Int?
    public let total: Int?

    public init(
        currentPage: Int? = nil,
        firstPageUrl: String? = nil,
        from: Int? = nil,
        lastPage: Int? = nil,
        lastPageUrl: String? = nil,
        links: [PaginationLinkDTO]? = nil,
        nextPageUrl: String? = nil,
        path: String? = nil,
        perPage: Int? = nil,
        prevPageUrl: String? = nil,
        to: Int? = nil,
        total: Int? = nil
    ) {
        self.currentPage = currentPage
        self.firstPageUrl = firstPageUrl
        self.from = from
        self.lastPage = lastPage
        self.lastPageUrl = lastPageUrl
        self.links = links
        self.nextPageUrl = nextPageUrl
        self.path = path
        self.perPage = perPage
        self.prevPageUrl = prevPageUrl
        self.to = to
        self.total = total
    }

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case firstPageUrl = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageUrl = "last_page_url"
        case links
        case nextPageUrl = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageUrl = "prev_page_url"
        case to
        case total
    }
}
