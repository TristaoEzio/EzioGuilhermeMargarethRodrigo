//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import Foundation
import SwiftData

@Model
class Compra {
    var nome: String
    var imposto: Double
    var valor: Double
    var pagamentoCartao: Bool
    var image: Data?
    var valorFinal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: valor)) ?? ""
    }
    
    init(nome: String = "", imposto: Double = 0, valor: Double = 0.0, image: Data? = nil, pagamentoCartao:Bool = false ) {
        self.nome = nome
        self.imposto = imposto
        self.valor = valor
        self.image = image
        self.pagamentoCartao = pagamentoCartao
    }
}
