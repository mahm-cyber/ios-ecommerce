//
//  File.swift
//  Features
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import Foundation
import Core

public enum CategoriesState: Sendable, Equatable {
    case  idle
    case  loading
    case  loaded([CategoryItem])
    case  empty
    case  failed(String)
}
