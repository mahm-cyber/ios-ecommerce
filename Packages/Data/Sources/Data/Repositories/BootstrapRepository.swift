//
//  File.swift
//  Data
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation


public protocol BootstrapRepository: Sendable {
    var state: BootstrapState { get }
    func load() async throws
    
}
