import SwiftUI
import Testing
import Core
@testable import DesignSystem

@Suite("AppTheme Tests")
struct AppThemeTests {

    @Test("Default theme uses Cuddluxe orange as primary")
    func defaultThemeValues() {
        let theme = AppTheme.default
        let resolvedPrimary = theme.primary.resolve(in: EnvironmentValues())
        let expectedPrimary = Color(hex: "#E06B09")!.resolve(in: EnvironmentValues())

        #expect(abs(resolvedPrimary.red - expectedPrimary.red) < 0.01)
        #expect(abs(resolvedPrimary.green - expectedPrimary.green) < 0.01)
        #expect(abs(resolvedPrimary.blue - expectedPrimary.blue) < 0.01)
    }

    @Test("AppTheme initializes from ThemeConfig with valid hex")
    func initFromValidThemeConfig() {
        let config = ThemeConfig(
            themeName: "theme4",
            primaryColorHex: "#3D57F2",
            logoURL: "https://example.com/logo.png"
        )
        let theme = AppTheme(themeConfig: config)
        let resolvedPrimary = theme.primary.resolve(in: EnvironmentValues())
        let expectedPrimary = Color(hex: "#3D57F2")!.resolve(in: EnvironmentValues())

        #expect(abs(resolvedPrimary.red - expectedPrimary.red) < 0.01)
        #expect(abs(resolvedPrimary.green - expectedPrimary.green) < 0.01)
        #expect(abs(resolvedPrimary.blue - expectedPrimary.blue) < 0.01)

        // Other tokens retain default palette
        #expect(theme.surface == AppTheme.default.surface)
        #expect(theme.textPrimary == AppTheme.default.textPrimary)
    }

    @Test("AppTheme falls back to default primary when ThemeConfig hex is nil")
    func initFromNilHexThemeConfig() {
        let config = ThemeConfig(
            themeName: "theme4",
            primaryColorHex: nil,
            logoURL: nil
        )
        let theme = AppTheme(themeConfig: config)
        let resolvedPrimary = theme.primary.resolve(in: EnvironmentValues())
        let expectedDefault = AppTheme.default.primary.resolve(in: EnvironmentValues())

        #expect(abs(resolvedPrimary.red - expectedDefault.red) < 0.01)
        #expect(abs(resolvedPrimary.green - expectedDefault.green) < 0.01)
        #expect(abs(resolvedPrimary.blue - expectedDefault.blue) < 0.01)
    }

    @Test("AppTheme falls back to default primary when ThemeConfig hex is invalid")
    func initFromInvalidHexThemeConfig() {
        let config = ThemeConfig(
            themeName: "theme4",
            primaryColorHex: "invalid-color-value",
            logoURL: nil
        )
        let theme = AppTheme(themeConfig: config)
        let resolvedPrimary = theme.primary.resolve(in: EnvironmentValues())
        let expectedDefault = AppTheme.default.primary.resolve(in: EnvironmentValues())

        #expect(abs(resolvedPrimary.red - expectedDefault.red) < 0.01)
        #expect(abs(resolvedPrimary.green - expectedDefault.green) < 0.01)
        #expect(abs(resolvedPrimary.blue - expectedDefault.blue) < 0.01)
    }
}
