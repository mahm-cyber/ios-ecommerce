//
//  ProductsViewModel.swift
//  Features
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation
import Observation
import Core
import Data

@Observable
@MainActor
public class ProductsViewModel {
    public private(set) var state: ProductsState = .idle
    public private(set) var products: [ProductItem] = []
    public private(set) var isLoadingMore: Bool = false
    public private(set) var hasMore: Bool = true

    private var currentPage: Int = 1
    private let repository: ProductsRepository

    public init(repository: ProductsRepository) {
        self.repository = repository
    }

    public func load() async {
        state = .loading
        currentPage = 1

        do {
            let page = try await repository.fetchProducts(page: currentPage)
            products = page.items
            hasMore = page.hasMore
            state = page.items.isEmpty ? .empty : .loaded(page.items)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }

    public func loadMoreIfNeeded(currentItem: ProductItem) async {
        guard hasMore, !isLoadingMore else { return }
        guard case .loaded = state else { return }
        guard currentItem.id == products.last?.id else { return }

        isLoadingMore = true
        let nextPage = currentPage + 1

        do {
            let page = try await repository.fetchProducts(page: nextPage)
            products.append(contentsOf: page.items)
            currentPage = nextPage
            hasMore = page.hasMore
            state = .loaded(products)
        } catch {
            // Keep current loaded items, stop pagination spinner
        }
        isLoadingMore = false
    }
}
