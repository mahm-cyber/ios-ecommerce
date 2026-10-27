//
//  AppRootView.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 20/10/2026.
//

import SwiftUI
import Data
import Core
import DesignSystem

struct AppRootView: View {
    
    let container: AppContainer
    
    var state: BootstrapState {
        container.bootstrapRepository.state
    }

    private var currentTheme: AppTheme {
        switch state {
        case .loaded(let bootstrapData):
            return AppTheme.init(themeConfig: bootstrapData.theme)
        case .idle, .loading, .failed:
            return .default
        }
    }
    
    private var config: AppConfiguration {
        return container.appConfiguration
    }
    
    private var imageURLBuilder: ImageURLBuilder {
        let imagesURL: URL? = {
            if case .loaded(let bootstrapData) = state {
                return bootstrapData.imagesURL
            }
            return config.baseURL
        }()
        
        return ImageURLBuilder(baseURL: imagesURL, accountID: config.accountID)
    }
    
    var body: some View {
        Group {
            switch state {
            case .idle, .loading:
                SplashView()
                    .task {
                        try? await container.bootstrapRepository.load()
                    }
            case .loaded(let bootstrapData):
                switch bootstrapData.storeStatus {
                case .active:
                    ContentView(
                        configuration: container.appConfiguration,
                        faqRepository: container.faqRepository
                    )
                case .maintenance(let message):
                    MaintenanceView(message: message)
                case .ordersDisabled(_):
                    ContentView(
                        configuration: container.appConfiguration,
                        faqRepository: container.faqRepository,
                        categoriesRepository: container.categoriesRepository
                    )
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
        .appTheme(currentTheme)
        .imageURLBuilder(imageURLBuilder)
    }
}

#Preview {
    AppRootView(
        container: AppContainer(appConfiguration:  .sample)
    )
}
