//
//  Test.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 21/10/2026.
//
import SwiftUI
import Testing
@testable import DesignSystem

@MainActor
@Suite("AppButton Tests")
struct AppButtonTests {
    
    
    @Test("AppButton initializes with default primary variant and idle state")
    func vairablesCheck()     {
        let button =   AppButton(
            "Submit",
        ) { }
        
        #expect(button.title == "Submit")
        #expect(button.isLoading == false )
        #expect(button.variant == .primary)
    }
    
    @Test("AppButton executes action closure when tapped")
    func actionExecution()     {
        var didTap = false
        
        let button =   AppButton("Pay") {
            didTap = true
        }
        
        button.action()
        
        #expect(didTap == true)
        
    }
    @Test("AppButton preserves loading state")
    func loadingState() {
        let button = AppButton("Loading", isLoading: true) {}
        #expect(button.isLoading == true)
    }
    @Test("AppButton sets requested variant")
    func variantCustomization() {
        let button = AppButton("Secondary", variant: .secondary) {}
        #expect(button.variant == .secondary)
    }
}
