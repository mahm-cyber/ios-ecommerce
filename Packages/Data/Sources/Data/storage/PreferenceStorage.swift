//
//  File.swift
//  Data
//
//  Created by mahmoud on 16/10/2026.
//

import Foundation



public protocol PreferenceStorage: Sendable {
    var isFirstRun: Bool { get set }
    var deviceID: String { get }
    var selectedLanguage: String { get set }
}
