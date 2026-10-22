//
//  File.swift
//  Core
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Foundation

public struct FAQItem: Identifiable, Sendable, Equatable {
    public let id: Int
    public let question: String
    public let answer: String
    
    
    public init(id: Int, question: String, answer: String) {
        self.id = id
        self.question = question
        self.answer = answer
    }
}
