//
//  CompraPlayer.swift
//  ComprasLib
//
//  Created by Eric Alves Brito on 23/10/23.
//

import AVKit
import SwiftUI

struct CompraPlayer: View {
    @Environment(\.dismiss) var dismiss
    let compraInfo: CompraInfo

    var player: AVPlayer? {
        guard let url = compraInfo.url else { return nil}
        let player = AVPlayer(url: url)
        player.play()
        return player
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            if let player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
            } else {
                Rectangle()
                    .fill(.black)
                    .ignoresSafeArea()
                    .overlay {
                        Text("Erro ao carregar vídeo")
                            .foregroundStyle(.white)
                    }
            }

            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.up.left.arrow.down.right")
                    .tint(.white)
            }
            .padding()
        }
    }
}

#Preview {
    CompraPlayer(compraInfo: CompraInfo(previewUrl: ""))
}
