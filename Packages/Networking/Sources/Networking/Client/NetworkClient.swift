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
             (data, response) =  try await transport.send(request)
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw NetworkError.noInternet
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw urlError
            }
        }

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

        let envelope = try decoder.decode(
            APIResponse<Response>.self,
            from: data
        )

        if let serverErrors = envelope.errors, !serverErrors.error.isEmpty {
            throw NetworkError.serverError(
                statusCode: envelope.status,
                message: serverErrors.error
            )
        }

        if envelope.status == 401 {
            throw NetworkError.sessionExpired
        }
        
        if envelope.status != 200 {
            throw NetworkError
                .serverError(
                    statusCode: envelope.status,
                    message: envelope.message
                )
        }
        
     
        
        guard let payload = envelope.data else {
            
            throw NetworkError.noData
        }
        
        return payload

    }

    
}
