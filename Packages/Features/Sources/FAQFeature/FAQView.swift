import SwiftUI
import Core
import Data
import DesignSystem

public struct FAQView: View {
    @Environment(\.appTheme) private var theme
    @State private var viewModel: FAQViewModel

    public init(viewModel: FAQViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    public init(repository: FAQRepository) {
        _viewModel = State(initialValue: FAQViewModel(repository: repository))
    }

    public var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
                    .tint(theme.primary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .empty:
                ContentUnavailableView(
                    "No Questions Found",
                    systemImage: "questionmark.circle",
                    description: Text("There are no frequently asked questions available right now.")
                )

            case .failed(let message):
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundStyle(theme.error)

                    Text("Something Went Wrong")
                        .font(theme.typography.title3)
                        .foregroundStyle(theme.textPrimary)

                    Text(message)
                        .font(theme.typography.body)
                        .foregroundStyle(theme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    AppButton("Try Again", variant: .primary) {
                        Task { await viewModel.load() }
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded(let items):
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(items) { item in
                            FAQItemRow(
                                item: item,
                                isExpanded: viewModel.expandedItemIDs.contains(item.id),
                                onToggle: {
                                    viewModel.toggleExpansion(for: item.id)
                                }
                            )
                        }
                    }
                    .padding(16)
                }
                .refreshable {
                    await viewModel.load()
                }
            }
        }
        .background(theme.background.ignoresSafeArea())
        .navigationTitle("FAQ")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .task {
            if viewModel.state == .idle {
                await viewModel.load()
            }
        }
    }
}


private struct PreviewFAQRepository: FAQRepository {


    let items: [FAQItem]
    let shouldFail: Bool
    
    init(items: [FAQItem] = [], shouldFail: Bool = false) {
        self.items = items
        self.shouldFail = shouldFail
    }
    
    func fetchFAQs() async throws -> [Core.FAQItem] {
        if shouldFail {
            throw URLError(.notConnectedToInternet)
        }
        return items
    }
}

#Preview("Empty State") {
    FAQView(repository: PreviewFAQRepository(items: []))
}

#Preview("Error State") {
    FAQView(repository: PreviewFAQRepository(shouldFail: true))
}

#Preview("Loaded State") {
    FAQView(
        repository: PreviewFAQRepository(items: [
            FAQItem(
                id: 1,
                question: "How long does delivery take?",
                answer: "Standard delivery takes between 2 to 4 business days."
            ),
            FAQItem(
                id: 2,
                question: "Can I return an item?",
                answer: "Yes, you can return any item within 14 days of receipt."
            ),
            FAQItem(
                id: 3,
                question: "What payment methods are supported?",
                answer: "We support Visa, Mastercard, Apple Pay, and Mada."
            )
        ])
    )
}
