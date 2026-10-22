import Foundation
import Testing
import Core
import Networking
@testable import Data

@Suite("FAQRepository Tests")
struct FAQRepositoryTests {

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

    private func makeQuestionsJSON() -> Data {
        let json = """
        {
            "status": 200,
            "message": "questions Data Returned Successfully",
            "data": {
                "questions": [
                    {
                        "questions_id": 33,
                        "questions_question": "Can I request a custom-made item?",
                        "questions_answer": "<p>Currently, we offer ready-made items only.</p><p>&nbsp;</p>"
                    },
                    {
                        "questions_id": 34,
                        "questions_question": "How can I track my order?",
                        "questions_answer": "<p>Once your order is shipped, you will receive a tracking number.</p>"
                    }
                ]
            }
        }
        """
        return Data(json.utf8)
    }

    // MARK: - Tests

    @Test("strippingHTML removes tags and entities")
    func strippingHTMLRemovesTagsAndEntities() {
        let rawHTML = "<p>Currently, we offer ready-made items only.</p><p>&nbsp;</p>"
        let clean = rawHTML.strippingHTML()

        #expect(clean == "Currently, we offer ready-made items only.")

        let plainText = "Plain text without HTML"
        #expect(plainText.strippingHTML() == "Plain text without HTML")
    }

    @Test("fetchFAQs returns clean domain items on HTTP 200")
    func fetchFAQsSuccess() async throws {
        let transport = TestTransport { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (self.makeQuestionsJSON(), response)
        }

        let client = makeClient(transport: transport)
        let repo = AppFAQRepository(networkingClient: client)

        let items = try await repo.fetchFAQs()

        #expect(items.count == 2)
        #expect(items[0].id == 33)
        #expect(items[0].question == "Can I request a custom-made item?")
        #expect(items[0].answer == "Currently, we offer ready-made items only.")
        #expect(items[1].id == 34)
        #expect(items[1].question == "How can I track my order?")
        #expect(items[1].answer == "Once your order is shipped, you will receive a tracking number.")
    }

    @Test("fetchFAQs propagates network errors")
    func fetchFAQsPropagatesError() async {
        let transport = TestTransport { _ in
            throw URLError(.notConnectedToInternet)
        }

        let client = makeClient(transport: transport)
        let repo = AppFAQRepository(networkingClient: client)

        await #expect(throws: NetworkError.self) {
            try await repo.fetchFAQs()
        }
    }
}
