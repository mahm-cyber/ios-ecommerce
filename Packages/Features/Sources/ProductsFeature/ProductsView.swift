//
//  ProductsView.swift
//  Features
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import SwiftUI
import Core
import Data
import DesignSystem

public struct ProductsView: View {
    @State var viewModel: ProductsViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    public init(repository: ProductsRepository) {
        _viewModel = State(initialValue: ProductsViewModel(repository: repository))
    }

    public var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded:
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.products) { product in
                            ProductCard(product: product)
                                .task {
                                    await viewModel.loadMoreIfNeeded(currentItem: product)
                                }
                        }
                    }
                    .padding(16)

                    if viewModel.isLoadingMore {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                }
                .refreshable {
                    await viewModel.load()
                }

            case .empty:
                ContentUnavailableView(
                    "No Products",
                    systemImage: "bag",
                    description: Text("There are no products available at this time.")
                )

            case .failed(let message):
                ErrorStateView(message) {
                    Task { await viewModel.load() }
                }
            }
        }
        .task {
            if viewModel.state == .idle {
                await viewModel.load()
            }
        }
    }
}

private struct PreviewProductsRepository: ProductsRepository {
    let items: [ProductItem]
    let shouldFail: Bool

    init(items: [ProductItem] = ProductItem.examples, shouldFail: Bool = false) {
        self.items = items
        self.shouldFail = shouldFail
    }

    func fetchProducts(page: Int) async throws -> ProductsPage {
        if shouldFail {
            throw URLError(.notConnectedToInternet)
        }
        return ProductsPage(
            items: items,
            page: page,
            hasMore: false,
            total: items.count
        )
    }
}

#Preview("Loaded State") {
    NavigationStack {
        ProductsView(repository: PreviewProductsRepository())
    }
}

#Preview("Empty State") {
    NavigationStack {
        ProductsView(repository: PreviewProductsRepository(items: []))
    }
}

#Preview("Error State") {
    NavigationStack {
        ProductsView(repository: PreviewProductsRepository(shouldFail: true))
    }
}
