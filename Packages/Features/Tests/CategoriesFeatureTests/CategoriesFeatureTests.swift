import Testing
@testable import CategoriesFeature

@Suite("CategoriesFeature Tests")
struct CategoriesFeatureTests {
    @Test("Package Setup Verification")
    func verification() {
        #expect(Bool(true))
    }
}
