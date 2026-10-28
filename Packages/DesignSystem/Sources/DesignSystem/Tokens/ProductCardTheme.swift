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
    public let border: Color
    public let price: Color
    
    
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
        rate: Color,
        border: Color = Color(hex: "#EEEBEF", fallback: Color(white: 0.94)),
        price: Color = Color(hex: "#090807", fallback: .black)
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
        self.border = border
        self.price = price
    }
    
    
    
    
    // In ProductCardTheme.swift:
    public static let `default` = ProductCardTheme(
        background: .white,
        imageBackground: Color(hex: "#EEEBEF", fallback: Color(white: 0.94)),
        title: Color(hex: "#090807", fallback: .black),
        category: Color(hex: "#868483", fallback: .gray),
        favorite: Color(hex: "#FF383C", fallback: .red),
        unfavorite: Color(hex: "#868483", fallback: .gray),
        favoriteBackground: Color(hex: "#F5F5F5", fallback: Color(white: 0.96)),
        addToCartBackground: Color(hex: "#F5F5F5", fallback: Color(white: 0.96)),
        onAddToCart: Color(hex: "#59315C", fallback: .purple),
        rate: Color(hex: "#FEBC2F", fallback: .yellow),
        border: Color(hex: "#EEEBEF", fallback: Color(white: 0.94)),
        price: Color(hex: "#090807", fallback: .black)
    )
}
