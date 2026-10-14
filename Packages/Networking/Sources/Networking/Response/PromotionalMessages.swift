//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation

struct PromotionalMessages: Codable {
    let promotionalMessagesId: Int?
    let fKAccountsId: Int?
    let promotionalMessagesIcon: String?
    let promotionalMessagesImage: String?
    let promotionalMessagesStatus: String?
    let promotionalMessagesPosition: Int?
    let promotionalMessagesCreatedAt: String?
    let promotionalMessagesUpdatedAt: String?
    let promotionalMessagesText: String?
    let promotionalMessagesTitle: String?

    enum CodingKeys: String, CodingKey {
        case promotionalMessagesId = "promotional_messages_id"
        case fKAccountsId = "FK_accounts_id"
        case promotionalMessagesIcon = "promotional_messages_icon"
        case promotionalMessagesImage = "promotional_messages_image"
        case promotionalMessagesStatus = "promotional_messages_status"
        case promotionalMessagesPosition = "promotional_messages_position"
        case promotionalMessagesCreatedAt = "promotional_messages_created_at"
        case promotionalMessagesUpdatedAt = "promotional_messages_updated_at"
        case promotionalMessagesText = "promotional_messages_text"
        case promotionalMessagesTitle = "promotional_messages_title"
    }
}
