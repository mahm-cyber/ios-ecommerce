//
//  ProductsRepositoryTests.swift
//  DataTests
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation
import Testing
import Core
import Networking
@testable import Data

@Suite("ProductsRepository Tests")
struct ProductsRepositoryTests {

    private func makeClient(transport: HTTPTransport) -> NetworkClient {
        let config = APIConfiguration(
            baseURL: URL(string: "https://example.com")!,
            apiVersion: "v006",
            accountId: "28",
            secretKey: "test_key"
        )
        let builder = RequestBuilder(config)
        return NetworkClient(
            builder: builder,
            transport: transport,
            languageSupplier: { "en" },
            tokenSupplier: { nil },
            deviceIDSupplier: { "test-device-uuid" }
        )
    }

    private func makeProductsJSON(
        currentPage: Int = 1,
        lastPage: Int = 2,
        total: Int = 20
    ) -> Data {
        let json = """
        {
            "status": 200,
            "message": "Products Data Returned Successfully",
            "errors": null,
            "data": {
                "products": [
                    {
                        "products_id": 8260,
                        "FK_categories_id": 1607,
                        "products_code": "54941885235522",
                        "products_barcode": null,
                        "products_img": "Rectangle 123.webp",
                        "products_video": null,
                        "products_price": 133.37,
                        "products_price_after_discount": 110.0,
                        "products_available": "1",
                        "products_status": "1",
                        "products_points": 100,
                        "products_points_value": 1,
                        "products_stocks": 48,
                        "products_rating": "8.10",
                        "products_title": "Dr. Melaxin Calcium Bonding Serum",
                        "products_desc": "Barrier Strengthening",
                        "products_slug": "dr-melaxin-calcium-bonding-serum",
                        "products_type": "count",
                        "products_lowest_weight_available": null,
                        "is_fav": 1,
                        "is_notify": 0,
                        "is_new": 0,
                        "most_wanted": 1,
                        "has_choices": false,
                        "category": {
                            "categories_id": 1607,
                            "categories_title": "Hydrating Serums",
                            "categories_slug": "hydrating-serums"
                        },
                        "offer": {
                            "offers_id": 42,
                            "offers_title": "خد ٢ + ١ هديه",
                            "offers_main_number": 2,
                            "offers_additional_number": 1,
                            "offers_discount": 100,
                            "offers_type": "general_offers",
                            "offers_from": "2026-07-06 00:00:00",
                            "offers_to": "2026-11-30 00:00:00"
                        },
                        "tags": [],
                        "your_country_is_excluded": 0
                    },
                    {
                        "products_id": 8257,
                        "FK_categories_id": 1607,
                        "products_code": "51534613938498",
                        "products_barcode": null,
                        "products_img": "Rectangle 122.webp",
                        "products_video": null,
                        "products_price": 117.0,
                        "products_price_after_discount": null,
                        "products_available": "1",
                        "products_status": "1",
                        "products_points": 1,
                        "products_points_value": 0.01,
                        "products_stocks": 0,
                        "products_rating": "3.10",
                        "products_title": "Medicube PDRN Collagen Glow",
                        "products_desc": null,
                        "products_slug": "medicube-pdrn-collagen-glow",
                        "products_type": "count",
                        "products_lowest_weight_available": null,
                        "is_fav": 0,
                        "is_notify": 0,
                        "is_new": 0,
                        "most_wanted": 0,
                        "has_choices": false,
                        "category": null,
                        "offer": null,
                        "tags": [],
                        "your_country_is_excluded": 0
                    }
                ],
                "pagination": {
                    "current_page": \(currentPage),
                    "first_page_url": "https://example.com/products?page=1",
                    "from": 1,
                    "last_page": \(lastPage),
                    "last_page_url": "https://example.com/products?page=\(lastPage)",
                    "links": [],
                    "next_page_url": \(currentPage < lastPage ? "\"https://example.com/products?page=\(currentPage + 1)\"" : "null"),
                    "path": "https://example.com/products",
                    "per_page": 10,
                    "prev_page_url": null,
                    "to": 2,
                    "total": \(total)
                },
                "min": "117.000",
                "max": "278.000",
                "filterIds": {
                    "offers_ids": [],
                    "brands_ids": [],
                    "choices_ids": [],
                    "tags_ids": []
                },
                "selected_category": null
            }
        }
        """
        return Data(json.utf8)
    }

    // MARK: - Tests

    @Test("fetchProducts returns mapped domain products and pagination info")
    func fetchProductsSuccess() async throws {
        let transport = TestTransport { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (self.makeProductsJSON(currentPage: 1, lastPage: 3, total: 30), response)
        }

        let client = makeClient(transport: transport)
        let repo = AppProductsRepository(client: client)

        let page = try await repo.fetchProducts(page: 1)

        #expect(page.page == 1)
        #expect(page.hasMore == true)
        #expect(page.total == 30)
        #expect(page.items.count == 2)

        let first = page.items[0]
        #expect(first.id == 8260)
        #expect(first.name == "Dr. Melaxin Calcium Bonding Serum")
        #expect(first.price == 133.37)
        #expect(first.salePrice == 110.0)
        #expect(first.discountPercentage == "خد ٢ + ١ هديه")
        #expect(first.imageURL == "Rectangle 123.webp")
        #expect(first.isFavorite == true)
        #expect(first.isOutOfStock == false)
        #expect(first.rating == "8.10")
        #expect(first.category?.id == 1607)
        #expect(first.category?.title == "Hydrating Serums")

        let second = page.items[1]
        #expect(second.id == 8257)
        #expect(second.isFavorite == false)
        #expect(second.isOutOfStock == true)
        #expect(second.salePrice == nil)
        #expect(second.discountPercentage == nil)
        #expect(second.category == nil)
    }

    @Test("fetchProducts marks hasMore as false when on last page")
    func fetchProductsLastPage() async throws {
        let transport = TestTransport { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (self.makeProductsJSON(currentPage: 3, lastPage: 3, total: 30), response)
        }

        let client = makeClient(transport: transport)
        let repo = AppProductsRepository(client: client)

        let page = try await repo.fetchProducts(page: 3)

        #expect(page.page == 3)
        #expect(page.hasMore == false)
    }

    @Test("fetchProducts propagates network error")
    func fetchProductsPropagatesError() async {
        let transport = TestTransport { _ in
            throw URLError(.notConnectedToInternet)
        }

        let client = makeClient(transport: transport)
        let repo = AppProductsRepository(client: client)

        await #expect(throws: NetworkError.self) {
            try await repo.fetchProducts(page: 1)
        }
    }
}
