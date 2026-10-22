import Testing
import Foundation
import Core
import Data
@testable import FAQFeature

final class FakeFAQRepository: FAQRepository, @unchecked Sendable {
    var result: Result<[FAQItem], Error>

    init(result: Result<[FAQItem], Error>) {
        self.result = result
    }

    func fetchFAQs() async throws -> [FAQItem] {
        try result.get()
    }
}

@Suite("FAQViewModel Tests")
@MainActor
struct FAQViewModelTests {
    
    @Test("Initial state is idle and expanded items are empty")
    func initialState() {
        let repo = FakeFAQRepository(result: .success([]))
        let viewModel = FAQViewModel(repository: repo)
        
        #expect(viewModel.state == .idle)
        #expect(viewModel.expandedItemIDs.isEmpty)
    }

    @Test("Load successfully sets loaded state with items")
    func loadSuccess() async {
        let items = [
            FAQItem(id: 1, question: "What is this?", answer: "This is a test."),
            FAQItem(id: 2, question: "How to use?", answer: "Just click.")
        ]
        let repo = FakeFAQRepository(result: .success(items))
        let viewModel = FAQViewModel(repository: repo)
        
        await viewModel.load()
        
        #expect(viewModel.state == .loaded(items))
    }

    @Test("Load with empty array sets empty state")
    func loadEmpty() async {
        let repo = FakeFAQRepository(result: .success([]))
        let viewModel = FAQViewModel(repository: repo)
        
        await viewModel.load()
        
        #expect(viewModel.state == .empty)
    }

    @Test("Load failure sets failed state with message")
    func loadFailure() async {
        struct TestError: LocalizedError {
            var errorDescription: String? { "Network connection lost" }
        }
        let repo = FakeFAQRepository(result: .failure(TestError()))
        let viewModel = FAQViewModel(repository: repo)
        
        await viewModel.load()
        
        #expect(viewModel.state == .failed("Network connection lost"))
    }

    @Test("Toggle expansion adds and removes item IDs")
    func toggleExpansion() {
        let repo = FakeFAQRepository(result: .success([]))
        let viewModel = FAQViewModel(repository: repo)
        
        viewModel.toggleExpansion(for: 101)
        #expect(viewModel.expandedItemIDs.contains(101))
        
        viewModel.toggleExpansion(for: 102)
        #expect(viewModel.expandedItemIDs.contains(101))
        #expect(viewModel.expandedItemIDs.contains(102))
        
        viewModel.toggleExpansion(for: 101)
        #expect(!viewModel.expandedItemIDs.contains(101))
        #expect(viewModel.expandedItemIDs.contains(102))
    }
}
