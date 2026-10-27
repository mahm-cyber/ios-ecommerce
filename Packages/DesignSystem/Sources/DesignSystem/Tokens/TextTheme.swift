//
//  File.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI


public struct TextTheme: Sendable, Equatable {
    public let primary: Color
    public let secondary: Color
    public let tertiary: Color
    public let accent: Color?
    public let onColor: Color
    public let onButton: Color
    
    
    public init(
        primary: Color = Color(hex: "#090807"),
        secondary: Color = Color(hex: "#6F6A6C"),
        tertiary: Color =  Color(hex: "#A6A3A4"),
        accent: Color? = .clear,
        onColor: Color = Color(hex: "#FFFFFF"),
        onButton: Color = Color(hex: "#59315C")
    ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.accent = accent
        self.onColor = onColor
        self.onButton = onButton
    }
    
}
