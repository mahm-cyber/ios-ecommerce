import SwiftUI
import Core
import DesignSystem

public struct FAQItemRow: View {
    @Environment(\.appTheme) private var theme

    let item: FAQItem
    let isExpanded: Bool
    let onToggle: () -> Void

    public init(
        item: FAQItem,
        isExpanded: Bool,
        onToggle: @escaping () -> Void
    ) {
        self.item = item
        self.isExpanded = isExpanded
        self.onToggle = onToggle
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: onToggle) {
                HStack(alignment: .center, spacing: 12) {
                    Text(item.question)
                        .font(theme.typography.headline)
                        .foregroundStyle(theme.textPrimary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(theme.textSecondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .contentShape(Rectangle())
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
            }
            .buttonStyle(.plain)

            if isExpanded {
                Text(item.answer)
                    .font(theme.typography.body)
                    .foregroundStyle(theme.textSecondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
        }
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(theme.border, lineWidth: 1)
        }
        .animation(.easeInOut(duration: 0.2), value: isExpanded)
    }
}

#Preview {
    VStack(spacing: 12) {
        FAQItemRow(
            item: FAQItem(
                id: 1,
                question: "How long does delivery take?",
                answer: "Standard delivery takes between 2 to 4 business days."
            ),
            isExpanded: true,
            onToggle: {}
        )
        FAQItemRow(
            item: FAQItem(
                id: 2,
                question: "Can I return an item?",
                answer: "Yes, within 14 days of receiving your order."
            ),
            isExpanded: false,
            onToggle: {}
        )
    }
    .padding()
}
