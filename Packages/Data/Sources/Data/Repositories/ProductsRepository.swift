//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation
import Core

public protocol ProductsRepository: Sendable {
    func fetchProducts(page: Int) async throws -> ProductsPage
    func fetchProductDetail(id: Int) async throws -> ProductDetail
}
