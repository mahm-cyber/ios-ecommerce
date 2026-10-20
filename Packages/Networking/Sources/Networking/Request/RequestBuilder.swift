//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 12/10/2026.
//

import Foundation
import Core

public struct RequestBuilder: Sendable {
    let apiConfig: APIConfiguration
    let userAgent: String
    
    private let contentHeaderKey = "Content-Type"
    private let acceptValue = "application/json"
    private let acceptHeaderKey = "Accept"
    private let secretHeaderKey = "Secretkey"
    private let userAgentHeaderKey = "User-Agent"
    private let xRequestedWithValue = "XMLHttpRequest"
    private let xRequestedWithHeaderKey = "X-Requested-With"
    private let authrizationHeaderKey = "Authorization"
    private let deviceIdHeaderKey = "device_token"
    
    public init(_ apiConfiguration: APIConfiguration, userAgent: String? = nil) {
        self.apiConfig = apiConfiguration
        #if canImport(UIKit)
        self.userAgent = userAgent ?? UserAgent.current()
        #else
        self.userAgent = userAgent ?? "PolarisMax-iOS"
        #endif
    }


    public func buildURLRequest<Response>(for endpoint: Endpoint<Response>, language: String, token: String? = nil, deviceID: String? = nil) throws -> URLRequest {
        
        let url = apiConfig.baseURL
            .appending(path: language)
            .appending(path: "api")
            .appending(path: apiConfig.apiVersion)
            .appending(path: endpoint.path)
  
        guard  var  components =  URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkError.invalidURL
        }
        
        var queries = endpoint.queries

        if  endpoint.method == .get  {
            queries
                .append(
                    URLQueryItem(name: "accountId", value: apiConfig.accountId)
                )
        }
        
        if !queries.isEmpty {
            components.queryItems = queries
        }
        
        guard let finalURL = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = endpoint.method.rawValue
     
        request.timeoutInterval = 30.0
        request.setValue(acceptValue, forHTTPHeaderField: acceptHeaderKey)
        request.setValue(apiConfig.secretKey, forHTTPHeaderField: secretHeaderKey)
        request.setValue(userAgent, forHTTPHeaderField: userAgentHeaderKey)
        request.setValue(xRequestedWithValue, forHTTPHeaderField:  xRequestedWithHeaderKey)
        
        if let body = endpoint.body,  !body.isEmpty {
            request.setValue(acceptValue, forHTTPHeaderField: contentHeaderKey)
            request.httpBody = body
        }

        if let token,  !token.isEmpty {
                request.setValue("Bearer \(token)", forHTTPHeaderField: authrizationHeaderKey)
        }

        if let deviceID, !deviceID.isEmpty {
            request.setValue(deviceID, forHTTPHeaderField: deviceIdHeaderKey)
        }


       return request
    }
}
