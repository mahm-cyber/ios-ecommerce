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

    public func fetchProductDetail(id: Int) async throws -> ProductDetail {
        let response = try await client.send(.productDetail(id: id))
        return mapDetail(response)
    }

    private func mapDetail(_ response: ProductDetailResponseDTO) -> ProductDetail {
        let p = response.product

        let item = ProductItem(
            id: p.id,
            name: p.title,
            price: p.price,
            salePrice: p.priceAfterDiscount,
            discountPercentage: p.offer?.title,
            imageURL: p.img,
            isFavorite: p.isFav == 1,
            isOutOfStock: (p.stocks ?? 0) <= 1,
            rating: p.rating,
            category: p.category.map { dto in
                CategoryItem(id: dto.id, title: dto.title ?? "", slug: dto.slug ?? "")
            },
            description: p.desc?.strippingHTML(),
            stocks: p.stocks,
            code: p.code,
            tags: p.tags?.compactMap { $0.name } ?? []
        )

        var gallery: [String] = []
        if let all = p.allImages, !all.isEmpty {
            gallery = all
        } else {
            if let mainImg = p.img, !mainImg.isEmpty {
                gallery.append(mainImg)
            }
            if let extra = p.images {
                for imgDto in extra {
                    if let name = imgDto.name, !name.isEmpty, !gallery.contains(name) {
                        gallery.append(name)
                    }
                }
            }
        }

        let similar = (p.similarProducts ?? []).map { map($0) }

        return ProductDetail(
            item: item,
            galleryImages: gallery,
            brandName: p.brand?.name,
            brandImage: p.brand?.img,
            ratingsCount: response.ratingsCount,
            allowRating: (response.allowRating ?? 0) == 1,
            videoURL: p.video,
            points: p.points,
            similarProducts: similar
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
            },
            description: productItemDTO.desc?.strippingHTML(),
            stocks: productItemDTO.stocks,
            code: productItemDTO.code,
            tags: productItemDTO.tags?.compactMap { $0.name } ?? []
        )
    }

}



