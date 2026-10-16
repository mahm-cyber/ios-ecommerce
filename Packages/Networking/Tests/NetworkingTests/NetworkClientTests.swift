//
//  Test.swift
//  Networking
//
//  Created by mahmoud on 16/10/2026.
//

import Testing
import Networking
import Foundation
import Core

private struct TestItem: Codable, Equatable, Sendable {
    let id: Int
    let title: String
}

struct NetworkClientTests {

    private func makeNetworkClient(
        transport: HTTPTransport,
           languageSupplier: @Sendable @escaping () -> String = { "ar" },
           tokenSupplier: @Sendable @escaping () -> String? = { nil },
           deviceIDSupplier: @Sendable @escaping () -> String? = { nil }
    ) -> NetworkClient {
        let config = APIConfiguration(
            baseURL: URL(string: "https://example.com")!,
            apiVersion: "v006",
            accountId: "27",
            secretKey: "test_secret"
        )
        let request =  RequestBuilder(config)
        return NetworkClient(
               builder: request,
               transport: transport,
               languageSupplier: languageSupplier,
               tokenSupplier: tokenSupplier,
               deviceIDSupplier: deviceIDSupplier
           )
    }
   private let endpoint = Endpoint<TestItem>(path: "test-item")



    @Test("Success 200", arguments: [
            """
            {
                "status": 200,
                "message": "Success",
                "data": {
                    "id": 1,
                    "title": "Shoes"
                }
            }
        """
    ])

    func sendReturnsDecodedPayloadOn200(json: String) async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.

        // MARK: - Arrange
        let data = try #require(json.data(using: .utf8))
        let transport = TestTransport.returning(statusCode: 200, data: data)

        let client = makeNetworkClient(transport: transport)

        // MARK: - Act
        let result = try await client.send(endpoint)

        // MARK: Assert
        #expect(result == TestItem(id: 1, title: "Shoes"))

    }


    @Test("HTTP 401(Session Expired", arguments: [
            """
            {
                "status": 401,
                "message": "Success",
                "data":  null
            }
        """
    ])
    func sendReturnsDecodedPayloadon401(json: String) async throws {

        // MARK: Arrange
        let data = try #require(json.data(using: .utf8))
        let transport = TestTransport.returning(statusCode: 401, data: data)
        let client = makeNetworkClient(transport: transport)

        // MARK: Act




        await #expect(throws: NetworkError.sessionExpired) {
            try await client.send(endpoint)
        }

    }


    @Test("Envelope 401 (Session Expired)",arguments: [
            """
            {
                "status": 401,
                "message": "Expired",
                "data":  null
            }
        """
    ])
    func sendReturnsEvelopeWith401(json: String) async throws {
        // MARK: Arrange
        let data = try #require(json.data(using: .utf8))
        let transport = TestTransport.returning(statusCode: 200, data: data)
        let client = makeNetworkClient(transport: transport)

        await #expect(throws: NetworkError.sessionExpired) {
            try await client.send(endpoint)
        }


    }

    @Test("Envelope Server Error",arguments: [
            """
            {
                "status": 422,
                "message": "Validation failed",
                "data":  null
            }
        """
    ])
    func sendReturnsServerError(json: String) async throws {
        // MARK: Arrange
        let data = try #require(json.data(using: .utf8))
        let transport = TestTransport.returning(statusCode: 200, data: data)
        let client = makeNetworkClient(transport: transport)

        await #expect(throws: NetworkError.serverError(statusCode: 422, message: "Validation failed")) {
            try await client.send(endpoint)
        }


    }


    @Test("Missing / Null Data on Success",arguments: [
            """
            {
                "status": 200,
                "message": "OK",
                "data":  null
            }
        """
    ])
    func sendReturnsPayloadNoData(json: String) async throws {
        // MARK: Arrange
        let data = try #require(json.data(using: .utf8))
        let transport = TestTransport.returning(statusCode: 200, data: data)
        let client = makeNetworkClient(transport: transport)

        await #expect(throws: NetworkError.noData) {
            try await client.send(endpoint)
        }
    }

    @Test("Supplier Propagation", arguments: [
            """
                        {
                            "status": 200,
                            "message": "Success",
                            "data": {
                                "id": 1,
                                "title": "Shoes"
                            }
                        }
        """
    ])
    func suppliersApplySuccess(json: String) async throws {
        // MARK: Arrange

        let transport = TestTransport { request in
            let capturedRequest = request
             let urlString = capturedRequest.url?.absoluteString
            #expect(urlString?.contains("/en/") == true)
            #expect(request.value(forHTTPHeaderField: "Authorization") == "Bearer token_test")
            #expect(request.value(forHTTPHeaderField: "device_token") == "device_uuid_123")
            let data = try #require(json.data(using: .utf8))
            let response = HTTPURLResponse(
                url: request.url ?? URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return  (data, response)
        }
        let client = makeNetworkClient(
            transport: transport,
            languageSupplier: {"en"},
            tokenSupplier: {"token_test"},
            deviceIDSupplier: {"device_uuid_123"}
        )

        _ = try await client.send(endpoint)

    }


    @Test("HTTP 500 Server Error without decoding")
    func http500ThrowsServerError() async throws {
        let transport = TestTransport.returning(statusCode: 500, data: Data("<html>500 Internal Server Error</html>".utf8))
        let client = makeNetworkClient(transport: transport)

        await #expect(throws: NetworkError.serverError(statusCode: 500, message: nil)) {
            try await client.send(endpoint)
        }
    }

    @Test("HTTP 200 containing errors field")
    func envelopeWithErrorsThrowsServerError() async throws {
        let json = """
        {
            "status": 200,
            "message": "Failed",
            "errors": ["Item is out of stock"],
            "data": null
        }
        """
        let data = Data(json.utf8)
        let transport = TestTransport.returning(statusCode: 200, data: data)
        let client = makeNetworkClient(transport: transport)

        await #expect(throws: NetworkError.serverError(statusCode: 200, message: "Item is out of stock")) {
            try await client.send(endpoint)
        }
    }

    @Test("Offline throws noInternet")
    func offlineThrowsNoInternet() async throws {
        let transport = TestTransport { _ in throw URLError(.notConnectedToInternet) }
        let client = makeNetworkClient(transport: transport)

        await #expect(throws: NetworkError.noInternet) {
            try await client.send(endpoint)
        }
    }

    @Test("Timeout throws timeout")
    func timeoutThrowsTimeout() async throws {
        let transport = TestTransport { _ in throw URLError(.timedOut) }
        let client = makeNetworkClient(transport: transport)

        await #expect(throws: NetworkError.timeout) {
            try await client.send(endpoint)
        }
    }
}
