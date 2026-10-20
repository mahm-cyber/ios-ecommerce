//
//  UserAgent.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 20/10/2026.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public struct UserAgent: Sendable {
    
    /// Formats a User-Agent string adhering to the legacy Flutter application specification:
    /// `Mozilla/5.0 (iPhone; CPU iPhone OS <osVersion> like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/<systemVersion> Mobile/15E148 Safari/604.1 FlutterApp/<appVersion> DeviceId/<deviceId>`
    public static func format(
        systemVersion: String,
        appVersion: String,
        deviceId: String
    ) -> String {
        let osVersion = systemVersion.replacingOccurrences(of: ".", with: "_")
        return "Mozilla/5.0 (iPhone; CPU iPhone OS \(osVersion) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(systemVersion) Mobile/15E148 Safari/604.1 FlutterApp/\(appVersion) DeviceId/\(deviceId)"
    }
    
    #if canImport(UIKit)
    /// Constructs the current runtime User-Agent using UIKit device and bundle metadata.
    ///
    /// - Parameter deviceId: An optional explicit device UUID. When omitted, defaults to
    ///   `UIDevice.current.identifierForVendor?.uuidString`.
    public static func current(deviceId: String? = nil) -> String {
        let systemVersion = UIDevice.current.systemVersion
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        let vendorId = UIDevice.current.identifierForVendor?.uuidString
        let resolvedDeviceId = deviceId ?? vendorId ?? ""
        return format(
            systemVersion: systemVersion,
            appVersion: appVersion,
            deviceId: resolvedDeviceId
        )
    }
    #endif
}
