//
//  SearchableView.swift
//  AppUI
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

public struct SearchableView<Content: View, SearchContent: View>: View {

    @Binding var searchText: String
    @FocusState var isSearching: Bool
    var prompt: String = ""
    var initIsSearching: Bool
    @ViewBuilder var content: () -> Content
    @ViewBuilder var searchContent: (String) -> SearchContent

    public init(
        searchText: Binding<String>,
        prompt: String = "",
        initIsSearching: Bool = false,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder searchContent: @escaping (String) -> SearchContent
    ) {
        self._searchText = searchText
        self.prompt = prompt
        self.initIsSearching = initIsSearching
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
        .searchFocused($isSearching)
        .onAppear {
            isSearching = initIsSearching
        }
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
