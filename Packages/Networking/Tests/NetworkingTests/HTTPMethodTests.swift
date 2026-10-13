//
//  Test.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 12/10/2026.
//

import Testing
@testable import Networking

struct HTTPMethodTests {
    
    // MARK: - Check the valid GET
    @Test(
        arguments: [
            ( HTTPMethod.get, "GET"),
            ( HTTPMethod.post, "POST"),
            ( HTTPMethod.put,"PUT"),
            ( HTTPMethod.delete, "DELETE")
        ]
    ) func getMethodValidation(
        input: HTTPMethod,
        expected: String
    ) {
        #expect(input.rawValue == expected)
    }
}
