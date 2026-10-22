//
//  FAQEndpointTests.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Testing
@testable import Networking
import SwiftUI


struct FAQEndpointTests {

    @Test("Questions endpoint has correct path and GET method")
    func endpointConfiguration() {
        let endpoint = Endpoint.questions
        #expect(endpoint.path == "Questions")
        #expect(endpoint.method == .get)
    }
    
    
    @Test("Decodes questions payload successfully")
    func decodeQuestions() async throws {
        let json = """
        {
            "questions": [
                {
                    "questions_id": 33,
                    "questions_question": "Can I request a custom item?",
                    "questions_answer": "<p>Currently we offer ready-made only.</p>"
                }
            ]
        }
        """
        
        let data = Data(json.utf8)
        let dto = try JSONDecoder().decode(
            QuestionsResponseDTO.self,
            from: data
        )
        
        #expect(dto.questions.count == 1)
        #expect(dto.questions[0].id == 33)
        #expect(dto.questions[0].question == "Can I request a custom item?")
    }
}
