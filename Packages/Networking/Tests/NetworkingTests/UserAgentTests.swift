//
//  UserAgentTests.swift
//  Networking
//
//  Created by NamaaIT Apple3 on 20/10/2026.
//

import Testing
import Foundation
@testable import Networking

struct UserAgentTests {
    
    @Test
    func formatWithFullVersionAndDeviceUUID() {
        let ua = UserAgent.format(
            systemVersion: "17.5.1",
            appVersion: "1.2.3",
            deviceId: "9B249C02-763C-4997-9097-F648A763D5F9"
        )
        
        let expected = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5.1 Mobile/15E148 Safari/604.1 FlutterApp/1.2.3 DeviceId/9B249C02-763C-4997-9097-F648A763D5F9"
        #expect(ua == expected)
    }

    @Test
    func formatReplacesDotsWithUnderscoresOnlyInCPUField() {
        let ua = UserAgent.format(
            systemVersion: "18.0",
            appVersion: "1.0.0",
            deviceId: "device-123"
        )
        
        #expect(ua.contains("CPU iPhone OS 18_0 like Mac OS X"))
        #expect(ua.contains("Version/18.0"))
        #expect(ua.contains("FlutterApp/1.0.0"))
        #expect(ua.contains("DeviceId/device-123"))
    }

    #if canImport(UIKit)
    @Test
    func currentGeneratesValidFormat() {
        let ua = UserAgent.current(deviceId: "custom-device-id")
        
        #expect(ua.hasPrefix("Mozilla/5.0 (iPhone; CPU iPhone OS "))
        #expect(ua.contains("AppleWebKit/605.1.15 (KHTML, like Gecko) Version/"))
        #expect(ua.contains("Mobile/15E148 Safari/604.1 FlutterApp/"))
        #expect(ua.hasSuffix("DeviceId/custom-device-id"))
    }
    #endif
}
