//
//  File.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import Foundation
import Core
import SwiftUI

private struct AppImageURLBuilderKey: EnvironmentKey {
    static let defaultValue: ImageURLBuilder = .default
}


extension EnvironmentValues {
    public var imageURLBuilder: ImageURLBuilder {
        get { self[AppImageURLBuilderKey.self] }
        set { self[AppImageURLBuilderKey.self] = newValue }
    }
}


extension View {
    public func imageURLBuilder(_ imageURLBuilder: ImageURLBuilder) -> some View {
        environment(\.imageURLBuilder, imageURLBuilder)
    }
}
