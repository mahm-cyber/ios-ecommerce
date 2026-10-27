//
//  SwiftUIView.swift
//  Features
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

import SwiftUI
import Core
import Data
import DesignSystem

public struct CategoriesView: View {
    @Environment(\.appTheme) private var theme
    @State var viewModel: CategoriesViewModel
    @State private var selectedCategoryID: Int? = nil
    
    public init(repository: CategoriesRepository) {
        _viewModel = State(initialValue: CategoriesViewModel(repository: repository))
    }
    
    public var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
            case .loaded(let categories):
                ScrollView {
                    LazyVStack(spacing: 16 ) {
                        ForEach(chunkedCategories(categories), id: \.self) { row in
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(row) { category in
                                    CategoryCard(
                                        category: category,
                                        isSelected: selectedCategoryID == category.id) {
                                            withAnimation(
                                                .easeInOut(duration: 0.25)
                                            ) {
                                                if selectedCategoryID == category.id {
                                                    selectedCategoryID = nil
                                                } else {
                                                    selectedCategoryID = category.id
                                                }
                                            }
                                        }
                                }
                                
                                if row.count == 1 {
                                    Color.clear.frame(maxWidth: .infinity)
                                }
                            }
                            
                            if let selected = row.first(where: { $0.id == selectedCategoryID }),
                               !selected.subcategories.isEmpty {
                                VStack(spacing: 8) {
                                    ForEach(selected.subcategories) { sub in
                                        
                                        SubcategoryRow(
                                            title: sub.title,
                                            imageName: sub.imageName) {
                                                //TODO: Navigation to subcategory products
                                            }
                                    }
                                    
                                    // "الكل" (All) row
                                    SubcategoryRow(
                                        title: "الكل",
                                        imageName: selected.imageName
                                    ) {
                                        // Navigate to all products in this category
                                    }
                                }
                                .transition(
                                    .opacity.combined(with: .move(edge: .top))
                                )
                            }
                        }
                    }
                    .padding(16)
                }
                .refreshable {
                    await viewModel.load()
                }
            case .empty:
                EmptyView()
            case .failed(let message):
                ErrorStateView(  message) {
                    Task { await viewModel.load() }
                }
            }
        }.task {
            if viewModel.state == .idle {
                await viewModel.load()
            }
        }
    }
    
    private func chunkedCategories(_ items: [CategoryItem] )->   [[ CategoryItem]] {
        stride(from: 0, to: items.count, by: 2).map {
            Array(items[$0..<min($0 + 2, items.count)])
        }
    }
    
}
private struct PreviewCategoriesRepository: CategoriesRepository {
    let items: [CategoryItem]
    let shouldFail: Bool
    
    init(items: [CategoryItem] = [], shouldFail: Bool = false) {
        self.items = items
        self.shouldFail = shouldFail
    }
    
    func fetchCategories() async throws -> [CategoryItem] {
        if shouldFail {
            throw URLError(.notConnectedToInternet)
        }
        return items
    }
}

#Preview("Loaded State") {
    CategoriesView(
        repository: PreviewCategoriesRepository(items: [
            CategoryItem(
                id: 1,
                title: "Clothing",
                slug: "clothing",
                subcategories: [
                    CategoryItem(id: 2, title: "T-Shirts", slug: "t-shirts", parentId: 1),
                    CategoryItem(id: 3, title: "Hoodies", slug: "hoodies", parentId: 1)
                ]
            ),
            CategoryItem(
                id: 4,
                title: "Accessories",
                slug: "accessories"
            )
        ])
    )
}

#Preview("Empty State") {
    CategoriesView(repository: PreviewCategoriesRepository(items: []))
}

#Preview("Error State") {
    CategoriesView(repository: PreviewCategoriesRepository(shouldFail: true))
}
