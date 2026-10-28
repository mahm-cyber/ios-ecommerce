//
//  ProductDetailView.swift
//  ProductDetailFeature
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import SwiftUI
import Core
import Data
import DesignSystem

public struct ProductDetailView: View {
    @State var viewModel: ProductDetailViewModel

    public init(viewModel: ProductDetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    public init(productItem: ProductItem, repository: ProductsRepository) {
        _viewModel = State(
            initialValue: ProductDetailViewModel(
                repository: repository,
                productItem: productItem
            )
        )
    }
    
   
    public var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
            case .loaded(let productDetail):
                   
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        CarouselView(images: productDetail.galleryImages)
                        HeaderView(product: productDetail.item)
                    }
                }
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

private struct PreviewProductDetailRepository: ProductsRepository {
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

    func fetchProductDetail(id: Int) async throws -> ProductDetail {
        if shouldFail {
            throw URLError(.notConnectedToInternet)
        }
        return .example
    }
}

#Preview {
    ProductDetailView(
        productItem: .example,
        repository: PreviewProductDetailRepository()
    )
}
