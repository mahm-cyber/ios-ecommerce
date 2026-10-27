//
//  SwiftUIView.swift
//  Features
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import SwiftUI
import Core
import DesignSystem

public  struct SubcategoryRow: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.imageURLBuilder) private var imageURLBuilder
    let title: String
    let imageName: String?
    let onTap: () -> Void
    
    public init(
        title: String,
        imageName: String?,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.imageName = imageName
        self.onTap = onTap
    }
    public  var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(theme.textSecondary.opacity(0.6))
                
                Spacer()
                
                Text(title)
                    .font(theme.typography.headline)
                    .foregroundStyle(theme.textPrimary)
                
                if let imageName = imageName, let url = imageURLBuilder.buildURL(
                    image: imageName,
                    folderName: .categories,
                    folderType: .thumbnail
                ) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                            
                        case .empty:
                            ProgressView()
                            
                        case  .failure:
                            thumbnailFallback
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    thumbnailFallback
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(theme.surface)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        theme.border.opacity(0.5), lineWidth: 1
                    )
            }
        }
        .buttonStyle(.plain)
    }
    
    private var thumbnailFallback: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(theme.border.opacity(0.3))
            .frame(width: 44, height: 44)
            .overlay {
                Image(systemName: "photo")
                    .font(.system(size: 16))
                    .foregroundStyle(theme.textSecondary)
            }
    }
}

#Preview {
    VStack(spacing: 8) {
        SubcategoryRow(
            title: "السيرومات المرطبة",
            imageName: nil,
            onTap: {}
        )
        SubcategoryRow(
            title: "سيرومات تفتيح البشرة",
            imageName: nil,
            onTap: {}
        )
        SubcategoryRow(
            title: "الكل",
            imageName: nil,
            onTap: {}
        )
    }
    .padding()
}
