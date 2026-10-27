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
            // 1. Background Box with Subtle Border
            BrandCardShape()
                .fill(productTheme.imageBackground)
                .overlay {
                    BrandCardShape()
                        .stroke(theme.border.opacity(0.3), lineWidth: 1)
                }
            BrandCardShape()
                .fill(theme.surface)
                .overlay {
                    AppAPIImage(imageName, folderName: .products, folderType: .original)
                        .scaledToFit()
                        .padding(10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .clipShape(BrandCardShape())
           
              
        
            
            Button(action: onTapFavButton) {
                Image(systemName: isFav ? "heart.fill" : "heart")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(
                        isFav ? productTheme.favorite : productTheme
                            .unfavorite)
                    .padding(8)
                    .background(Circle().fill(productTheme.favoriteBackground))
            }
            .padding(10)
            
            Button(action: onTapAddToCart) {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(productTheme.onAddToCart)
                    .padding(8)
            }
            
            .background(productTheme.addToCartBackground)
            .clipShape(RoundedRectangle(cornerRadius: 100))
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomLeading
            )
            .padding(10)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    TopImageContainer(
        imageName: "https://pixabay.com/photos/flycatcher-bird-animal-photography-9684912/",
        isFav: true) {
            
        } onTapAddToCart: {
            
        }
        .padding()
}
