//
//  FAQDTOs.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Foundation


public struct QuestionItemDTO: Decodable, Sendable {
    public let id: Int
    public let question: String
    public let answer: String
    
    
    enum CodingKeys: String, CodingKey {
        case id =  "questions_id"
        case question = "questions_question"
        case answer = "questions_answer"
    }
}

public struct QuestionsResponseDTO: Sendable, Decodable {
    public let questions: [QuestionItemDTO]
}
