//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 12/10/2026.
//

import Foundation


public struct APIConfiguration: Sendable {
      let baseURL: URL
      let apiVersion: String
      let accountId: String
      let secretKey: String
    
    
    public init(
        baseURL: URL,
        apiVersion: String,
        accountId: String,
        secretKey: String
    ) {
        self.baseURL = baseURL
        self.apiVersion = apiVersion
        self.accountId = accountId
        self.secretKey = secretKey
    }
}
