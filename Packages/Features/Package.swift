// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "FAQFeature",
            targets: ["FAQFeature"]
        ),
        .library(
            name: "CategoriesFeature",
            targets: ["CategoriesFeature"]
        ),
        .library(
            name: "ProductsFeature",
            targets: ["ProductsFeature"]
        ),
        .library(
            name: "ProductDetailFeature",
            targets: ["ProductDetailFeature"]
        )
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Data", path: "../Data"),
        .package(name: "DesignSystem", path: "../DesignSystem")
    ],
    targets: [
        // MARK: FAQ
        .target(
            name: "FAQFeature",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Data", package: "Data"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "FAQFeatureTests",
            dependencies: ["FAQFeature"]
        ),
        
        // MARK: Categories
        .target(
            name: "CategoriesFeature",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Data", package: "Data"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "CategoriesFeatureTests",
            dependencies: ["CategoriesFeature"]
        ),

        // MARK: Products
        .target(
            name: "ProductsFeature",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Data", package: "Data"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "ProductsFeatureTests",
            dependencies: ["ProductsFeature"]
        ),

        // MARK: ProductDetail
        .target(
            name: "ProductDetailFeature",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Data", package: "Data"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "ProductDetailFeatureTests",
            dependencies: ["ProductDetailFeature"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
