//
//  FAQViewModel.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Foundation
import Observation
import Core
import Data



@Observable
@MainActor
public final class FAQViewModel {
    public private(set) var state: FAQState = .idle
    public var expandedItemIDs: Set<Int> = []
    
    private let repository: FAQRepository
    
    
    public init(repository: FAQRepository) {
        self.repository = repository
    }
    
    public func load() async {
        state = .loading
        
        do {
            let items = try await repository.fetchFAQs()
            state = items.isEmpty ? .empty : .loaded(items)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
    
    public func toggleExpansion(for id: Int) {
        if expandedItemIDs.contains(id) {
            expandedItemIDs.remove(id)
        } else {
            expandedItemIDs.insert(id)
        }
    }
}

