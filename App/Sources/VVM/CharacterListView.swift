//
//  CharacterListView.swift
//  App
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI
import AppCore
import AppUI

struct CharacterListView: View {
    var characters: [Person] = []
    var favoriteIds: [Int] = []
    var showEmptyView: Bool = false
    var lastElementAction: (() -> Void)?
    var showTabBar: (Bool) -> Void
    @State var offset: CGFloat = 0.0
    @State var oldOffset: CGFloat = 0.0
    @State var lastElementIsVisible = true
    private let coordinateSpaceName = "SCROLL"

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 15) {
                if showEmptyView && characters.isEmpty {
                    //todo
                    Text("Nothing was found")
                } else {
                    characterList()

                    progressView()
                        .opacity(lastElementAction == nil ? 0 : 1)
                }
            }
            .frame(maxWidth: .infinity)
            .modifier(
                OffsetModifier(
                    offset: $offset,
                    coordinateSpaceName: coordinateSpaceName
                )
            )
            .onChange(of: offset, perform: calculateShowingTabBar)
            .onAppear {
                showTabBar(true)
            }
        }
    }

    func characterList() -> some View {
        ForEach(characters, id: \.id) { character in
            NavigationLink(destination: {
                CharacterView(character: character, showTabBar: showTabBar)
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

    func characterLabel(character: Person) -> some View {
        CharacterItemView(
            character: character,
            isFavorite: favoriteIds.contains(character.id)
        )
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
                if characters.count != 0 && lastElementAction != nil {
                    lastElementIsVisible = false
                }
            }
            .onDisappear {
                lastElementIsVisible = true
            }
    }

    func calculateShowingTabBar(offset: CGFloat) {
        showTabBar((oldOffset < offset || offset > 0) && lastElementIsVisible)
        oldOffset = offset
    }
}

#Preview {
    CharacterListView(
        showTabBar: { _ in }
    )
}
