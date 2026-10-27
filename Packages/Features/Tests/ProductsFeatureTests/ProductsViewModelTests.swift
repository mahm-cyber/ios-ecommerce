//
//  ProductsViewModelTests.swift
//  Features
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Testing
import Foundation
import Core
import Data
@testable import ProductsFeature

final class FakeProductsRepository: ProductsRepository, @unchecked Sendable {
    var resultForPage: (Int) -> Result<ProductsPage, Error>

    init(resultForPage: @escaping (Int) -> Result<ProductsPage, Error>) {
        self.resultForPage = resultForPage
    }

    func fetchProducts(page: Int) async throws -> ProductsPage {
        try resultForPage(page).get()
    }
}

@Suite("ProductsViewModel Tests")
@MainActor
struct ProductsViewModelTests {

    private func makeSampleProduct(id: Int) -> ProductItem {
        ProductItem(
            id: id,
            name: "Product \(id)",
            price: 99.99
        )
    }

    @Test("Initial state is idle")
    func initialState() {
        let repo = FakeProductsRepository { _ in
            .success(ProductsPage(items: [], page: 1, hasMore: false, total: 0))
        }
        let viewModel = ProductsViewModel(repository: repo)

        #expect(viewModel.state == .idle)
        #expect(viewModel.products.isEmpty)
        #expect(!viewModel.isLoadingMore)
    }

    @Test("Load successfully sets loaded state with products")
    func loadSuccess() async {
        let product = makeSampleProduct(id: 1)
        let repo = FakeProductsRepository { page in
            .success(ProductsPage(items: [product], page: page, hasMore: true, total: 2))
        }
        let viewModel = ProductsViewModel(repository: repo)

        await viewModel.load()

        #expect(viewModel.state == .loaded([product]))
        #expect(viewModel.products.count == 1)
        #expect(viewModel.hasMore == true)
    }

    @Test("Load with empty items sets empty state")
    func loadEmpty() async {
        let repo = FakeProductsRepository { _ in
            .success(ProductsPage(items: [], page: 1, hasMore: false, total: 0))
        }
        let viewModel = ProductsViewModel(repository: repo)

        await viewModel.load()

        #expect(viewModel.state == .empty)
        #expect(viewModel.products.isEmpty)
    }

    @Test("Load failure sets failed state")
    func loadFailure() async {
        struct TestError: LocalizedError {
            var errorDescription: String? { "Network timeout" }
        }
        let repo = FakeProductsRepository { _ in
            .failure(TestError())
        }
        let viewModel = ProductsViewModel(repository: repo)

        await viewModel.load()

        #expect(viewModel.state == .failed("Network timeout"))
    }

    @Test("loadMore appends new items")
    func loadMoreAppendsItems() async {
        let product1 = makeSampleProduct(id: 1)
        let product2 = makeSampleProduct(id: 2)

        let repo = FakeProductsRepository { page in
            if page == 1 {
                return .success(ProductsPage(items: [product1], page: 1, hasMore: true, total: 2))
            } else {
                return .success(ProductsPage(items: [product2], page: 2, hasMore: false, total: 2))
            }
        }
        let viewModel = ProductsViewModel(repository: repo)

        await viewModel.load()
        #expect(viewModel.products.count == 1)

        await viewModel.loadMoreIfNeeded(currentItem: product1)
        #expect(viewModel.products.count == 2)
        #expect(viewModel.hasMore == false)
    }

    @Test("loadMore does not trigger when item is not the last one")
    func loadMoreIgnoresNonLastItem() async {
        let product1 = makeSampleProduct(id: 1)
        let product2 = makeSampleProduct(id: 2)
        var pageRequested = 1

        let repo = FakeProductsRepository { page in
            pageRequested = page
            return .success(ProductsPage(items: [product1, product2], page: 1, hasMore: true, total: 5))
        }
        let viewModel = ProductsViewModel(repository: repo)

        await viewModel.load()
        #expect(viewModel.products.count == 2)

        // Passing product1 (not the last product) should do nothing
        await viewModel.loadMoreIfNeeded(currentItem: product1)
        #expect(pageRequested == 1)
        #expect(viewModel.products.count == 2)
    }

    @Test("loadMore does not trigger when hasMore is false")
    func loadMoreIgnoresWhenNoMorePages() async {
        let product1 = makeSampleProduct(id: 1)
        var fetchCount = 0

        let repo = FakeProductsRepository { page in
            fetchCount += 1
            return .success(ProductsPage(items: [product1], page: 1, hasMore: false, total: 1))
        }
        let viewModel = ProductsViewModel(repository: repo)

        await viewModel.load()
        #expect(fetchCount == 1)
        #expect(viewModel.hasMore == false)

        await viewModel.loadMoreIfNeeded(currentItem: product1)
        #expect(fetchCount == 1)
    }
}
