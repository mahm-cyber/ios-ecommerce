//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import Foundation
import Core
import Networking


public struct AppCategoriesRepository: CategoriesRepository, @unchecked Sendable {

    let bootstrapRepository: BootstrapRepository
    
    public init(bootstrapRepository: BootstrapRepository) {
        self.bootstrapRepository = bootstrapRepository
    }
    
    public func fetchCategories() async throws -> [Core.CategoryItem] {
        switch bootstrapRepository.state {
        case .idle, .loading:
             
            try await bootstrapRepository.load()
            if case .loaded(let data) = bootstrapRepository.state {
                return data.categories
            }
            return []
        case .loaded(let bootstrapData):
            return bootstrapData.categories
        case .failed(let error):
            throw error
        }
    }
    
    

}

