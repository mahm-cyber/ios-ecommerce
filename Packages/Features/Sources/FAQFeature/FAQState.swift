//
//  FAQState.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 22/10/2026.
//

import Foundation
import Core



public enum FAQState: Sendable, Equatable {
    case idle
    case loading
    case loaded([FAQItem])
    case empty
    case failed(String)
}

