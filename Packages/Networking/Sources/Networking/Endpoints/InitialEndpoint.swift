//
//  File.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 14/10/2026.
//

import Foundation


extension Endpoint where Response == InitialData {
    public static var initial: Endpoint {
        Endpoint(path: "initial")
    }
}
