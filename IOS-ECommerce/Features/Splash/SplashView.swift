//
//  SplashView.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 20/10/2026.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        
        
        VStack {
            
            Spacer()
            
            Text("Cuddluxe")
                .font(.title)
                .bold()
                
            Spacer()
            
            ProgressView()
            
            Spacer()
            
        }
    }
}

#Preview {
    SplashView()
}
