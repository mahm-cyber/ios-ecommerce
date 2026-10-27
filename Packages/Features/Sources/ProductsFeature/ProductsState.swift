//
//  ProductsState.swift
//  Features
//
//  Created by NamaaIT Apple3 on 27/10/2026.
//

import Foundation
import Core

public enum ProductsState: Sendable, Equatable {
    case idle
    case loading
    case loaded([ProductItem])
    case empty
    case failed(String)
}
