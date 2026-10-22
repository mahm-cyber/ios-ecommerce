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
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Data", path: "../Data"),
        .package(name: "DesignSystem", path: "../DesignSystem")
    ],
    targets: [
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
    ],
    swiftLanguageModes: [.v6]
)
