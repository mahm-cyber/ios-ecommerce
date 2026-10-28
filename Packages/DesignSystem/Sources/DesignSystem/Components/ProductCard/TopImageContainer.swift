//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI

struct TopImageContainer: View {
    @Environment(\.appTheme) private var theme
    let imageName: String?
    let isFav: Bool
    let onTapFavButton: @Sendable () -> Void
    let onTapAddToCart: @Sendable () -> Void
    
    
    private var productTheme: ProductCardTheme {
        theme.product
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 1. Single wavy container with subtle border
            BrandCardShape()
                .fill(productTheme.background)
                .overlay(
                    BrandCardShape()
                        .stroke(productTheme.border, lineWidth: 1.5)
                )
            
            // 2. Product Image clipped to the same wavy shape and scaled down
            AppAPIImage(imageName, folderName: .products, folderType: .original)
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(BrandCardShape())
                .scaleEffect(0.95)
            
            // 3. Heart Button (Top Trailing)
            Button(action: onTapFavButton) {
                Image(systemName: isFav ? "heart.fill" : "heart")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(isFav ? productTheme.favorite : productTheme.unfavorite)
                    .frame(width: 34, height: 34)
                    .background(Circle().fill(productTheme.favoriteBackground))
            }
            .padding(8)
            
            // 4. Plus Button (Bottom Leading)
            Button(action: onTapAddToCart) {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(productTheme.onAddToCart)
                    .frame(width: 34, height: 34)
                    .background(Circle().fill(productTheme.addToCartBackground))
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomLeading
            )
            .padding(8)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    TopImageContainer(
        imageName: "https://polaris-max.nmait.net/uploads/28/products/original/Rectangle 123.webp",
        isFav: true) {
            
        } onTapAddToCart: {
            
        }
        .padding()
}
