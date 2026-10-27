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
    
    public static let example = CategoryItem(
        id: 1,
        title: "Clothing",
        slug: "clothing",
        subcategories: [
            CategoryItem(id: 2, title: "T-Shirts", slug: "t-shirts", parentId: 1),
            CategoryItem(id: 3, title: "Hoodies", slug: "hoodies", parentId: 1)
        ]
    )
}


extension CategoryItem {
    public func imageURL(baseURL: URL, accountID: String) -> URL? {
        ImageURLBuilder(baseURL: baseURL, accountID: accountID)
            .buildURL(image: imageName, folderName: .categories)
    }
}
