//
//  File.swift
//  Core
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import Foundation

public struct CategoryItem: Identifiable, Sendable, Equatable, Hashable {
    public  let id: Int
    public  let title: String
    public let slug: String
    public let imageName: String?
    public let bannerImageName: String?
    public let parentId: Int?
    public let subcategories: [CategoryItem]
    
    public init(
        id: Int,
        title: String,
        slug: String,
        imageName: String? = nil,
        bannerImageName: String? = nil,
        parentId: Int? = nil,
        subcategories: [CategoryItem] = []
    ) {
        self.id = id
        self.title = title
        self.slug = slug
        self.imageName = imageName
        self.bannerImageName = bannerImageName
        self.parentId = parentId
        self.subcategories = subcategories
    }
}
