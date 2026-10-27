//
//  ErrorStateView.swift
//  Features
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//


import SwiftUI

public struct ErrorStateView: View {
    @Environment(\.appTheme) private var theme
    let message: String
    let action: @MainActor @Sendable () -> Void
  
    public init(
        _ message: String,
        action: @Sendable @escaping () -> Void
    ) {
        self.message = message
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundStyle(theme.error)
            
            Text("Something Went Wrong")
                .font(theme.typography.title3)
                .foregroundStyle(theme.textPrimary)
            
            Text(message)
                .font(theme.typography.body)
                .foregroundStyle(theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            AppButton("Try Again", variant: .primary, action: action)
            .padding(.horizontal, 32)
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}


#Preview {
    ErrorStateView("Error") { }
}
