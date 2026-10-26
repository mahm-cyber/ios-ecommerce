import Foundation
import Testing
import Core
import Networking
@testable import Data

// MARK: - Test Fake

private final class FakeBootstrapRepository: BootstrapRepository, @unchecked Sendable {
    var state: BootstrapState
    var loadCallCount = 0
    var loadHandler: (() async throws -> Void)?

    init(state: BootstrapState = .idle, loadHandler: (() async throws -> Void)? = nil) {
        self.state = state
        self.loadHandler = loadHandler
    }

    func load() async throws {
        loadCallCount += 1
        if let handler = loadHandler {
            try await handler()
        }
    }
}

// MARK: - Test Suite

@Suite("CategoriesRepository Tests")
struct CategoriesRepositoryTests {

    private func makeClient(transport: HTTPTransport) -> NetworkClient {
        let config = APIConfiguration(
            baseURL: URL(string: "https://example.com")!,
            apiVersion: "v006",
            accountId: "28",
            secretKey: "test_key"
        )
        let builder = RequestBuilder(config)
        return NetworkClient(
            builder: builder,
            transport: transport,
            languageSupplier: { "en" },
            tokenSupplier: { nil },
            deviceIDSupplier: { "test-device-uuid" }
        )
    }

    private func makeSampleCategoriesJSON() -> Data {
        let json = """
        {
            "status": 200,
            "message": "Initial Data Returned Successfully",
            "data": {
                "version": 12345,
                "categories": [
                    {
                        "categories_id": 1605,
                        "categories_code": "1605",
                        "categories_parent_id": null,
                        "categories_img": "serums.webp",
                        "categories_banner_img": "banner.webp",
                        "categories_title": "Serums & Ampoules",
                        "categories_slug": "serums-ampoules",
                        "subcategories": [
                            {
                                "categories_id": 1607,
                                "categories_code": "1607",
                                "categories_parent_id": 1605,
                                "categories_img": "hydrating.webp",
                                "categories_title": "Hydrating Serums",
                                "categories_slug": "hydrating-serums",
                                "subcategories": []
                            }
                        ]
                    },
                    {
                        "categories_id": 1606,
                        "categories_code": "1606",
                        "categories_parent_id": null,
                        "categories_img": "creams.webp",
                        "categories_title": "Day Creams",
                        "categories_slug": "day-creams",
                        "subcategories": []
                    },
                    {
                        "categories_id": null,
                        "categories_title": null
                    }
                ]
            }
        }
        """
        return Data(json.utf8)
    }

    private func makeSampleBootstrapData(categories: [CategoryItem]) -> BootstrapData {
        BootstrapData(
            storeStatus: .active,
            currency: .default,
            theme: ThemeConfig(themeName: "theme4", primaryColorHex: nil, logoURL: nil),
            minIosVersion: "1.0.0",
            defaultLanguage: "en",
            categories: categories
        )
    }

    // MARK: - Unit Tests

    @Test("fetchCategories returns cached categories immediately without reloading")
    func returnsCachedCategoriesWithoutReloading() async throws {
        let sampleCategories = [
            CategoryItem(id: 1, title: "Skincare", slug: "skincare"),
            CategoryItem(id: 2, title: "Bodycare", slug: "bodycare")
        ]
        let bootstrapData = makeSampleBootstrapData(categories: sampleCategories)
        let fake = FakeBootstrapRepository(state: .loaded(bootstrapData))
        let repository = AppCategoriesRepository(bootstrapRepository: fake)

        let result = try await repository.fetchCategories()

        #expect(result == sampleCategories)
        #expect(fake.loadCallCount == 0)
    }

    @Test("fetchCategories triggers load when bootstrap repository is idle")
    func triggersLoadWhenIdle() async throws {
        let sampleCategories = [
            CategoryItem(id: 10, title: "Perfumes", slug: "perfumes")
        ]
        let fake = FakeBootstrapRepository(state: .idle)
        fake.loadHandler = { [weak fake] in
            fake?.state = .loaded(self.makeSampleBootstrapData(categories: sampleCategories))
        }

        let repository = AppCategoriesRepository(bootstrapRepository: fake)
        let result = try await repository.fetchCategories()

        #expect(fake.loadCallCount == 1)
        #expect(result == sampleCategories)
    }

    @Test("fetchCategories re-throws error when bootstrap repository fails")
    func rethrowsErrorOnFailure() async {
        let fake = FakeBootstrapRepository(state: .failed(.noInternet))
        let repository = AppCategoriesRepository(bootstrapRepository: fake)

        await #expect(throws: NetworkError.self) {
            try await repository.fetchCategories()
        }
    }

    @Test("AppBootstrapRepository maps hierarchical categories and discards invalid ones")
    func mapsHierarchicalCategoriesTree() async throws {
        let transport = TestTransport { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (self.makeSampleCategoriesJSON(), response)
        }

        let client = makeClient(transport: transport)
        let bootstrapRepo = AppBootstrapRepository(networkClient: client)
        let categoriesRepo = AppCategoriesRepository(bootstrapRepository: bootstrapRepo)

        let categories = try await categoriesRepo.fetchCategories()

        // Verify invalid/corrupted DTO was discarded
        #expect(categories.count == 2)

        // Verify parent category
        let parent = categories[0]
        #expect(parent.id == 1605)
        #expect(parent.title == "Serums & Ampoules")
        #expect(parent.slug == "serums-ampoules")
        #expect(parent.imageName == "serums.webp")
        #expect(parent.bannerImageName == "banner.webp")
        #expect(parent.parentId == nil)

        // Verify nested subcategory
        #expect(parent.subcategories.count == 1)
        let sub = parent.subcategories[0]
        #expect(sub.id == 1607)
        #expect(sub.title == "Hydrating Serums")
        #expect(sub.slug == "hydrating-serums")
        #expect(sub.imageName == "hydrating.webp")
        #expect(sub.parentId == 1605)
        #expect(sub.subcategories.isEmpty)

        // Verify second category
        let second = categories[1]
        #expect(second.id == 1606)
        #expect(second.title == "Day Creams")
        #expect(second.subcategories.isEmpty)
    }
}
