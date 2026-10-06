//
//  IOS_ECommerceApp.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import SwiftUI

@main
struct IOS_ECommerceApp: App {
    
    private let container: AppContainer
    
    init() {
        do {
            let appConfiguration = try AppConfiguration.fromMainBundle()
            container = AppContainer(appConfiguration: appConfiguration)

        } catch {
            fatalError("App Can't launch due to \(error)")
        }
    }
   
    var body: some Scene {
        WindowGroup {
            ContentView(configuration: container.appConfiguration)
        }
        
    }
}
