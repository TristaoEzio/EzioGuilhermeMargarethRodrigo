//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import SwiftData
import SwiftUI

enum NavigationType: Hashable {
    case detail(Compra)
    case form(Compra?)
}

struct CompraListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var compras: [Compra]
    
    init(sortOrder: SortDescriptor<Compra>, searchString: String) {
        _compras = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.nome.localizedStandardContains(searchString)
            }
        },
                         sort: [sortOrder])
    }
    
    private var listIsEmpty:some View {
        Text("Sua lista de compras está vazia")
            .italic()
            .multilineTextAlignment(.leading)
    }
    
    var body: some View {
        if(compras.count > 0) {
            List {
                ForEach(compras) { compra in
                    NavigationLink(value: NavigationType.detail(compra)) {
                        CompraListingRow(compra: compra)
                    }
                }
                .onDelete(perform: deleteCompra)
            }
        } else {
            listIsEmpty
        }
    }
    
    private func deleteCompra(_ indexSet: IndexSet) {
        for index in indexSet {
            let compra = compras[index]
            modelContext.delete(compra)
        }
    }
}

#Preview {
    CompraListingView(sortOrder: SortDescriptor(\Compra.nome), searchString: "")
}
