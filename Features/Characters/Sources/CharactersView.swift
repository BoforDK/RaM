//
//  CharactersView.swift
//  Characters
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
            initIsSearching: viewModel.initIsSearching,
            content: charactersListView,
            searchContent: searchContent
        )
        .background(Color.background)
        .navigationTitle("Characters")
    }

    func charactersListView() -> some View {
        CharacterListView(
            characters: viewModel.characters,
            favoriteIds: viewModel.favoriteIds,
            goToCharacterDetail: viewModel.actions.goToCharacterDetail(character:),
            lastElementAction: viewModel.lastElementAction,
            showTabBar: viewModel.actions.showTabBar
        )
        .errorState(
            isError: viewModel.isListError,
            action: viewModel.actions.retryList
        )
    }

    func searchContent(searchText: String) -> some View {
        CharacterListView(
            characters: viewModel.foundCharacters,
            favoriteIds: viewModel.favoriteIds,
            showEmptyView: true,
            goToCharacterDetail: viewModel.actions.goToCharacterDetail(character:),
            lastElementAction: viewModel.lastElementSearchAction,
            showTabBar: viewModel.actions.showTabBar
        )
        .errorState(
            isError: viewModel.isSearchError,
            action: viewModel.actions.retrySearch
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
