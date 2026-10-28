//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI
import Core

struct InfoSection: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.currencyConfig) private var envCurrency
    let category: String?
    let title: String
    let rating: String?
    let amount: Double?
    let originalAmount: Double?
    
    private var rate: Double {
        if let rating = rating {
            return Double(rating) ?? 0
        }
        return 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                if let category = category, !category.isEmpty {
                    Text(category)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundStyle(theme.product.category)
                }
                
                Spacer()
                
                if rate > 0 {
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(theme.product.rate)
                        if let rating = rating {
                            Text(rating)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(theme.product.title)
                        }
                    }
                }
            }
            
            // Product title (Max 2 lines)
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundStyle(theme.product.title)
            
            if let amount = amount {
                PriceView(
                    amount: amount,
                    originalAmount: originalAmount,
                    currency: CurrencyConfig(code: envCurrency.code, isLeading: true),
                    color: theme.product.price
                )
            }
        }
    }
}

#Preview {
    InfoSection(
        category: "Skin Care",
        title: "Medicube PDRN Pink Collagen Bubble Ser",
        rating: "0.4",
        amount: 100.0,
        originalAmount: 150.0
    )
    .padding(20)
}
