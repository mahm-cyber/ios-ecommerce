//
//  FlexibleDecoding.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 28/10/2026.
//

import Foundation

extension KeyedDecodingContainer {
    public func decodeFlexibleDouble(forKey key: Key) throws -> Double {
        if let doubleVal = try? decode(Double.self, forKey: key) {
            return doubleVal
        }
        if let intVal = try? decode(Int.self, forKey: key) {
            return Double(intVal)
        }
        if let stringVal = try? decode(String.self, forKey: key),
           let doubleVal = Double(stringVal) {
            return doubleVal
        }
        throw DecodingError.typeMismatch(
            Double.self,
            DecodingError.Context(
                codingPath: codingPath + [key],
                debugDescription: "Expected Double, Int, or convertible String for key '\(key.stringValue)'"
            )
        )
    }

    public func decodeFlexibleDoubleIfPresent(forKey key: Key) throws -> Double? {
        guard contains(key), !(try decodeNil(forKey: key)) else {
            return nil
        }
        return try decodeFlexibleDouble(forKey: key)
    }
}
