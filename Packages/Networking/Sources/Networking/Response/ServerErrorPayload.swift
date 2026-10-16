//
//  File.swift
//  Networking
//
//  Created by mahmoud on 16/10/2026.
//

import Foundation


public struct ServerErrorPayload: Sendable, Decodable {
   public  let error: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let singleString = try? container.decode(String.self) {
            error = singleString
        } else if let array = try? container.decode([String].self) {
            error = array.joined(separator: ", ")
        } else if let dict = try? container.decode([String: String].self) {
            error = dict.values.joined(separator: ", ")
        } else if let nestedDict = try? container.decode([String: [String]].self) {
            error = nestedDict.values
                .flatMap{ $0 }
                .joined(separator: ", ")
        } else {
            error = ""
        }
    }
}
