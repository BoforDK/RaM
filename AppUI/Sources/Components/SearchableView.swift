//
//  SearchableView.swift
//  AppUI
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

public struct SearchableView<Content: View, SearchContent: View>: View {
    @State var searchText: String = ""
    var prompt: String = ""
    @ViewBuilder var content: () -> Content
    @ViewBuilder var searchContent: (String) -> SearchContent

    public init(
        searchText: String = "",
        prompt: String = "",
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder searchContent: @escaping (String) -> SearchContent
    ) {
        self._searchText = .init(initialValue: searchText)
        self.prompt = prompt
        self.content = content
        self.searchContent = searchContent
    }

    public var body: some View {
        InnerSearchableView(
            content: content,
            searchContent: {
                searchContent(searchText)
            }
        )
        .searchable(text: $searchText, prompt: prompt)
    }
}

fileprivate struct InnerSearchableView<Content: View, SearchContent: View>: View {
    @Environment(\.isSearching) private var isSearching
    @ViewBuilder var content: () -> Content
    @ViewBuilder var searchContent: () -> SearchContent

    var body: some View {
        if isSearching {
            searchContent()
        } else {
            content()
        }
    }
}
