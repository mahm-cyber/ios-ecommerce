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

    public init(
        primary: Color,
        background: Color = Color(hex: "#F9F9F9", fallback: Color(white: 0.98)),
        surface: Color = .white,
        textPrimary: Color = Color(hex: "#0D0D0D", fallback: .black),
        textSecondary: Color = Color(hex: "#6B6B6B", fallback: .gray),
        border: Color = Color(hex: "#D2D2D2", fallback: Color(white: 0.82)),
        error: Color = Color(hex: "#DB0B0B", fallback: .red),
        success: Color = Color(hex: "#118C4A", fallback: .green),
        typography: AppTypography = .default
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
    }

    public init(themeConfig: ThemeConfig, fallbackTheme: AppTheme = .default) {
        let primaryColor: Color
        if let hex = themeConfig.primaryColorHex, let parsed = Color(hex: hex) {
            primaryColor = parsed
        } else {
            primaryColor = fallbackTheme.primary
        }

        self.init(
            primary: primaryColor,
            background: fallbackTheme.background,
            surface: fallbackTheme.surface,
            textPrimary: fallbackTheme.textPrimary,
            textSecondary: fallbackTheme.textSecondary,
            border: fallbackTheme.border,
            error: fallbackTheme.error,
            success: fallbackTheme.success
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
        success: Color(hex: "#118C4A", fallback: .green)
    )
}
