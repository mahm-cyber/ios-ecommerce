//
//  File.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI
import Core

public struct CategoryCardTheme: Sendable, Equatable {
    public let background: Color
    public  let activeBackground: Color
    public let title: Color
    public let subTitle: Color
    
    
    public init(background: Color, activeBackground: Color, title: Color, subTitle: Color) {
        self.background = background
        self.activeBackground = activeBackground
        self.title = title
        self.subTitle = subTitle
    }
    
    
    public static let `default` = CategoryCardTheme(
        background: Color(hex: "#EEEBEF", fallback: .gray),
        activeBackground: .blue,
        title: Color(hex: "#090807"),
        subTitle: .clear
    )
}
