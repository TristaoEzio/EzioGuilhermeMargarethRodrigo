//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            ComprasView()
                .tabItem {
                    Label("Compras", systemImage: "cart.circle.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Ajustes", systemImage: "gearshape.circle.fill")
                }
            PurchaseSummaryView()
                .tabItem {
                    Label("Total da compra", systemImage: "dollarsign.circle.fill")
                }
        }
            .accentColor(Color.blue)
    }
}

#Preview {
    MainView()
}
