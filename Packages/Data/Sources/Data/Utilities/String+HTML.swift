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
            with:"",
            options: .regularExpression
        )
        
       let entityFree = tagFree.replacingOccurrences(
            of: "&nbsp;",
            with: " ",
            options: .regularExpression
        )
        
        return entityFree.trimmingCharacters(in: .whitespacesAndNewlines)
       
    }
}
