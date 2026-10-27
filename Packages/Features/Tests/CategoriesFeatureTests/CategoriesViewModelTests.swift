import Testing
import Foundation
import Core
import Data
@testable import CategoriesFeature

final class FakeCategoriesRepository: CategoriesRepository, @unchecked Sendable {
    var result: Result<[CategoryItem], Error>

    init(result: Result<[CategoryItem], Error>) {
        self.result = result
    }

    func fetchCategories() async throws -> [CategoryItem] {
        try result.get()
    }
}

@Suite("CategoriesViewModel Tests")
@MainActor
struct CategoriesViewModelTests {

    @Test("Initial state is idle")
    func initialState() {
        let repo = FakeCategoriesRepository(result: .success([]))
        let viewModel = CategoriesViewModel(repository: repo)
        
        #expect(viewModel.state == .idle)
    }

    @Test("Load successfully sets loaded state with categories")
    func loadSuccess() async {
        let subcategory = CategoryItem(id: 2, title: "T-Shirts", slug: "t-shirts", parentId: 1)
        let rootCategory = CategoryItem(id: 1, title: "Clothing", slug: "clothing", subcategories: [subcategory])
        let categories = [rootCategory]
        
        let repo = FakeCategoriesRepository(result: .success(categories))
        let viewModel = CategoriesViewModel(repository: repo)
        
        await viewModel.load()
        
        #expect(viewModel.state == .loaded(categories))
    }

    @Test("Load with empty array sets empty state")
    func loadEmpty() async {
        let repo = FakeCategoriesRepository(result: .success([]))
        let viewModel = CategoriesViewModel(repository: repo)
        
        await viewModel.load()
        
        #expect(viewModel.state == .empty)
    }

    @Test("Load failure sets failed state with error description")
    func loadFailure() async {
        struct TestError: LocalizedError {
            var errorDescription: String? { "Failed to load categories" }
        }
        let repo = FakeCategoriesRepository(result: .failure(TestError()))
        let viewModel = CategoriesViewModel(repository: repo)
        
        await viewModel.load()
        
        #expect(viewModel.state == .failed("Failed to load categories"))
    }
}
