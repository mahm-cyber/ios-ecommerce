//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import Foundation
import Core


public protocol CategoriesRepository: Sendable {
    func fetchCategories() async throws -> [CategoryItem]
}
