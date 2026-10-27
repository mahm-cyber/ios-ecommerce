//
//  ContentView.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import SwiftUI
import FAQFeature
import Data
import CategoriesFeature

struct ContentView: View {
    let configuration: AppConfiguration
    let faqRepository: FAQRepository?
    let categoriesRepository: CategoriesRepository?

    init(
        configuration: AppConfiguration,
        faqRepository: FAQRepository? = nil,
        categoriesRepository: CategoriesRepository? = nil
    ) {
        self.configuration = configuration
        self.faqRepository = faqRepository
        self.categoriesRepository = categoriesRepository
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Cuddluxe")
                    .font(.largeTitle)
                    .bold()
                Text("Environment: \(configuration.environment.rawValue)")
                Text("Host: \(configuration.baseURL.host() ?? "")")

                if let faqRepository {
                    NavigationLink {
                        FAQView(repository: faqRepository)
                    } label: {
                        Text("Frequently Asked Questions")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 24)
                }
                
                if let categoriesRepository {
                    NavigationLink {
                        CategoriesView(repository: categoriesRepository)
                        
                    } label: {
                        Text("Categories")
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
        }
    }
}

#Preview {
    ContentView(configuration: .sample)
}
