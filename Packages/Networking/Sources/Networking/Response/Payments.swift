//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation



public struct Payments: Codable, Sendable {
    let paymentsId: Int?
    let fKAccountsId: Int?
    let paymentsSlug: String?
    let paymentsStatus: String?
    let paymentsPosition: Int?
    let paymentsIsDiscount: Bool?
    let paymentsName: String?
    let paymentsImage: String?

    enum CodingKeys: String, CodingKey {
        case paymentsId = "payments_id"
        case fKAccountsId = "FK_accounts_id"
        case paymentsSlug = "payments_slug"
        case paymentsStatus = "payments_status"
        case paymentsPosition = "payments_position"
        case paymentsIsDiscount = "payments_is_discount"
        case paymentsName = "payments_name"
        case paymentsImage = "payments_image"
    }
}
