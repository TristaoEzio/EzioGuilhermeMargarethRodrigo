//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import SwiftUI

struct SettingsView: View {

    @State private var cotaçãoDoDolar: String = "4.9"
    @State private var IOF: String = "5.38"

    var body: some View {
        NavigationStack {
            Form {
                Section("Cotação do dolar") {
                    TextField("4.9", text: $cotaçãoDoDolar)
                        .keyboardType(.numberPad)
                        
                }
                
                Section("IOF (%)") {
                    TextField("5.38", text: $IOF)
                        .keyboardType(.numberPad)
                        
                }
            }
            .navigationTitle("Ajustes")
        }
    }
}

#Preview {
    SettingsView()
}
