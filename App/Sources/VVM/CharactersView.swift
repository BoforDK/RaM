//
//  CharactersView.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI
import AppUI

struct CharactersView: View {
    @State var viewModel: CharactersViewModeling

    var body: some View {
        SearchableView(
            searchText: $viewModel.searchText,
            prompt: "Search character",
            content: charactersListView,
            searchContent: searchContent
        )
        .navigationTitle("Characters")
    }

    func charactersListView() -> some View {
        CharacterListView(
            characters: viewModel.characters,
            favoriteIds: viewModel.favoriteIds,
            lastElementAction: viewModel.lastElementAction,
            showTabBar: viewModel.actions.showTabBar
        )
    }

    func searchContent(searchText: String) -> some View {
        CharacterListView(
            characters: viewModel.foundCharacters,
            favoriteIds: viewModel.favoriteIds,
            showEmptyView: true,
            lastElementAction: viewModel.lastElementSearchAction,
            showTabBar: viewModel.actions.showTabBar
        )
    }
}

#if DEBUG
#Preview {
    CharactersView(
        viewModel: CharactersViewModelMock()
    )
}
#endif
