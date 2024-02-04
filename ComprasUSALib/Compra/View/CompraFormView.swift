//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import PhotosUI
import SwiftData
import SwiftUI

struct CompraFormView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var compra: Compra
    @Binding var path: NavigationPath
    @State private var selectedPoster: PhotosPickerItem?
    @State private var posterImageData: Data?
    
    init(compra: Compra? = nil, path: Binding<NavigationPath>) {
        self.compra = compra ?? Compra()
        self._path = path
    }
    
    var body: some View {
        VStack {
            form
            saveButton
        }
    }
    
    private var form: some View {
        Form {
            Section("Nome do Produto") {
                TextField("Escreva o nome do produto", text: $compra.nome)
            }
            
            Section("Imposto do estado (%)") {
                TextField("0", value: $compra.imposto, format: .number)
                    .keyboardType(.numberPad)
            }
            
            Section("Valor do Produto") {
                TextField("0", value: $compra.valor, format: .number)
                    .keyboardType(.numberPad)
            }
            
            Section("Meio de Pagamento") {
                Toggle("Pagou com Cartão", isOn: $compra.pagamentoCartao)
                
            }
            
            Section("Foto") {
                PhotosPicker(selection: $selectedPoster,
                             matching: .images) {
                    Label("Escolher foto", systemImage: "photo" )
                }
                
                if let posterImageData,
                   let uiimage = UIImage(data: posterImageData) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
            }
        }
        .listSectionSpacing(3)
        .navigationTitle(compra.nome.isEmpty ? "Cadastro" : compra.nome)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedPoster) {
            Task {
                posterImageData = try? await selectedPoster?.loadTransferable(type: Data.self)
                compra.image = posterImageData
            }
            
        }
    }
    @State var showAlert = false
    private var saveButton: some View {
        Button {
            if(compra.imposto.isZero || compra.nome.isEmpty || compra.valor.isZero ||
               compra.image == nil){
                showAlert = true
            } else {
                modelContext.insert(compra)
                path.removeLast()
            }
            
        } label: {
            Text("Cadastrar")
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(16)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alerta Importante"),
                message: Text("Preencha todos os campos"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Compra.self, configurations: configuration)
        let compra = Compra(nome: "",
                            imposto: 0,
                            valor: 10.0,
                            pagamentoCartao: true)
        
        return CompraFormView(compra: compra, path: .constant(NavigationPath()))
            .modelContainer(container)
    } catch {
        fatalError("Não consegui criar o Preview")
    }
}
