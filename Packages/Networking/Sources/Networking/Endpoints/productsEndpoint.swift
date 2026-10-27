//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation


extension Endpoint where Response == ProductsResponseDTO {
    public static func products(page: Int? = 1 ) -> Endpoint {
        var queries: [URLQueryItem ] = []
        if let page = page
        {
            let query = URLQueryItem(name: "page", value: "\(page)")
            queries.append(query)
        }
       return  Endpoint(path: "products", queries: queries)
    }
}
