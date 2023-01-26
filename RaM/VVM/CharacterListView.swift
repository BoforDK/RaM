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
            NavigationLink(destination: {
                CharacterView(character: character)
            }, label: {
                characterLabel(character: character)
            })
            .buttonStyle(.plain)
            .onAppear {
                if characters.last?.id == character.id {
                    lastElementAction?()
                }
            }
        }
    }

    func characterLabel(character: Character) -> some View {
        CharacterItemView(character: character, isFavorite: false)
            .padding(10)
            .background(Color.listItem)
            .cornerRadius(15)
            .padding([.horizontal], 15)
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
