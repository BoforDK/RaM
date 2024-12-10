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
    var searchText: String = ""
    var showTabBar: (Bool) -> Void

    var body: some View {
        SearchableView(
            searchText: searchText,
            prompt: "Search character",
            content: charactersListView,
            searchContent: searchContent
        )
        .navigationTitle("Characters")
    }

    func charactersListView() -> some View {
        AllCharactersView(showTabBar: showTabBar)
            .background(Color.background)
    }

    func searchContent(searchText: String) -> some View {
        SearchView(searchText: searchText, showTabBar: showTabBar)
            .background(Color.background)
            .onAppear {
                showTabBar(false)
            }
            .onDisappear {
                showTabBar(true)
            }
    }
}

#Preview {
    CharactersView(showTabBar: { _ in })
}

