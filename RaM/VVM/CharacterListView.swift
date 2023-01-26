//
//  CharacterListView.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI

struct CharacterListView: View {
    var characters: [Character] = []
    var lastElementAction: (() -> Void)?

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 15) {
                characterList()

                progressView()
                    .opacity(lastElementAction == nil ? 0 : 1)
            }
            .frame(maxWidth: .infinity)
        }
    }

    func characterList() -> some View {
        ForEach(characters, id: \.id) { character in
            Text(character.origin.name)
            .onAppear {
                if characters.last?.id == character.id {
                    lastElementAction?()
                }
            }
        }
    }

    @ViewBuilder
    func progressView() -> some View {
        ProgressView()
            .frame(maxWidth: .infinity, alignment: .center)
            .onAppear {
                lastElementAction?()
            }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
