import SwiftUI
import Core

public struct ProductCardTheme: Sendable, Equatable {
    public let background: Color
    public let imageBackground: Color
    public let title: Color
    public let category: Color
    public let favorite: Color
    public let unfavorite: Color
    public let favoriteBackground: Color
    public let addToCartBackground: Color
    public let onAddToCart: Color
    public let rate: Color
    
    
    public init(
        background: Color,
        imageBackground: Color,
        title: Color,
        category: Color,
        favorite: Color,
        unfavorite: Color,
        favoriteBackground: Color,
        addToCartBackground: Color,
        onAddToCart: Color,
        rate: Color
    ) {
        self.background = background
        self.imageBackground = imageBackground
        self.title = title
        self.category = category
        self.favorite = favorite
        self.unfavorite = unfavorite
        self.favoriteBackground = favoriteBackground
        self.addToCartBackground = addToCartBackground
        self.onAddToCart = onAddToCart
        self.rate = rate
    }
    
    
    
    
    public static let `default` = ProductCardTheme(
        background: .clear,
        imageBackground: .clear,
        title: .clear,
        category: .clear,
        favorite: .clear,
        unfavorite: .clear,
        favoriteBackground: .clear,
        addToCartBackground: .clear,
        onAddToCart: .clear,
        rate: .clear
    )
}
