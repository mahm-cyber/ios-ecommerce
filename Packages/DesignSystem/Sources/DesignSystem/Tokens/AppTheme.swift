import SwiftUI
import Core

public struct AppTheme: Sendable, Equatable {
    public let primary: Color
    public let background: Color
    public let surface: Color
    public let textPrimary: Color
    public let textSecondary: Color
    public let border: Color
    public let error: Color
    public let success: Color
    public let typography: AppTypography
    public let categoryCardTheme: CategoryCardTheme
    public let text: TextTheme
    public let product: ProductCardTheme

    public init(
        primary: Color,
        background: Color = Color(hex: "#F9F9F9", fallback: Color(white: 0.98)),
        surface: Color = .white,
        textPrimary: Color = Color(hex: "#0D0D0D", fallback: .black),
        textSecondary: Color = Color(hex: "#6B6B6B", fallback: .gray),
        border: Color = Color(hex: "#D2D2D2", fallback: Color(white: 0.82)),
        error: Color = Color(hex: "#DB0B0B", fallback: .red),
        success: Color = Color(hex: "#118C4A", fallback: .green),
        typography: AppTypography = .default,
        categoryCardTheme: CategoryCardTheme = .default,
        text: TextTheme = TextTheme(),
        product: ProductCardTheme = .default
        
    ) {
        self.primary = primary
        self.background = background
        self.surface = surface
        self.textPrimary = textPrimary
        self.textSecondary = textSecondary
        self.border = border
        self.error = error
        self.success = success
        self.typography = typography
        self.categoryCardTheme = categoryCardTheme
        self.text = text
        self.product = product
    }

    public init(
        themeConfig: ThemeConfig,
        fallbackTheme: AppTheme = .default,
        textTheme: TextTheme = TextTheme()
    ) {
        let primaryColor: Color
        if let hex = themeConfig.primaryColorHex, let parsed = Color(hex: hex) {
            primaryColor = parsed
        } else {
            primaryColor = fallbackTheme.primary
        }
        let categoryCardTheme = CategoryCardTheme(
            background: Color(hex: "#EEEBEF", fallback: .gray),
            activeBackground: primaryColor,
            title:  textTheme.primary,
            subTitle:  textTheme.secondary
        )
        
        let product = ProductCardTheme(
            background: fallbackTheme.surface,
            imageBackground: Color(hex: "#EEEBEF", fallback: .gray),
            title: textTheme.primary,
            category: textTheme.secondary,
            favorite: Color(hex: "#FF383C", fallback: .red),
            unfavorite: Color(hex: "#868483", fallback: .gray),
            favoriteBackground:  Color(hex: "#F5F5F5", fallback: .gray),
            addToCartBackground: Color(hex: "#F5F5F5", fallback: .gray),
            onAddToCart: primaryColor,
            rate: Color(hex: "#FEBC2F", fallback: .yellow)
        )

        self.init(
            primary: primaryColor,
            background: fallbackTheme.background,
            surface: fallbackTheme.surface,
            textPrimary: fallbackTheme.textPrimary,
            textSecondary: fallbackTheme.textSecondary,
            border: fallbackTheme.border,
            error: fallbackTheme.error,
            success: fallbackTheme.success,
            categoryCardTheme: categoryCardTheme,
            product: product
        )
    }

    public static let `default` = AppTheme(
        primary: Color(hex: "#E06B09", fallback: .orange),
        background: Color(hex: "#F9F9F9", fallback: Color(white: 0.98)),
        surface: .white,
        textPrimary: Color(hex: "#0D0D0D", fallback: .black),
        textSecondary: Color(hex: "#6B6B6B", fallback: .gray),
        border: Color(hex: "#D2D2D2", fallback: Color(white: 0.82)),
        error: Color(hex: "#DB0B0B", fallback: .red),
        success: Color(hex: "#118C4A", fallback: .green),
        categoryCardTheme: .default,
        text: TextTheme()
    )
}
