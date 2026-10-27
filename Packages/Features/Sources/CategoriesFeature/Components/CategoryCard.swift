//
//  SwiftUIView.swift
//  Features
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import SwiftUI
import Core
import DesignSystem

public struct CategoryCard: View {
    
    @Environment(\.appTheme) private var theme
    @Environment(\.imageURLBuilder) private var imageURLBuilder
    
    let category: CategoryItem
    let isSelected: Bool
    let onTap: () -> Void
    
    public init(
        category: CategoryItem,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) {
        self.category = category
        self.isSelected = isSelected
        self.onTap = onTap
    }
    
    private var categoryTheme: CategoryCardTheme {
        theme.categoryCardTheme
    }
    
    public var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                ZStack {
                  
                    BrandCardShape()
                        .fill(
                            isSelected ?   categoryTheme.activeBackground : categoryTheme.background
                        )
                            .rotationEffect( isSelected ? .degrees(-7) : .zero)
                            .scaleEffect(1.02)
                            .transition(.scale.combined(with: .opacity))
                    
                    
                    BrandCardShape()
                        .fill(theme.surface)
                        .overlay {
                            AppAPIImage(
                                category.imageName,
                                folderName: .categories,
                                folderType: .original
                                
                            )
                        }
                        .clipShape(BrandCardShape())
                        .shadow(
                            color: theme.primary.opacity(0.15),
                            radius: 4,
                            x: 0,
                            y: 2,
                        )
                        .scaleEffect(isSelected ?  1.0 : 0.97)
                         
                }
                .aspectRatio(1, contentMode: .fit)
                .scaleEffect(isSelected ?  0.80 : 1.0)
                
                Text(category.title)
                    .font(theme.typography.headline)
                    .foregroundStyle(categoryTheme.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CategoryCard(
        category: .example,
        isSelected: false
    ) { }
}
