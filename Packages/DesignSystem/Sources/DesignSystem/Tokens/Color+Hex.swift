import SwiftUI

extension Color {
    /// Initializes a SwiftUI `Color` from a hex string (e.g., `"#RRGGBB"` or `"#RRGGBBAA"`).
    /// Returns `nil` if the string cannot be parsed as a valid 6 or 8 character hex color.
    public init?(hex: String) {
        var formatted = hex.trimmingCharacters(in: .whitespacesAndNewlines)

        if formatted.hasPrefix("#") {
            formatted.removeFirst()
        } else if formatted.hasPrefix("0x") || formatted.hasPrefix("0X") {
            formatted.removeFirst(2)
        }

        guard formatted.count == 6 || formatted.count == 8 else {
            return nil
        }

        var hexNumber: UInt64 = 0
        let scanner = Scanner(string: formatted)
        guard scanner.scanHexInt64(&hexNumber) && scanner.isAtEnd else {
            return nil
        }

        let red, green, blue, opacity: Double

        if formatted.count == 6 {
            red = Double((hexNumber & 0xFF0000) >> 16) / 255.0
            green = Double((hexNumber & 0x00FF00) >> 8) / 255.0
            blue = Double(hexNumber & 0x0000FF) / 255.0
            opacity = 1.0
        } else {
            red = Double((hexNumber & 0xFF000000) >> 24) / 255.0
            green = Double((hexNumber & 0x00FF0000) >> 16) / 255.0
            blue = Double((hexNumber & 0x0000FF00) >> 8) / 255.0
            opacity = Double(hexNumber & 0x000000FF) / 255.0
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    /// Initializes a SwiftUI `Color` from a hex string, using a fallback color if parsing fails.
    public init(hex: String, fallback: Color = .clear) {
        if let color = Color(hex: hex) {
            self = color
        } else {
            self = fallback
        }
    }
}
