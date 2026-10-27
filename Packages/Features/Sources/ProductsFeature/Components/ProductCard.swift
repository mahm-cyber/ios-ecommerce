//
//  ProductCard.swift
//  Features
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI
import Core
import DesignSystem

public struct ProductCard: View {
    @Environment(\.appTheme) private var theme
    public let product: ProductItem

    public init(product: ProductItem) {
        self.product = product
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                if let imageURL = product.imageURL {
                    AppAPIImage(imageURL)
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary.opacity(0.15))
                        .aspectRatio(1, contentMode: .fit)
                }

                if product.isFavorite == true {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .padding(8)
                }
            }

            Text(product.name)
                .font(.subheadline)
                .lineLimit(2)

            HStack(spacing: 4) {
                Text(String(format: "%.2f", product.price))
                    .font(.headline)
                    .fontWeight(.bold)

                if let salePrice = product.salePrice {
                    Text(String(format: "%.2f", salePrice))
                        .font(.caption)
                        .strikethrough()
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(8)
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview("Product Card") {
    ProductCard(product: .example)
        .padding()
        .frame(width: 180)
}
