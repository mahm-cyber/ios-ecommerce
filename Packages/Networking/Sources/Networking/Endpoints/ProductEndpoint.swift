//
//  ProductEndpoint.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import Foundation

extension Endpoint where Response == ProductDetailResponseDTO {
    public static func productDetail(id: Int) -> Endpoint {
        Endpoint(
            path: "product/\(id)",
            queries: [
                URLQueryItem(name: "device_type", value: "app")
            ]
        )
    }

    public static func product(id: Int) -> Endpoint {
        productDetail(id: id)
    }
}
