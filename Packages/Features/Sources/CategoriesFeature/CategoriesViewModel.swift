//
//  File.swift
//  Features
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import Foundation
import Observation
import Core
import Data

@Observable
@MainActor
public class CategoriesViewModel {
    public private(set) var state: CategoriesState = .idle
    private let repository: CategoriesRepository
    
    
    public init(
        repository: CategoriesRepository) {
            self.repository = repository
        }
    
    
    public func load() async {
        state = .loading
        
        do {
            let categories = try await repository.fetchCategories()
            state = categories.isEmpty ? .empty : .loaded(categories)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
    
}

