//
//  ProductDetailViewModel.swift
//  ProductDetailFeature
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import Foundation
import Observation
import Core
import Data

@Observable
@MainActor
public class ProductDetailViewModel {
    public private(set) var state: ProductDetailState = .idle

    public let productId: Int
    public let product: ProductDetail
    private let repository: ProductsRepository

    public init(
        repository: ProductsRepository,
        productItem: ProductItem
    ) {
        self.productId = productItem.id
        self.repository = repository
        self.product = productItem.toProductDetail
    }

    public func load() async {
        state = .loading
        
        do {
            let productDetail = try await repository.fetchProductDetail(
                id: productId
            )
            state = .loaded(productDetail)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
    
    
}

//private  func  map(_ productItem: ProductItem) -> ProductDetail {
//    ProductDetail(item: productItem)
//}


extension ProductItem {
    var toProductDetail: ProductDetail {
        ProductDetail(item: self)
    }
}
