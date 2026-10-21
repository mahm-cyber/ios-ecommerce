import SwiftUI
import Testing
@testable import DesignSystem

@Suite("Color Hex Parsing Tests")
struct ColorHexTests {

    @Test("Parses standard 6-digit hex with hash prefix")
    func parseSixDigitWithHash() {
        let color = Color(hex: "#FF8000")
        #expect(color != nil)

        if let resolved = color?.resolve(in: EnvironmentValues()) {
            #expect(abs(resolved.red - (255.0 / 255.0)) < 0.01)
            #expect(abs(resolved.green - (128.0 / 255.0)) < 0.01)
            #expect(abs(resolved.blue - (0.0 / 255.0)) < 0.01)
            #expect(abs(resolved.opacity - 1.0) < 0.01)
        }
    }

    @Test("Parses 6-digit hex without hash prefix")
    func parseSixDigitWithoutHash() {
        let color = Color(hex: "00FF00")
        #expect(color != nil)

        if let resolved = color?.resolve(in: EnvironmentValues()) {
            #expect(abs(resolved.red - 0.0) < 0.01)
            #expect(abs(resolved.green - 1.0) < 0.01)
            #expect(abs(resolved.blue - 0.0) < 0.01)
            #expect(abs(resolved.opacity - 1.0) < 0.01)
        }
    }

    @Test("Parses lowercase 6-digit hex and handles whitespace")
    func parseLowercaseAndWhitespace() {
        let color = Color(hex: "  #e06b09 \n")
        #expect(color != nil)

        if let resolved = color?.resolve(in: EnvironmentValues()) {
            #expect(abs(resolved.red - (224.0 / 255.0)) < 0.01)
            #expect(abs(resolved.green - (107.0 / 255.0)) < 0.01)
            #expect(abs(resolved.blue - (9.0 / 255.0)) < 0.01)
            #expect(abs(resolved.opacity - 1.0) < 0.01)
        }
    }

    @Test("Parses 8-digit hex with alpha channel (RRGGBBAA)")
    func parseEightDigitWithAlpha() {
        let color = Color(hex: "#00000080")
        #expect(color != nil)

        if let resolved = color?.resolve(in: EnvironmentValues()) {
            #expect(abs(resolved.red - 0.0) < 0.01)
            #expect(abs(resolved.green - 0.0) < 0.01)
            #expect(abs(resolved.blue - 0.0) < 0.01)
            #expect(abs(resolved.opacity - (128.0 / 255.0)) < 0.02)
        }
    }

    @Test("Returns nil for malformed or invalid inputs")
    func invalidInputsReturnNil() {
        #expect(Color(hex: "") == nil)
        #expect(Color(hex: "#") == nil)
        #expect(Color(hex: "123") == nil)
        #expect(Color(hex: "#12345") == nil)
        #expect(Color(hex: "#GGGGGG") == nil)
        #expect(Color(hex: "not-a-color") == nil)
        #expect(Color(hex: "#123456789") == nil)
    }

    @Test("Fallback initializer returns parsed color when valid")
    func fallbackInitializerWithValidHex() {
        let color = Color(hex: "#FF0000", fallback: .blue)
        let resolved = color.resolve(in: EnvironmentValues())
        #expect(abs(resolved.red - 1.0) < 0.01)
        #expect(abs(resolved.blue - 0.0) < 0.01)
    }

    @Test("Fallback initializer returns fallback color when invalid")
    func fallbackInitializerWithInvalidHex() {
        let fallback = Color.blue
        let color = Color(hex: "invalid-hex", fallback: fallback)
        let resolvedColor = color.resolve(in: EnvironmentValues())
        let resolvedFallback = fallback.resolve(in: EnvironmentValues())

        #expect(resolvedColor.red == resolvedFallback.red)
        #expect(resolvedColor.green == resolvedFallback.green)
        #expect(resolvedColor.blue == resolvedFallback.blue)
        #expect(resolvedColor.opacity == resolvedFallback.opacity)
    }
}
