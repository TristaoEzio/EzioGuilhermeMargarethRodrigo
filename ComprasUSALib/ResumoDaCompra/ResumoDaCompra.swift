import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationView {
            PurchaseSummaryView()
        }
    }
}

struct PurchaseSummaryView: View {
    
    @Query private var compras: [Compra]
    private var total: Double {
        compras.reduce(0) { $0 + $1.valor }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                
                // Valor dos produtos
                VStack (alignment: .leading) {
                    Text("Valor dos produtos ($)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                    Text(total, format: .currency(code: "USD"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .bold()
                }
                .padding()
                
                // Total com impostos
                VStack(alignment: .leading) {
                    Text("Total com impostos ($)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                    Text("$ 1.867,80")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .bold()
                }
                .padding()
                
                // Valor final em reais
                VStack(alignment: .leading) {
                    Text("Valor final em reais")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                    Text("R$ 9.152,22")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .bold()
                }
                .padding()
                Spacer()
                
            }
            .navigationBarTitle("Resumo da Compra")
        }
    }
}

struct PurchaseSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
