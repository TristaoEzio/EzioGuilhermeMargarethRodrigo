//
//  ComprasLibApp.swift
//  ComprasLib
//
//  Created by 2MOBR on 02/02/2024
//

import Foundation

struct ItunesResult: Decodable {
    let results: [CompraInfo]
}

struct CompraInfo: Decodable, Identifiable {
    let previewUrl: String
    var id: String {
        previewUrl
    }

    var url: URL? {
        URL(string: previewUrl)
    }
}
