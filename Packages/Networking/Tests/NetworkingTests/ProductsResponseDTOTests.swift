//
//  ProductsResponseDTOTests.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Testing
import Foundation
@testable import Networking

struct ProductsResponseDTOTests {

    @Test("Decodes full products APIResponse successfully")
    func decodeProductsResponse() throws {
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
                "products_video": "https://youtube.com/shorts/ClDIgCZSEM8?si=yn15iRiPxVCnNXzI",
                "products_price": 133.37,
                "products_price_after_discount": null,
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
                "is_fav": 0,
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
                "tags": [
                  {
                    "id": 291,
                    "name": "البشرة",
                    "normalized_name": "البشره"
                  }
                ],
                "your_country_is_excluded": 0
              }
            ],
            "pagination": {
              "current_page": 1,
              "first_page_url": "https://example.com/products?page=1",
              "from": 1,
              "last_page": 1,
              "last_page_url": "https://example.com/products?page=1",
              "links": [
                {
                  "url": null,
                  "label": "&laquo; Previous",
                  "active": false
                }
              ],
              "next_page_url": null,
              "path": "https://example.com/products",
              "per_page": 12,
              "prev_page_url": null,
              "to": 1,
              "total": 1
            },
            "min": "117.000",
            "max": "278.000",
            "filterIds": {
              "offers_ids": [42, 43],
              "brands_ids": [131, 132],
              "choices_ids": [],
              "tags_ids": [291, 292]
            },
            "selected_category": null
          }
        }
        """

        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(APIResponse<ProductsResponseDTO>.self, from: data)

        #expect(response.status == 200)
        #expect(response.message == "Products Data Returned Successfully")

        let productsData = try #require(response.data)
        #expect(productsData.products.count == 1)
        #expect(productsData.min == "117.000")
        #expect(productsData.max == "278.000")

        let product = productsData.products[0]
        #expect(product.id == 8260)
        #expect(product.categoryId == 1607)
        #expect(product.code == "54941885235522")
        #expect(product.price == 133.37)
        #expect(product.stocks == 48)
        #expect(product.title == "Dr. Melaxin Calcium Bonding Serum")
        #expect(product.category?.title == "Hydrating Serums")
        #expect(product.offer?.id == 42)
        #expect(product.offer?.discount == 100)
        #expect(product.tags?.first?.name == "البشرة")

        let pagination = try #require(productsData.pagination)
        #expect(pagination.currentPage == 1)
        #expect(pagination.perPage == 12)
        #expect(pagination.total == 1)

        let filterIds = try #require(productsData.filterIds)
        #expect(filterIds.offersIds == [42, 43])
        #expect(filterIds.brandsIds == [131, 132])
    }
}
