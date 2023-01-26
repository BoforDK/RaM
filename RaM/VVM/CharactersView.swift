//
//  CharactersView.swift
//  RaM
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

struct CharactersView: View {
    @Environment(\.isSearching) private var isSearching
    var searchText: String = ""

    var body: some View {
        SearchableView(searchText: searchText,
                       prompt: "Search character",
                       content: charactersListView,
                       searchContent: searchContent)
    }

    func charactersListView() -> some View {
        AllCharactersView()
            .background(Color.background)
    }

    func searchContent(searchText: String) -> some View {
        SearchView(searchText: searchText)
            .background(Color.background)
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}

