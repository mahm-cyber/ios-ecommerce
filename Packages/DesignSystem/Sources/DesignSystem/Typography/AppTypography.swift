import SwiftUI

public struct AppTypography: Sendable, Equatable {
    /// 34pt, bold, scales relative to `.largeTitle`
    public let largeTitle: Font
    /// 28pt, bold, scales relative to `.title`
    public let title1: Font
    /// 22pt, bold, scales relative to `.title2`
    public let title2: Font
    /// 20pt, semibold, scales relative to `.title3`
    public let title3: Font
    /// 17pt, semibold, scales relative to `.headline`
    public let headline: Font
    /// 17pt, regular, scales relative to `.body`
    public let body: Font
    /// 15pt, regular, scales relative to `.subheadline`
    public let subheadline: Font
    /// 12pt, regular, scales relative to `.caption`
    public let caption: Font
    /// 17pt, bold, monospaced digits, scales relative to `.headline`
    public let price: Font

    public init(
        largeTitle: Font = .system(.largeTitle, design: .default, weight: .bold),
        title1: Font = .system(.title, design: .default, weight: .bold),
        title2: Font = .system(.title2, design: .default, weight: .bold),
        title3: Font = .system(.title3, design: .default, weight: .semibold),
        headline: Font = .system(.headline, design: .default, weight: .semibold),
        body: Font = .system(.body, design: .default, weight: .regular),
        subheadline: Font = .system(.subheadline, design: .default, weight: .regular),
        caption: Font = .system(.caption, design: .default, weight: .regular),
        price: Font = .system(.headline, design: .default, weight: .bold).monospacedDigit()
    ) {
        self.largeTitle = largeTitle
        self.title1 = title1
        self.title2 = title2
        self.title3 = title3
        self.headline = headline
        self.body = body
        self.subheadline = subheadline
        self.caption = caption
        self.price = price
    }

    /// Default typography system using Apple's system font with Dynamic Type scaling.
    public static let `default` = AppTypography()
}
