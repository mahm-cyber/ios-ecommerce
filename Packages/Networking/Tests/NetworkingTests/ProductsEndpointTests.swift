//
//  ProductsEndpointTests.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Testing
import Foundation
@testable import Networking

struct ProductsEndpointTests {

    @Test("Products endpoint default configuration has path 'products', GET method, and page=1")
    func defaultEndpointConfiguration() {
        let endpoint = Endpoint.products()
        #expect(endpoint.path == "products")
        #expect(endpoint.method == .get)
        #expect(endpoint.queries.count == 1)
        #expect(endpoint.queries.first?.name == "page")
        #expect(endpoint.queries.first?.value == "1")
    }

    @Test("Products endpoint with custom page sets correct query parameter")
    func customPageQuery() {
        let endpoint = Endpoint.products(page: 3)
        #expect(endpoint.queries.count == 1)
        #expect(endpoint.queries.first?.name == "page")
        #expect(endpoint.queries.first?.value == "3")
    }

    @Test("Products endpoint with nil page has no queries")
    func nilPageQuery() {
        let endpoint = Endpoint.products(page: nil)
        #expect(endpoint.queries.isEmpty)
    }
}
