//
//  File.swift
//  Core
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation


public struct ProductsPage: Sendable, Equatable {
    public let items: [ProductItem]
    public let page: Int
    public let hasMore: Bool
    public let total: Int
    
    
    public init(items: [ProductItem], page: Int, hasMore: Bool, total: Int) {
        self.items = items
        self.page = page
        self.hasMore = hasMore
        self.total = total
    }
}
