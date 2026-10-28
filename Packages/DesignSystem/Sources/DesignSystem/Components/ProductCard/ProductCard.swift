//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI
import Core

public struct ProductCard: View {
    @Environment(\.appTheme) private var theme
    public let product: ProductItem
    
    public init(product: ProductItem) {
        self.product = product
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TopImageContainer(
                imageName: product.imageURL,
                isFav: product.isFavorite == true) {
                    
                } onTapAddToCart: {
                    
                }
            
            
            InfoSection(
                category: product.category?.title,
                title: product.name,
                rating: product.rating, 
                amount: product.salePrice ?? product.price,
                originalAmount: product.salePrice != nil ? product.price : nil
            )
        }
    }
}

#Preview("Product Card") {
    ProductCard(product: .example)
        .padding() 
}
