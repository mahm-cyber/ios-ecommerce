//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by NamaaIT Apple3 on 21/10/2026.
//

import SwiftUI


public struct AppButton: View {
    public enum Variant: Sendable {
        case primary
        case secondary
        case ghost
    }
    
    @Environment(\.appTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    let title: String
    let variant: Variant
    let isLoading: Bool
    let action: @MainActor @Sendable () -> Void
    
    public init(
        _ title: String,
        variant: Variant = .primary,
        isLoading: Bool = false,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        
        self.title = title
        self.variant = variant
        self.isLoading = isLoading
        self.action = action
    }
    
    
    private var backgroundColor: Color {
        switch variant {
        case .primary:
            theme.primary
        case .secondary:
                .clear
        case .ghost:
                .clear
        }
    }
    
    private var foregroundColor: Color {
        switch variant {
        case .primary:
            theme.surface
        case .secondary:
            theme.textPrimary
        case .ghost:
            theme.primary
        }
    }
    
    private var borderColor: Color {
        switch variant {
        case .primary:
            theme.primary
        case .secondary:
            theme.border
        case .ghost:
                .clear
        }
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                Text(title)
                    .font(theme.typography.headline)
                    .foregroundStyle(foregroundColor)
                    .opacity(isLoading ? 0 : 1)
                if isLoading {
                    ProgressView()
                        .tint(theme.surface)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            }
        }
        .disabled(!isEnabled || isLoading)
        .opacity(isEnabled ? 1.0 : 0.5)
        
    }
}

#Preview {
    VStack(spacing: 16) {
        AppButton("Primary Button", variant: .primary) {}
        AppButton("Secondary Button", variant: .secondary) {}
        AppButton("Ghost Button", variant: .ghost) {}
        AppButton("Loading State", isLoading: true) {}
        AppButton("Disabled State") {}
            .disabled(true)
    }
    .padding()
}
