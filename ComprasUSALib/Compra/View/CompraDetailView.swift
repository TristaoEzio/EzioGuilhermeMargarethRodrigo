//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import AVKit
import SwiftData
import SwiftUI

struct CompraDetailView: View {
    @Bindable var compra: Compra
    @Binding var path: NavigationPath
    
    
    // MARK: - Body
    var body: some View {
        VStack {
            image
            VStack(alignment: .leading) {
                nome
                pagamentoCartao
                valor
                imposto
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .top)
            
            Spacer()
        }
        
        .toolbar {
            Button("Editar") {
                path.append(NavigationType.form(compra))
            }
        }
    }
    
    
    // MARK: - Imposto
    private var imposto: some View {
        Text(String(compra.imposto))
    }
    
    
    // MARK: - Pagamento Cartão
    private var pagamentoCartao: some View {
        Toggle("Pagamento com Cartão", isOn: $compra.pagamentoCartao)
            .disabled(true) 
    }
    
    // MARK: - Nome
    private var nome: some View {
        Text(compra.nome)
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
    }
    
    // MARK: - Valor
    private var valor:some View {
        Text(compra.valorFinal)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
    }
    
    // MARK: - Image
    @ViewBuilder
    private var image: some View {
        if let data = compra.image,
           let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipped()
                .mask {
                    LinearGradient(stops: [.init(color: .black, location: 0.75),
                                           .init(color: .clear, location: 1),
                    ],
                                   startPoint: .top,
                                   endPoint: .bottom)
                }
        } else {
            Image(systemName: "compraclapper")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray.opacity(0.3))
                .padding(40)
                .frame(height: 400)
        }
    }
}

// MARK: Preview
#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Compra.self, configurations: configuration)
        let compra = Compra(
            nome: "Iphone",
            imposto: 0.0,
            valor: 10.0
        )
        
        return CompraDetailView(compra: compra, path: .constant(NavigationPath()))
            .modelContainer(container)
    } catch {
        fatalError("Não consegui criar o Preview")
    }
}
