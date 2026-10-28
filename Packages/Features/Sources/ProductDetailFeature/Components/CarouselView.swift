//
//  CarouselView.swift
//  Features
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import SwiftUI
import DesignSystem
import Core

public struct CarouselView: View {
    let images: [String]

    public init(images: [String]) {
        self.images = images
    }

    public var body: some View {
        TabView {
            ForEach(images, id: \.self) { image in
                AppAPIImage(
                    image,
                    folderName: .products,
                    folderType: .original
                )
                .scaledToFit()
            }
        }
        #if os(iOS)
        .tabViewStyle(.page(indexDisplayMode: .always))
        #endif
        .frame(height: 320)
    }
}

#Preview {
    CarouselView(images: ProductDetail.example.galleryImages)
}
