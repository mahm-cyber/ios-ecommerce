import Testing
@testable import FAQFeature

@Suite("FAQFeature Tests")
struct FAQFeatureTests {
    @Test("Package Setup Verification")
    func verification() {
        #expect(Bool(true))
    }
}
