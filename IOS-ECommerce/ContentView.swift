//
//  ContentView.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import SwiftUI
import Data
import Core

// MARK: Features
import FAQFeature
import CategoriesFeature
import ProductsFeature
import ProductDetailFeature


private enum AppRoute: Hashable {
    case faq
    case categories
    case products
}

struct ContentView: View {
    let configuration: AppConfiguration
    let faqRepository: FAQRepository?
    let categoriesRepository: CategoriesRepository?
    let productesRepository: ProductsRepository?

    init(
        configuration: AppConfiguration,
        faqRepository: FAQRepository? = nil,
        categoriesRepository: CategoriesRepository? = nil,
        productesRepository: ProductsRepository? = nil
    ) {
        self.configuration = configuration
        self.faqRepository = faqRepository
        self.categoriesRepository = categoriesRepository
        self.productesRepository = productesRepository
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Cuddluxe")
                    .font(.largeTitle)
                    .bold()
                Text("Environment: \(configuration.environment.rawValue)")
                Text("Host: \(configuration.baseURL.host() ?? "")")

                // MARK: FAQView
                if let faqRepository {
                    NavigationLink(value: AppRoute.faq) {
                        Text("Frequently Asked Questions")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 24)
                }
                
                // MARK: CategoriesView
                if let categoriesRepository {
                    NavigationLink(value: AppRoute.categories) {
                        Text("Categories")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 24)
                }
                
                // MARK: ProductsView
                if let productesRepository {
                    NavigationLink(value: AppRoute.products) {
                        Text("Products")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding()
            .navigationTitle("Home")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .faq:
                    if let faqRepository {
                        FAQView(repository: faqRepository)
                    }
                case .categories:
                    if let categoriesRepository {
                        CategoriesView(repository: categoriesRepository)
                    }
                case .products:
                    if let productesRepository {
                        ProductsView(repository: productesRepository)
                    }
                }
            }
            .navigationDestination(for: ProductItem.self) { product in
                if let productesRepository {
                    ProductDetailView(
                        productItem: product,
                        repository: productesRepository
                    )
                }
            }
        }
    }
}

#Preview {
    let container = AppContainer(appConfiguration: .sample)
    ContentView(
        configuration: container.appConfiguration,
        faqRepository: container.faqRepository,
        categoriesRepository: container.categoriesRepository,
        productesRepository: container.productsRepository
    )
}
