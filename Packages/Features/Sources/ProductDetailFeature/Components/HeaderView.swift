import SwiftUI
import DesignSystem
import Core


struct HeaderView: View {
    @Environment(\.appTheme) private var theme
    let product: ProductItem
    
    var categoryName: String {
        return product.category?.title ?? ""
    }
    
    var typography: AppTypography {
        return theme.typography
    }
    
    var title: String {
        product.name
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(typography.caption)
                .foregroundStyle(theme.textSecondary)
            
           
            HStack {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                
                Spacer()
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(theme.product.rate)
                    if let rating = product.rating {
                        Text(rating)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(theme.product.title)
                    }
                }
            }
      
            PriceView(
                amount: product.salePrice ?? product.price,
                originalAmount: product.salePrice != nil ? product.price : nil
            )
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HeaderView(product: .example)
}
