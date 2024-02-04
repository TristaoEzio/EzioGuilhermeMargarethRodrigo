//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import SwiftUI

struct ComprasView: View {
    @State private var path = NavigationPath()
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Compra.nome)
    @State private var searchString = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            CompraListingView(sortOrder: sortOrder, searchString: searchString)
                .navigationTitle("Lista de Compras")
                .navigationDestination(for: NavigationType.self) { type in
                    switch type {
                    case .detail(let compra):
                        CompraDetailView(compra: compra, path: $path)
                    case .form(let compra):
                        CompraFormView(compra: compra, path: $path)
                    }
                }
                .toolbar {
                    Button("", systemImage: "plus") {
                        path = NavigationPath([NavigationType.form(nil)])
                    }
                }
        }
    }
}

#Preview {
    ComprasView()
}
