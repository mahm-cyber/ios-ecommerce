//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 15/10/2026.
//

import Foundation
import Core


public struct NetworkClient: Sendable{
    
    private let builder: RequestBuilder
    private let transport: HTTPTransport
    private let languageSupplier: @Sendable () -> String
    private let tokenSupplier: @Sendable () -> String?
    private let deviceIDSupplier: @Sendable () -> String?
    private let decoder: JSONDecoder
    
    public init(
        builder: RequestBuilder,
        transport: HTTPTransport = URLSession.shared,
        languageSupplier: @Sendable @escaping () -> String = { "ar" },
        tokenSupplier: @Sendable @escaping () -> String? = { nil },
        deviceIDSupplier: @Sendable @escaping () -> String? = { nil },
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.builder = builder
        self.transport = transport
        self.languageSupplier = languageSupplier
        self.tokenSupplier = tokenSupplier
        self.deviceIDSupplier = deviceIDSupplier
        self.decoder = decoder
    }
    
     
    public func send<Response>(_ endpoint: Endpoint<Response>) async throws -> Response {
        let request = try builder.buildURLRequest(
            for: endpoint,
            language: languageSupplier(),
            token: tokenSupplier(),
            deviceID: deviceIDSupplier()
        )
        
        let (data, response): (Data, URLResponse)
        do {
             (data, response) = try await transport.send(request)
        } catch let urlError as URLError {
            #if DEBUG
            print("""
            ❌ [Network Error] \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")
            ⚠️ URLError: \(urlError.localizedDescription) (code: \(urlError.code.rawValue))
            """)
            #endif
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw NetworkError.noInternet
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw urlError
            }
        }

        #if DEBUG
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        let bodyString: String
        if let jsonObject = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted, .sortedKeys]),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            bodyString = prettyString
        } else {
            bodyString = String(data: data, encoding: .utf8) ?? "<non-utf8: \(data.count) bytes>"
        }
        print("""
        ==================== [Network] ====================
        🌐 \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")
        📥 HTTP Status: \(statusCode)
        📦 Response:
        \(bodyString)
        ===================================================
        """)
        #endif

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        if httpResponse.statusCode == 401 {
            throw NetworkError.sessionExpired
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(
                statusCode: httpResponse.statusCode,
                message: nil
            )
        }

        let envelope: APIResponse<Response>
        do {
            envelope = try decoder.decode(
                APIResponse<Response>.self,
                from: data
            )
        } catch {
            #if DEBUG
            print("""
            ==================== [Decoding Error] ====================
            ❌ Failed to decode \(Response.self):
            Error: \(error)
            ==========================================================
            """)
            #endif
            throw NetworkError.serverError(
                statusCode: httpResponse.statusCode,
                message: "Decoding failed: \(error.localizedDescription)"
            )
        }

        let envelopeStatus = envelope.status ?? httpResponse.statusCode

        if let serverErrors = envelope.errors, !serverErrors.error.isEmpty {
            throw NetworkError.serverError(
                statusCode: envelopeStatus,
                message: serverErrors.error
            )
        }

        if envelopeStatus == 401 {
            throw NetworkError.sessionExpired
        }
        
        if envelopeStatus != 200 {
            throw NetworkError.serverError(
                statusCode: envelopeStatus,
                message: envelope.message
            )
        }
        
     
        
        guard let payload = envelope.data else {
            
            throw NetworkError.noData
        }
        
        return payload

    }

    
}
