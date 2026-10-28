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
    public let folderName: ImageFolderName
    public let folderType: ImageFolderType
    
    
    public init(
        _ imageName: String?,
        folderName: ImageFolderName = .generalImages,
        folderType: ImageFolderType = .original,
    ) {
        self.imageName = imageName
        self.folderName = folderName
        self.folderType = folderType
    }
    
    public var body: some View {
        if let imageName = imageName, let url = imageURLBuilder.buildURL(
            image: imageName,
            folderName: folderName,
            folderType: folderType
        ) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .empty:
                    ProgressView()
                case .failure:
                    thumbnailFallback
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            thumbnailFallback
        }
    }
    
    private var thumbnailFallback: some View {
        ZStack {
            theme.border.opacity(0.12)
            Image(systemName: "photo")
                .font(.system(size: 20))
                .foregroundStyle(theme.textSecondary.opacity(0.4))
        }
    }
}

#Preview {
    AppAPIImage("https://pixabay.com/photos/flycatcher-bird-animal-photography-9684912/")
}
