//
//  SwiftUIView.swift
//  Features
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import SwiftUI
import Core
import DesignSystem

public  struct SubcategoryRow: View {
    @Environment(\.appTheme) private var theme
    @Environment(\.imageURLBuilder) private var imageURLBuilder
    let title: String
    let imageName: String?
    let onTap: () -> Void
    
    public init(
        title: String,
        imageName: String?,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.imageName = imageName
        self.onTap = onTap
    }
    
    public var textTheme: TextTheme {
        theme.textTheme
    }
    public var categoryTheme: CategoryCardTheme {
        theme.categoryCardTheme
    }
    public  var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(
                        categoryTheme.activeBackground.opacity(0.6)
                    )
                
                Spacer()
                
               
                Text(title)
                    .font(theme.typography.caption)
                    .foregroundStyle(categoryTheme.subTitle)
                
                AppAPIImage(imageName)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                SubcategoryRowShape()
                    .fill(categoryTheme.background)
            )
            .clipShape(SubcategoryRowShape())
             
        
        }
         
        .buttonStyle(.plain)
    }
    

}

#Preview {
    VStack(spacing: 8) {
        SubcategoryRow(
            title: "السيرومات المرطبة",
            imageName: nil,
            onTap: {}
        )
        SubcategoryRow(
            title: "سيرومات تفتيح البشرة",
            imageName: nil,
            onTap: {}
        )
        SubcategoryRow(
            title: "الكل",
            imageName: nil,
            onTap: {}
        )
    }
    .padding()
}
