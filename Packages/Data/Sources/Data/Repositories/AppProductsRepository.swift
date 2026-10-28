//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation
import Networking
import Core

public struct AppProductsRepository: ProductsRepository {
    let client: NetworkClient
    
    public init(client: NetworkClient) {
        self.client = client
    }
    
    public func fetchProducts(page: Int = 1) async throws ->  ProductsPage {
        
        let response = try await client.send(.products(page: page))
        let items = response.products.map{ map($0) }
        // Check if there are more pages:
        // Either current_page < last_Page or next_page_url != nil
        let currentPage = response.pagination?.currentPage ?? page
        let lastPage = response.pagination?.lastPage ?? currentPage
        let hasMore = currentPage < lastPage
        let total = response.pagination?.total ?? items.count
        return ProductsPage(
            items: items,
            page: currentPage,
            hasMore: hasMore,
            total: total
        )
    }
    
    private func map(_ productItemDTO: ProductItemDTO) -> ProductItem {
        return ProductItem(
            id: productItemDTO.id,
            name: productItemDTO.title,
            price: productItemDTO.price,
            salePrice: productItemDTO.priceAfterDiscount,
            discountPercentage: productItemDTO.offer?.title,
            imageURL: productItemDTO.img,
            isFavorite: productItemDTO.isFav == 1,
            isOutOfStock: (productItemDTO.stocks ?? 0) <= 1,
            rating: productItemDTO.rating,
            category: productItemDTO.category.map { dto in
                CategoryItem(id: dto.id, title: dto.title ?? "", slug: dto.slug ?? "")
            }
        )
    }

}



