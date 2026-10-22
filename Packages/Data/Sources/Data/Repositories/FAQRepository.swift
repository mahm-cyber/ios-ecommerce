//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Foundation
import Networking
import Core


public protocol FAQRepository: Sendable {
    func fetchFAQs() async throws -> [FAQItem]
}


public struct AppFAQRepository: FAQRepository, @unchecked Sendable {
    
    let networkingClient: NetworkClient
    
    public init(networkingClient: NetworkClient) {
        self.networkingClient = networkingClient
    }
    
    public func fetchFAQs() async throws -> [Core.FAQItem] {
        let response = try await networkingClient.send(.questions)
        return response.questions.map { dto in
            FAQItem(
                id: dto.id,
                question: dto.question,
                answer: dto.answer.strippingHTML()
            )
        }
    }

    

}
