//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 21/10/2026.
//
import Core
import SwiftUI



@MainActor
public struct CurrencyLabel: View {
    
    let code: String
    
    init(for currency: CurrencyConfig) {
        self.code = currency.code
    }
    public  var body: some View {
        if  code.uppercased() == "SAR" {
            Image("saudi-riyal", bundle: .module)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 14)
        } else {
            Text(code)
        }
    }
}

@MainActor
public struct CompinnedTextPrice: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.currencyConfig) private var envCurrency
    
    let amount: Double
    let isLeading: Bool
    let currency: CurrencyConfig
    let font: Font
    let color: Color
    var isStruckThrough: Bool = false
    
    public static func format(amount: Double) -> String {
        let formattedNumber = String(format: "%.2f", amount)
        
        return formattedNumber
    }
    
    
    public var body: some View {
        HStack {
            if  isLeading {
                CurrencyLabel(for: currency)
                Text(Self.format(amount: amount))
            } else {
                
                Text(Self.format(amount: amount))
                CurrencyLabel(for: currency)
            }
        }
        .font(font)
        .foregroundStyle(color)
        .strikethrough(isStruckThrough, color: color)
    }
}



@MainActor
public struct PriceView: View {
    
    @Environment(\.appTheme) private var theme
    @Environment(\.currencyConfig) private var envCurrency
    
    let amount: Double
    let originalAmount: Double?
    let currency: CurrencyConfig?
    
    public init(
        amount: Double,
        originalAmount: Double? = nil,
        currency: CurrencyConfig? = nil
    ) {
        self.amount = amount
        self.originalAmount = originalAmount
        self.currency = currency
    }
    
    private var activeCurrency: CurrencyConfig {
        currency ?? envCurrency
    }
    
    
    
    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            CompinnedTextPrice(
                amount: amount,
                isLeading: activeCurrency.isLeading,
                currency: activeCurrency,
                font: theme.typography.price,
                color: theme.primary
            )
            .font(theme.typography.price)
            .foregroundStyle(theme.primary)
            if let originalAmount, originalAmount > amount {
                CompinnedTextPrice(
                    amount: originalAmount,
                    isLeading: activeCurrency.isLeading,
                    currency: activeCurrency,
                    font: theme.typography.subheadline,
                    color: theme.textSecondary,
                    isStruckThrough: true
                )
                .font(theme.typography.subheadline)
                .foregroundStyle(theme.textSecondary)
                .strikethrough(true, color: theme.textSecondary)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CurrencyLabel(for: .default)
        // Standard price
        PriceView(amount: 150.00)
        
        // Discounted price
        PriceView(amount: 120.00, originalAmount: 180.00)
        
        // Leading currency override
        PriceView(
            amount: 99.99,
            originalAmount: 129.99,
            currency: CurrencyConfig(code: "$", isLeading: true)
        )
    }
    .padding()
}
