//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 12/10/2026.
//

import Foundation


public struct RequestBuilder: Sendable {
    let apiConfig: APIConfiguration

    private let acceptValue = "application/json"
    private let acceptHeaderKey = "Accept"
    private let secretHeaderKey = "SecretKey"
    private let userAgentValue = "PolarisMax-iOS"
    private let userAgentHeaderKey = "User-Agent"
    private let xRequestedWithValue = "XMLHttpRequest"
    private let xRequestedWithHeaderKey = "X-Requested-With"
    private let authrizationHeaderKey = "Authorization"
    private let deviceIdHeaderKey = "device_token"
    public init(_ apiConfiguration: APIConfiguration) {
        apiConfig = apiConfiguration
    }


    public func buildURLRequest<Response>(for endpoint: Endpoint<Response>, language: String, token: String? = nil, deviceID: String? = nil,) throws -> URLRequest {
        guard  let  urlComponents =  URLComponents(url: apiConfig.baseURL, resolvingAgainstBaseURL: true) else {
            throw NetworkError.invalidURL
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 30.0
        request.setValue(acceptValue, forHTTPHeaderField: acceptHeaderKey)
        request.setValue(apiConfig.secretKey, forHTTPHeaderField: secretHeaderKey)
        request.setValue(userAgentValue, forHTTPHeaderField: userAgentHeaderKey)
        request.setValue(xRequestedWithValue, forHTTPHeaderField:  xRequestedWithHeaderKey)

        if token != nil || token?.isEmpty == false {
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: authrizationHeaderKey)
        }

        if deviceID != nil {
            if deviceID?.isEmpty == false {
                request.setValue("\(deviceID ?? "")", forHTTPHeaderField: deviceIdHeaderKey)
            }
        }



       return request
    }
}
