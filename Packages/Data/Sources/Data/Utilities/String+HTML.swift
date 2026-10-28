//
//  String+HTML.swift
//  Data
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Foundation


extension String {
    public func strippingHTML() -> String {
        let tagFree = self.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        
        let entityFree = tagFree
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&#39;", with: "'")
        
        return entityFree.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
