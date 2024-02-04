//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import SwiftData
import SwiftUI

struct CompraListingRow: View {
    var compra: Compra
    
    var body: some View {
        HStack(spacing: 12) {
            
            if let data = compra.image,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 80)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(radius: 4, x: 2, y: 2)
            } else {
                Image(systemName: "compraclapper")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 80)
                    .foregroundColor(.gray.opacity(0.3))
                    .clipped()
            }
            
            Text(compra.nome)
            
            Spacer()
            
            Text(compra.valorFinal)
        }
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Compra.self, configurations: configuration)
        let compra = Compra(nome: "Iphone",
                            imposto: 0.0,
                            valor: 10.0,
                            pagamentoCartao: true
        )
        
        return CompraListingRow(compra: compra)
            .modelContainer(container)
    } catch {
        fatalError("Não consegui criar o Preview")
    }
}
