import SwiftUI
import Testing
@testable import DesignSystem

@Suite("AppTypography Tests")
struct AppTypographyTests {

    @Test("Default typography initializes all semantic tokens")
    func defaultTypographyInitializesAllTokens() {
        let typography = AppTypography.default

        // Verify equality between static default and fresh instance
        #expect(typography == AppTypography())

        // Verify all semantic tokens are accessible
        _ = typography.largeTitle
        _ = typography.title1
        _ = typography.title2
        _ = typography.title3
        _ = typography.headline
        _ = typography.body
        _ = typography.subheadline
        _ = typography.caption
        _ = typography.price
    }

    @Test("Custom typography overrides specific tokens while keeping defaults")
    func customTypographyOverridesSpecificTokens() {
        let customHeadline = Font.system(size: 24, weight: .black, design: .serif)
        let customTypography = AppTypography(headline: customHeadline)

        #expect(customTypography.headline == customHeadline)
        #expect(customTypography.headline != AppTypography.default.headline)
        #expect(customTypography.body == AppTypography.default.body)
        #expect(customTypography.price == AppTypography.default.price)
    }

    @Test("AppTheme integrates default typography")
    func appThemeIntegratesDefaultTypography() {
        let theme = AppTheme.default
        #expect(theme.typography == AppTypography.default)
    }

    @Test("AppTheme preserves custom typography when provided")
    func appThemePreservesCustomTypography() {
        let customTypography = AppTypography(
            body: Font.system(size: 19, weight: .light)
        )

        let theme = AppTheme(
            primary: .blue,
            typography: customTypography
        )

        #expect(theme.typography == customTypography)
        #expect(theme.typography.body != AppTypography.default.body)
    }
}
