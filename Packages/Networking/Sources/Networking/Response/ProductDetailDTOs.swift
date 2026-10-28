//
//  ProductDetailDTOs.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import Foundation

public struct ProductImageDTO: Decodable, Sendable, Equatable {
    public let id: Int
    public let productId: Int?
    public let name: String?

    public init(
        id: Int,
        productId: Int? = nil,
        name: String? = nil
    ) {
        self.id = id
        self.productId = productId
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case id = "products_images_id"
        case productId = "products_id"
        case name = "products_images_name"
    }
}

public struct ProductBrandDTO: Decodable, Sendable, Equatable {
    public let id: Int
    public let name: String?
    public let slug: String?
    public let img: String?

    public init(
        id: Int,
        name: String? = nil,
        slug: String? = nil,
        img: String? = nil
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.img = img
    }

    enum CodingKeys: String, CodingKey {
        case id = "brands_id"
        case name = "brands_name"
        case slug = "brands_slug"
        case img = "brands_img"
    }
}

public struct ProductDetailDTO: Decodable, Sendable {
    public let id: Int
    public let categoryId: Int?
    public let brandId: Int?
    public let code: String?
    public let barcode: String?
    public let img: String?
    public let price: Double
    public let priceAfterDiscount: Double?
    public let points: Int?
    public let video: String?
    public let type: String?
    public let stocks: Int?
    public let rating: String?
    public let title: String
    public let desc: String?
    public let slug: String
    public let isFav: Int?
    public let isNotify: Int?
    public let isNew: Int?
    public let mostWanted: Int?
    public let allImages: [String]?
    public let images: [ProductImageDTO]?
    public let brand: ProductBrandDTO?
    public let category: ProductCategoryDTO?
    public let tags: [ProductTagDTO]?
    public let similarProducts: [ProductItemDTO]?
    public let offer: ProductOfferDTO?

    public init(
        id: Int,
        categoryId: Int? = nil,
        brandId: Int? = nil,
        code: String? = nil,
        barcode: String? = nil,
        img: String? = nil,
        price: Double,
        priceAfterDiscount: Double? = nil,
        points: Int? = nil,
        video: String? = nil,
        type: String? = nil,
        stocks: Int? = nil,
        rating: String? = nil,
        title: String,
        desc: String? = nil,
        slug: String,
        isFav: Int? = nil,
        isNotify: Int? = nil,
        isNew: Int? = nil,
        mostWanted: Int? = nil,
        allImages: [String]? = nil,
        images: [ProductImageDTO]? = nil,
        brand: ProductBrandDTO? = nil,
        category: ProductCategoryDTO? = nil,
        tags: [ProductTagDTO]? = nil,
        similarProducts: [ProductItemDTO]? = nil,
        offer: ProductOfferDTO? = nil
    ) {
        self.id = id
        self.categoryId = categoryId
        self.brandId = brandId
        self.code = code
        self.barcode = barcode
        self.img = img
        self.price = price
        self.priceAfterDiscount = priceAfterDiscount
        self.points = points
        self.video = video
        self.type = type
        self.stocks = stocks
        self.rating = rating
        self.title = title
        self.desc = desc
        self.slug = slug
        self.isFav = isFav
        self.isNotify = isNotify
        self.isNew = isNew
        self.mostWanted = mostWanted
        self.allImages = allImages
        self.images = images
        self.brand = brand
        self.category = category
        self.tags = tags
        self.similarProducts = similarProducts
        self.offer = offer
    }

    enum CodingKeys: String, CodingKey {
        case id = "products_id"
        case categoryId = "FK_categories_id"
        case brandId = "brands_id"
        case code = "products_code"
        case barcode = "products_barcode"
        case img = "products_img"
        case price = "products_price"
        case priceAfterDiscount = "products_price_after_discount"
        case points = "products_points"
        case video = "products_video"
        case type = "products_type"
        case stocks = "products_stocks"
        case rating = "products_rating"
        case title = "products_title"
        case desc = "products_desc"
        case slug = "products_slug"
        case isFav = "is_fav"
        case isNotify = "is_notify"
        case isNew = "is_new"
        case mostWanted = "most_wanted"
        case allImages = "all_images"
        case images
        case brand
        case category
        case tags
        case similarProducts = "SimilarProducts"
        case offer
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try c.decode(Int.self, forKey: .id)
        self.categoryId = try c.decodeIfPresent(Int.self, forKey: .categoryId)
        self.brandId = try c.decodeIfPresent(Int.self, forKey: .brandId)
        self.code = try c.decodeIfPresent(String.self, forKey: .code)
        self.barcode = try c.decodeIfPresent(String.self, forKey: .barcode)
        self.img = try c.decodeIfPresent(String.self, forKey: .img)
        self.price = try c.decodeFlexibleDouble(forKey: .price)
        self.priceAfterDiscount = try c.decodeFlexibleDoubleIfPresent(forKey: .priceAfterDiscount)
        self.points = try c.decodeIfPresent(Int.self, forKey: .points)
        self.video = try c.decodeIfPresent(String.self, forKey: .video)
        self.type = try c.decodeIfPresent(String.self, forKey: .type)
        self.stocks = try c.decodeIfPresent(Int.self, forKey: .stocks)
        self.rating = try c.decodeIfPresent(String.self, forKey: .rating)
        self.title = try c.decode(String.self, forKey: .title)
        self.desc = try c.decodeIfPresent(String.self, forKey: .desc)
        self.slug = try c.decode(String.self, forKey: .slug)
        self.isFav = try c.decodeIfPresent(Int.self, forKey: .isFav)
        self.isNotify = try c.decodeIfPresent(Int.self, forKey: .isNotify)
        self.isNew = try c.decodeIfPresent(Int.self, forKey: .isNew)
        self.mostWanted = try c.decodeIfPresent(Int.self, forKey: .mostWanted)
        self.allImages = try c.decodeIfPresent([String].self, forKey: .allImages)
        self.images = try c.decodeIfPresent([ProductImageDTO].self, forKey: .images)
        self.brand = try c.decodeIfPresent(ProductBrandDTO.self, forKey: .brand)
        self.category = try c.decodeIfPresent(ProductCategoryDTO.self, forKey: .category)
        self.tags = try c.decodeIfPresent([ProductTagDTO].self, forKey: .tags)
        self.similarProducts = try c.decodeIfPresent([ProductItemDTO].self, forKey: .similarProducts)
        self.offer = try c.decodeIfPresent(ProductOfferDTO.self, forKey: .offer)
    }
}

public struct ProductDetailResponseDTO: Decodable, Sendable {
    public let product: ProductDetailDTO
    public let ratingsCount: Int?
    public let allowRating: Int?

    public init(
        product: ProductDetailDTO,
        ratingsCount: Int? = nil,
        allowRating: Int? = nil
    ) {
        self.product = product
        self.ratingsCount = ratingsCount
        self.allowRating = allowRating
    }

    enum CodingKeys: String, CodingKey {
        case product
        case ratingsCount
        case allowRating = "allow_rating"
    }
}
