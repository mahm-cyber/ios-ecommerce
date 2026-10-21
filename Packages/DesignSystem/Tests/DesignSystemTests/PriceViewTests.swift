import SwiftUI
import Testing
import Core
@testable import DesignSystem

@MainActor
@Suite("PriceView Tests")
struct PriceViewTests {

    @Test("CompinnedTextPrice formats double amount to two decimal places")
    func amountFormatting() {
        #expect(CompinnedTextPrice.format(amount: 150.0) == "150.00")
        #expect(CompinnedTextPrice.format(amount: 99.9) == "99.90")
        #expect(CompinnedTextPrice.format(amount: 120.456) == "120.46")
    }

    @Test("PriceView initializes with single amount and default nil optionals")
    func singlePriceInitialization() {
        let priceView = PriceView(amount: 120.0)

        #expect(priceView.amount == 120.0)
        #expect(priceView.originalAmount == nil)
        #expect(priceView.currency == nil)
    }

    @Test("PriceView stores original amount for discounts")
    func discountedPriceInitialization() {
        let priceView = PriceView(amount: 120.0, originalAmount: 180.0)

        #expect(priceView.amount == 120.0)
        #expect(priceView.originalAmount == 180.0)
    }

    @Test("PriceView stores explicit currency override")
    func currencyOverrideInitialization() {
        let customCurrency = CurrencyConfig(code: "$", isLeading: true)
        let priceView = PriceView(
            amount: 99.99,
            originalAmount: 129.99,
            currency: customCurrency
        )

        #expect(priceView.currency == customCurrency)
        #expect(priceView.currency?.isLeading == true)
        #expect(priceView.currency?.code == "$")
    }
}
