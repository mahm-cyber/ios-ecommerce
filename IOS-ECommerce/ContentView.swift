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
        VStack {
            Text("Our Environment is:- \(configuration.environment)")
            Text("Our host is \(configuration.baseURL.host())")
        }
        .padding()
        
    }
}

#Preview {
    ContentView(configuration: .sample)
}
