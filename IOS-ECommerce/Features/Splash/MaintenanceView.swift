//
//  MaintenanceView.swift
//  IOS-ECommerce
//
//  Created by NamaaIT Apple3 on 20/10/2026.
//

import SwiftUI

struct MaintenanceView: View {
    
    let message: String?
    
    var body: some View {
        ContentUnavailableView(
            message ?? "", systemImage: "wrench.and.screwdriver"
        )
    }
}

#Preview {
    MaintenanceView(message: "The App is under maintenance")
}
