//
//  AppRootView.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 20/10/2026.
//

import SwiftUI
import Data
internal import Core
 

struct AppRootView: View {
    
    let container: AppContainer
    
    var state: BootstrapState {
        container.bootstrapRepository.state
    }
    var body: some View {
        
        switch state {
        case .idle, .loading:
            SplashView()
                .task {
                    try? await container.bootstrapRepository.load()
                }
        case .loaded(let bootstrapData):
            switch bootstrapData.storeStatus {
            case .active:
                ContentView(configuration: container.appConfiguration)
            case .maintenance(let message):
                MaintenanceView(message: message)
            case .ordersDisabled(_):
                ContentView(configuration: container.appConfiguration)
            }
        case .failed(let networkError):
            ContentUnavailableView {
                Label("Connection Error", systemImage: "wifi.exclamationmark")
            } description: {
                Text(networkError.localizedDescription)
            } actions: {
                Button("Retry") {
                    Task {
                        try? await container.bootstrapRepository.load()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    AppRootView(
        container: AppContainer(appConfiguration:  .sample)
    )
}
