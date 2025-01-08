//
//  CharacterListView.swift
//  App
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI
import AppCore

public struct CharacterListView: View {
    let characters: [Person]
    let favoriteIds: [Int]
    let showEmptyView: Bool
    let goToCharacterDetail: ((Person) -> Void)
    let lastElementAction: (() -> Void)?
    let showTabBar: (Bool) -> Void
    @State var offset: CGFloat = 0.0
    @State var lastElementIsVisible = true
    private let coordinateSpaceName = "SCROLL"

    public init(
        characters: [Person],
        favoriteIds: [Int] = [],
        showEmptyView: Bool = false,
        goToCharacterDetail: @escaping (Person) -> Void,
        lastElementAction: (() -> Void)? = nil,
        showTabBar: @escaping (Bool) -> Void
    ) {
        self.characters = characters
        self.favoriteIds = favoriteIds
        self.showEmptyView = showEmptyView
        self.goToCharacterDetail = goToCharacterDetail
        self.lastElementAction = lastElementAction
        self.showTabBar = showTabBar
        self.offset = offset
        self.lastElementIsVisible = lastElementIsVisible
    }

    public var body: some View {
        ScrollView {
            if showEmptyView && characters.isEmpty {
                VStack(spacing: 20) {
                    Image.rick
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .frame(maxWidth: .infinity)

                    Text("Nothing was found")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
            } else {
                LazyVStack(alignment: .leading, spacing: 15) {
                    characterList()

                    progressView()
                        .opacity(lastElementAction == nil ? 0 : 1)
                }
                .frame(maxWidth: .infinity)
                .coordinateSpace(name: coordinateSpaceName)
                .modifier(
                    OffsetModifier(
                        offset: $offset,
                        coordinateSpaceName: coordinateSpaceName
                    )
                )
                .onChange(of: offset, calculateShowingTabBar)
            }
        }
    }

    func characterList() -> some View {
        ForEach(characters, id: \.id) { character in
            Button {
                goToCharacterDetail(character)
            } label: {
                characterLabel(character: character)
            }
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

    func calculateShowingTabBar(oldOffset: CGFloat, newOffset: CGFloat) {
        showTabBar((oldOffset < newOffset || newOffset > 0) && lastElementIsVisible)
    }
}

#if DEBUG
#Preview {
    CharacterListView(
        characters: .mock,
        goToCharacterDetail: { _ in },
        showTabBar: { _ in }
    )
}
#endif
