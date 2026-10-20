//
//  ContentView.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 06/10/2026.
//

import SwiftUI

struct ContentView: View {
    
    let configuration: AppConfiguration
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Cuddluxe")
                .font(.largeTitle)
                .bold()
            Text("Environment: \(configuration.environment.rawValue)")
            Text("Host: \(configuration.baseURL.host() ?? "")")
        }
        .padding()
    }
}

#Preview {
    ContentView(configuration: .sample)
}
