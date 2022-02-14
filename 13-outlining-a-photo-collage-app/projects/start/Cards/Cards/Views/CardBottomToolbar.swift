//
//  CardBottomToolbar.swift
//  Cards
//
//  Created by 陶涛 on 2022/2/14.
//

import SwiftUI

struct ToolbarButtonView: View {
    let cardModal: CardModal
    var body: some View {
        if let text = modalButton[cardModal]?.text, let imageName = modalButton[cardModal]?.imageName {
            VStack {
                Image(systemName: imageName)
                    .font(.largeTitle)
                Text(text)
            }
            .padding(.top)
        }
    }

    private let modalButton: [CardModal: (text: String, imageName: String)] = [
        .photoPicker: ("Photos", "photo"),
        .stickerPicker: ("Stickers", "heart.circle"),
        .framePicker: ("Frames", "square.on.circle"),
        .textPicker: ("Text", "textformat")
    ]
}

struct CardBottomToolbar: View {
    @Binding var cardModal: CardModal?
    var body: some View {
        HStack {
            Button(action: { cardModal = .photoPicker }) {
                ToolbarButtonView(cardModal: .photoPicker)
            }
            Button(action: { cardModal = .framePicker }) {
                ToolbarButtonView(cardModal: .framePicker)
            }
            Button(action: { cardModal = .stickerPicker }) {
                ToolbarButtonView(cardModal: .stickerPicker)
            }
            Button(action: { cardModal = .textPicker }) {
                ToolbarButtonView(cardModal: .textPicker)
            }
        }
    }
}

struct CardBottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        CardBottomToolbar(cardModal: .constant(.stickerPicker))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
