//
//  ProductDetail.swift
//  Core
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import Foundation

public struct ProductDetail: Sendable, Equatable, Identifiable, Hashable {
    public var id: Int { item.id }
    public let item: ProductItem
    public let galleryImages: [String]
    public let brandName: String?
    public let brandImage: String?
    public let ratingsCount: Int?
    public let allowRating: Bool
    public let videoURL: String?
    public let points: Int?
    public let similarProducts: [ProductItem]

    public var name: String { item.name }
    public var price: Double { item.price }
    public var salePrice: Double? { item.salePrice }
    public var discountPercentage: String? { item.discountPercentage }
    public var rating: String? { item.rating }
    public var description: String? { item.description }
    public var stocks: Int? { item.stocks }
    public var isOutOfStock: Bool { item.isOutOfStock ?? false }
    public var isFavorite: Bool { item.isFavorite ?? false }
    public var category: CategoryItem? { item.category }
    public var tags: [String] { item.tags }
    public var code: String? { item.code }

    public init(
        item: ProductItem,
        galleryImages: [String] = [],
        brandName: String? = nil,
        brandImage: String? = nil,
        ratingsCount: Int? = nil,
        allowRating: Bool = false,
        videoURL: String? = nil,
        points: Int? = nil,
        similarProducts: [ProductItem] = []
    ) {
        self.item = item
        self.galleryImages = galleryImages
        self.brandName = brandName
        self.brandImage = brandImage
        self.ratingsCount = ratingsCount
        self.allowRating = allowRating
        self.videoURL = videoURL
        self.points = points
        self.similarProducts = similarProducts
    }
}

extension ProductDetail {
    public static let example = ProductDetail(
        item: .example,
        galleryImages: [
            "Rectangle 123.webp",
            "5_7a04b54a-217b-47ea-b408-276444720bd4.webp"
        ],
        brandName: "elementre",
        brandImage: "elementre.webp",
        ratingsCount: 2,
        allowRating: false,
        videoURL: "https://youtube.com/shorts/ClDIgCZSEM8?si=yn15iRiPxVCnNXzI",
        points: 100,
        similarProducts: ProductItem.examples
    )
}
