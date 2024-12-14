//
//  CharactersView.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI
import AppUI

struct CharactersView: View {
    @Environment(\.isSearching) private var isSearching

    var viewModel: CharactersViewModeling

    var body: some View {
        SearchableView(
            prompt: "Search character",
            content: charactersListView,
            searchContent: searchContent
        )
        .navigationTitle("Characters")
    }

    func charactersListView() -> some View {
        AllCharactersView(showTabBar: viewModel.showTabBar)
            .background(Color.background)
    }

    func searchContent(searchText: String) -> some View {
        SearchView(searchText: searchText, showTabBar: viewModel.showTabBar)
            .background(Color.background)
            .onAppear {
                viewModel.showTabBar(isVisible: false)
            }
            .onDisappear {
                viewModel.showTabBar(isVisible: true)
            }
    }
}

#Preview {
    CharactersView(
        viewModel: CharactersViewModelMock()
    )
}
