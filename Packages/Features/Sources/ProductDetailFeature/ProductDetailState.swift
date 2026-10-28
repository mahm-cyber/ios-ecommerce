//
//  ProductDetailState.swift
//  ProductDetailFeature
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import Foundation
import Core

public enum ProductDetailState: Equatable {
    case idle
    case loading
    case loaded(ProductDetail)
    case failed(String)
}
