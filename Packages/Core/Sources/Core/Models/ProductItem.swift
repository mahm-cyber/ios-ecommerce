//
//  File.swift
//  Core
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation

public struct ProductItem: Sendable, Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let price: Double
    public let salePrice: Double?
    public let discountPercentage: String?
    public let imageURL: String?
    public let isFavorite: Bool?
    public let isOutOfStock: Bool?
    public let rating: String?
    public let category: CategoryItem?

    
    public init(
        id: Int,
        name: String,
        price: Double,
        salePrice: Double? = nil,
        discountPercentage: String? = nil,
        imageURL: String? = nil,
        isFavorite: Bool? = nil,
        isOutOfStock: Bool? = nil,
        rating: String? = nil,
        category: CategoryItem? = nil
    ) {
        self.id = id
        self.name = name
        self.price = price
        self.salePrice = salePrice
        self.discountPercentage = discountPercentage
        self.imageURL = imageURL
        self.isFavorite = isFavorite
        self.isOutOfStock = isOutOfStock
        self.rating = rating
        self.category = category
    }
    
}

extension ProductItem {
    public static let example = ProductItem(
        id: 8260,
        name: "Dr. Melaxin Calcium Bonding Serum (80ml)",
        price: 133.37,
        salePrice: 110.00,
        discountPercentage: "خد ٢ + ١ هديه",
        imageURL: "Rectangle 123.webp",
        isFavorite: true,
        isOutOfStock: false,
        rating: "8.10",
        category: .example
        
    )

    public static let examples: [ProductItem] = [
        ProductItem(
            id: 8260,
            name: "Dr. Melaxin Calcium Bonding Serum for Skin Tightening (80ml)",
            price: 133.37,
            salePrice: 110.00,
            discountPercentage: "خد ٢ + ١ هديه",
            imageURL: "Rectangle 123.webp",
            isFavorite: true,
            isOutOfStock: false,
            rating: "8.10",
            category: .example
        ),
        ProductItem(
            id: 8257,
            name: "Medicube PDRN Collagen Glow Jelly Serum (30ml)",
            price: 117.00,
            salePrice: nil,
            discountPercentage: nil,
            imageURL: "Rectangle 122.webp",
            isFavorite: false,
            isOutOfStock: false,
            rating: "3.10",
            category: .example
        ),
        ProductItem(
            id: 8258,
            name: "Medicube Vitamin C Brightening Serum Capsules (30ml)",
            price: 137.00,
            salePrice: nil,
            discountPercentage: nil,
            imageURL: "Rectangle 125.webp",
            isFavorite: false,
            isOutOfStock: false,
            rating: "8.90",
            category: .example
        ),
        ProductItem(
            id: 8261,
            name: "Dr. Althea Foaming Serum for Radiance",
            price: 234.00,
            salePrice: 199.00,
            discountPercentage: "15%",
            imageURL: "Rectangle 126.webp",
            isFavorite: true,
            isOutOfStock: true,
            rating: "9.20",
            category: .example
        )
    ]
}
