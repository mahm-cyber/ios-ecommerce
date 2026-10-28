//
//  File.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 21/10/2026.
//

 
import SwiftUI
import Core

private struct CurrencyConfigKey: EnvironmentKey {
    static let defaultValue: CurrencyConfig = .default
}


extension EnvironmentValues {
    
    public var currencyConfig: CurrencyConfig {
        get { self[CurrencyConfigKey.self] }
        set { self[CurrencyConfigKey.self] = newValue }
    }
}

extension View {
    public func currency(_ currency: CurrencyConfig) -> some View {
        environment(\.currencyConfig, currency)
    }
    
    public func currencyConfig(_ currency: CurrencyConfig) -> some View {
        environment(\.currencyConfig, currency)
    }
}
