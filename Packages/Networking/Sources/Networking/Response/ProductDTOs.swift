//
//  ProductDTOs.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation

public struct ProductCategoryDTO: Decodable, Sendable {
    public let id: Int
    public let title: String?
    public let slug: String?

    public init(
        id: Int,
        title: String? = nil,
        slug: String? = nil
    ) {
        self.id = id
        self.title = title
        self.slug = slug
    }

    enum CodingKeys: String, CodingKey {
        case id = "categories_id"
        case title = "categories_title"
        case slug = "categories_slug"
    }
}

public struct ProductOfferDTO: Decodable, Sendable {
    public let id: Int
    public let title: String?
    public let mainNumber: Int?
    public let additionalNumber: Int?
    public let discount: Double?
    public let type: String?
    public let from: String?
    public let to: String?

    public init(
        id: Int,
        title: String? = nil,
        mainNumber: Int? = nil,
        additionalNumber: Int? = nil,
        discount: Double? = nil,
        type: String? = nil,
        from: String? = nil,
        to: String? = nil
    ) {
        self.id = id
        self.title = title
        self.mainNumber = mainNumber
        self.additionalNumber = additionalNumber
        self.discount = discount
        self.type = type
        self.from = from
        self.to = to
    }

    enum CodingKeys: String, CodingKey {
        case id = "offers_id"
        case title = "offers_title"
        case mainNumber = "offers_main_number"
        case additionalNumber = "offers_additional_number"
        case discount = "offers_discount"
        case type = "offers_type"
        case from = "offers_from"
        case to = "offers_to"
    }
}

public struct ProductTagTranslationDTO: Decodable, Sendable {
    public let id: Int?
    public let locale: String?
    public let name: String?
    public let normalizedName: String?

    public init(
        id: Int? = nil,
        locale: String? = nil,
        name: String? = nil,
        normalizedName: String? = nil
    ) {
        self.id = id
        self.locale = locale
        self.name = name
        self.normalizedName = normalizedName
    }

    enum CodingKeys: String, CodingKey {
        case id = "tag_translations_id"
        case locale
        case name
        case normalizedName = "normalized_name"
    }
}

public struct ProductTagDTO: Decodable, Sendable {
    public let id: Int
    public let name: String?
    public let normalizedName: String?
    public let translations: [ProductTagTranslationDTO]?

    public init(
        id: Int,
        name: String? = nil,
        normalizedName: String? = nil,
        translations: [ProductTagTranslationDTO]? = nil
    ) {
        self.id = id
        self.name = name
        self.normalizedName = normalizedName
        self.translations = translations
    }

    enum CodingKeys: String, CodingKey {
        case id
        case tagsId = "tags_id"
        case name
        case normalizedName = "normalized_name"
        case translations
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try container.decodeIfPresent(Int.self, forKey: .id) {
            self.id = id
        } else if let tagsId = try container.decodeIfPresent(Int.self, forKey: .tagsId) {
            self.id = tagsId
        } else {
            self.id = 0
        }
        let translations = try container.decodeIfPresent([ProductTagTranslationDTO].self, forKey: .translations)
        self.translations = translations
        let directName = try container.decodeIfPresent(String.self, forKey: .name)
        self.name = directName ?? translations?.first(where: { $0.name?.isEmpty == false })?.name
        self.normalizedName = try container.decodeIfPresent(String.self, forKey: .normalizedName)
    }
}

public struct ProductFilterIdsDTO: Decodable, Sendable {
    public let offersIds: [Int]?
    public let brandsIds: [Int]?
    public let choicesIds: [Int]?
    public let tagsIds: [Int]?

    public init(
        offersIds: [Int]? = nil,
        brandsIds: [Int]? = nil,
        choicesIds: [Int]? = nil,
        tagsIds: [Int]? = nil
    ) {
        self.offersIds = offersIds
        self.brandsIds = brandsIds
        self.choicesIds = choicesIds
        self.tagsIds = tagsIds
    }

    enum CodingKeys: String, CodingKey {
        case offersIds = "offers_ids"
        case brandsIds = "brands_ids"
        case choicesIds = "choices_ids"
        case tagsIds = "tags_ids"
    }
}

public struct ProductItemDTO: Decodable, Sendable {
    public let id: Int
    public let categoryId: Int?
    public let code: String?
    public let barcode: String?
    public let img: String?
    public let video: String?
    public let price: Double
    public let priceAfterDiscount: Double?
    public let available: String?
    public let status: String?
    public let points: Int?
    public let pointsValue: Double?
    public let stocks: Int?
    public let rating: String?
    public let title: String
    public let desc: String?
    public let slug: String
    public let type: String?
    public let lowestWeightAvailable: Double?
    public let isFav: Int?
    public let isNotify: Int?
    public let isNew: Int?
    public let mostWanted: Int?
    public let hasChoices: Bool?
    public let category: ProductCategoryDTO?
    public let offer: ProductOfferDTO?
    public let tags: [ProductTagDTO]?
    public let yourCountryIsExcluded: Int?

    public init(
        id: Int,
        categoryId: Int? = nil,
        code: String? = nil,
        barcode: String? = nil,
        img: String? = nil,
        video: String? = nil,
        price: Double,
        priceAfterDiscount: Double? = nil,
        available: String? = nil,
        status: String? = nil,
        points: Int? = nil,
        pointsValue: Double? = nil,
        stocks: Int? = nil,
        rating: String? = nil,
        title: String,
        desc: String? = nil,
        slug: String,
        type: String? = nil,
        lowestWeightAvailable: Double? = nil,
        isFav: Int? = nil,
        isNotify: Int? = nil,
        isNew: Int? = nil,
        mostWanted: Int? = nil,
        hasChoices: Bool? = nil,
        category: ProductCategoryDTO? = nil,
        offer: ProductOfferDTO? = nil,
        tags: [ProductTagDTO]? = nil,
        yourCountryIsExcluded: Int? = nil
    ) {
        self.id = id
        self.categoryId = categoryId
        self.code = code
        self.barcode = barcode
        self.img = img
        self.video = video
        self.price = price
        self.priceAfterDiscount = priceAfterDiscount
        self.available = available
        self.status = status
        self.points = points
        self.pointsValue = pointsValue
        self.stocks = stocks
        self.rating = rating
        self.title = title
        self.desc = desc
        self.slug = slug
        self.type = type
        self.lowestWeightAvailable = lowestWeightAvailable
        self.isFav = isFav
        self.isNotify = isNotify
        self.isNew = isNew
        self.mostWanted = mostWanted
        self.hasChoices = hasChoices
        self.category = category
        self.offer = offer
        self.tags = tags
        self.yourCountryIsExcluded = yourCountryIsExcluded
    }

    enum CodingKeys: String, CodingKey {
        case id = "products_id"
        case categoryId = "FK_categories_id"
        case code = "products_code"
        case barcode = "products_barcode"
        case img = "products_img"
        case video = "products_video"
        case price = "products_price"
        case priceAfterDiscount = "products_price_after_discount"
        case available = "products_available"
        case status = "products_status"
        case points = "products_points"
        case pointsValue = "products_points_value"
        case stocks = "products_stocks"
        case rating = "products_rating"
        case title = "products_title"
        case desc = "products_desc"
        case slug = "products_slug"
        case type = "products_type"
        case lowestWeightAvailable = "products_lowest_weight_available"
        case isFav = "is_fav"
        case isNotify = "is_notify"
        case isNew = "is_new"
        case mostWanted = "most_wanted"
        case hasChoices = "has_choices"
        case category
        case offer
        case tags
        case yourCountryIsExcluded = "your_country_is_excluded"
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try c.decode(Int.self, forKey: .id)
        self.categoryId = try c.decodeIfPresent(Int.self, forKey: .categoryId)
        self.code = try c.decodeIfPresent(String.self, forKey: .code)
        self.barcode = try c.decodeIfPresent(String.self, forKey: .barcode)
        self.img = try c.decodeIfPresent(String.self, forKey: .img)
        self.video = try c.decodeIfPresent(String.self, forKey: .video)
        self.price = try c.decodeFlexibleDouble(forKey: .price)
        self.priceAfterDiscount = try c.decodeFlexibleDoubleIfPresent(forKey: .priceAfterDiscount)
        self.available = try c.decodeIfPresent(String.self, forKey: .available)
        self.status = try c.decodeIfPresent(String.self, forKey: .status)
        self.points = try c.decodeIfPresent(Int.self, forKey: .points)
        self.pointsValue = try c.decodeFlexibleDoubleIfPresent(forKey: .pointsValue)
        self.stocks = try c.decodeIfPresent(Int.self, forKey: .stocks)
        self.rating = try c.decodeIfPresent(String.self, forKey: .rating)
        self.title = try c.decode(String.self, forKey: .title)
        self.desc = try c.decodeIfPresent(String.self, forKey: .desc)
        self.slug = try c.decode(String.self, forKey: .slug)
        self.type = try c.decodeIfPresent(String.self, forKey: .type)
        self.lowestWeightAvailable = try c.decodeFlexibleDoubleIfPresent(forKey: .lowestWeightAvailable)
        self.isFav = try c.decodeIfPresent(Int.self, forKey: .isFav)
        self.isNotify = try c.decodeIfPresent(Int.self, forKey: .isNotify)
        self.isNew = try c.decodeIfPresent(Int.self, forKey: .isNew)
        self.mostWanted = try c.decodeIfPresent(Int.self, forKey: .mostWanted)
        self.hasChoices = try c.decodeIfPresent(Bool.self, forKey: .hasChoices)
        self.category = try c.decodeIfPresent(ProductCategoryDTO.self, forKey: .category)
        self.offer = try c.decodeIfPresent(ProductOfferDTO.self, forKey: .offer)
        self.tags = try c.decodeIfPresent([ProductTagDTO].self, forKey: .tags)
        self.yourCountryIsExcluded = try c.decodeIfPresent(Int.self, forKey: .yourCountryIsExcluded)
    }
}

public struct ProductsResponseDTO: Decodable, Sendable {
    public let products: [ProductItemDTO]
    public let pagination: PaginationDTO?
    public let min: String?
    public let max: String?
    public let filterIds: ProductFilterIdsDTO?
    public let selectedCategory: ProductCategoryDTO?

    public init(
        products: [ProductItemDTO],
        pagination: PaginationDTO? = nil,
        min: String? = nil,
        max: String? = nil,
        filterIds: ProductFilterIdsDTO? = nil,
        selectedCategory: ProductCategoryDTO? = nil
    ) {
        self.products = products
        self.pagination = pagination
        self.min = min
        self.max = max
        self.filterIds = filterIds
        self.selectedCategory = selectedCategory
    }

    enum CodingKeys: String, CodingKey {
        case products
        case pagination
        case min
        case max
        case filterIds
        case selectedCategory = "selected_category"
    }
}
