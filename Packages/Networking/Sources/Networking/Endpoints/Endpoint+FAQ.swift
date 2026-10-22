//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Foundation



extension Endpoint where Response == QuestionsResponseDTO {
    public static var questions: Endpoint {
        return Endpoint(path: "Questions")
    }
}
