//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation
import Core

public enum BootstrapState: Equatable, Sendable {
    case idle
    case loading
    case loaded(BootstrapData)
    case failed(NetworkError)
}
