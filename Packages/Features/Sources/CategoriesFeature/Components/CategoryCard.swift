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
    
    public var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(theme.primary.opacity(0.85))
                            .offset(y: 4)
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(theme.surface)
                        .overlay {
                            
                            if let imageName = category.imageName, let url = imageURLBuilder.buildURL(
                                image: imageName,
                                folderName: .categories,
                                folderType: .original
                            )
                                {
                                    AsyncImage(url: url) { phase in
                                    
                                    switch phase {
                                    case .success(let image ):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .foregroundStyle(theme.textSecondary)
                                    case .empty:
                                        ProgressView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            
                            } else
                            {
                                Image(systemName: "photo")
                                    .font(.system(size: 32))
                                    .foregroundStyle(theme.textSecondary)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .aspectRatio(1, contentMode: .fit)
                
                Text(category.title)
                    .font(theme.typography.headline)
                    .foregroundStyle(theme.textPrimary)
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
