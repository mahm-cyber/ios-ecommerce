//
//  ProductDetailResponseDTOTests.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import Testing
import Foundation
@testable import Networking

struct ProductDetailResponseDTOTests {

    @Test("Decodes product detail with string price, brand, tags, and similar products")
    func decodeProductDetailResponse() throws {
        let json = """
        {
          "status": 200,
          "message": "Home Data Returned Successfully",
          "errors": null,
          "data": {
            "product": {
              "products_id": 8260,
              "FK_categories_id": 1607,
              "brands_id": 135,
              "products_code": "54941885235522",
              "products_barcode": null,
              "products_img": "Rectangle 123.webp",
              "products_price": "133.37",
              "products_price_after_discount": null,
              "products_points": 100,
              "products_video": "https://youtube.com/shorts/ClDIgCZSEM8?si=yn15iRiPxVCnNXzI",
              "products_type": "count",
              "products_stocks": 48,
              "products_rating": "8.10",
              "products_title": "Dr. Melaxin Calcium Bonding Serum",
              "products_desc": "<p>Barrier Strengthening &amp; Hydrating</p>",
              "products_slug": "dr-melaxin-calcium-bonding-serum",
              "is_fav": 1,
              "all_images": [
                "Rectangle 123.webp",
                "Rectangle 124.webp"
              ],
              "images": [
                {
                  "products_images_id": 1549,
                  "products_id": 8260,
                  "products_images_name": "Rectangle 124.webp"
                }
              ],
              "brand": {
                "brands_id": 135,
                "brands_name": "elementre",
                "brands_slug": "elementre",
                "brands_img": "elementre.webp"
              },
              "category": {
                "categories_id": 1607,
                "categories_title": "Hydrating Serums",
                "categories_slug": "hydrating-serums"
              },
              "tags": [
                {
                  "tags_id": 291,
                  "name": null,
                  "translations": [
                    {
                      "tag_translations_id": 295,
                      "locale": "ar",
                      "name": "البشرة",
                      "normalized_name": "البشره"
                    }
                  ]
                },
                {
                  "tags_id": 292,
                  "name": "Skin",
                  "normalized_name": "Skin"
                }
              ],
              "SimilarProducts": [
                {
                  "products_id": 8256,
                  "FK_categories_id": 1607,
                  "products_code": "product_1",
                  "products_barcode": "13256489",
                  "products_img": "Rectangle 127.webp",
                  "products_price": 278,
                  "products_price_after_discount": null,
                  "products_stocks": 91,
                  "products_rating": "0.00",
                  "products_title": "Sesderma serum Niacinamide",
                  "products_slug": "sesderma-serum-niacinamide",
                  "is_fav": 0
                }
              ],
              "offer": null
            },
            "ratingsCount": 2,
            "allow_rating": 0
          }
        }
        """

        let data = Data(json.utf8)
        let response = try JSONDecoder().decode(APIResponse<ProductDetailResponseDTO>.self, from: data)

        #expect(response.status == 200)
        let detailData = try #require(response.data)
        #expect(detailData.ratingsCount == 2)
        #expect(detailData.allowRating == 0)

        let product = detailData.product
        #expect(product.id == 8260)
        #expect(product.price == 133.37)
        #expect(product.priceAfterDiscount == nil)
        #expect(product.stocks == 48)
        #expect(product.title == "Dr. Melaxin Calcium Bonding Serum")
        #expect(product.isFav == 1)
        #expect(product.allImages == ["Rectangle 123.webp", "Rectangle 124.webp"])
        #expect(product.images?.count == 1)
        #expect(product.images?.first?.name == "Rectangle 124.webp")

        // Brand
        #expect(product.brand?.id == 135)
        #expect(product.brand?.name == "elementre")
        #expect(product.brand?.img == "elementre.webp")

        // Tags (including fallback to translation)
        #expect(product.tags?.count == 2)
        #expect(product.tags?[0].id == 291)
        #expect(product.tags?[0].name == "البشرة")
        #expect(product.tags?[1].id == 292)
        #expect(product.tags?[1].name == "Skin")

        // Similar products
        #expect(product.similarProducts?.count == 1)
        #expect(product.similarProducts?[0].id == 8256)
        #expect(product.similarProducts?[0].price == 278.0)
    }

    @Test("Endpoint has correct path and device_type query")
    func endpointConfiguration() {
        let endpoint = Endpoint.productDetail(id: 8260)
        #expect(endpoint.path == "product/8260")
        #expect(endpoint.method == .get)
        #expect(endpoint.queries.contains(where: { $0.name == "device_type" && $0.value == "app" }))
    }
}
