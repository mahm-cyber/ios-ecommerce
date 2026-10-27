//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI
import Core

public struct AppAPIImage: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.imageURLBuilder) private var imageURLBuilder
    public let imageName: String?
    
    
    public init(_ imageName: String?) {
        self.imageName = imageName
        
    }
    
    public var body: some View {
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
                        .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
                    
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
            .shadow(
                color: Color(hex: "#59315C",fallback: .black).opacity(0.4),
                radius: 2,
                x: 0,
                y: 1
            )
        } else {
            thumbnailFallback
        }
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
    AppAPIImage("https://pixabay.com/photos/flycatcher-bird-animal-photography-9684912/")
}
