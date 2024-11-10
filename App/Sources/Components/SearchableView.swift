//
//  SearchableView.swift
//  RaM
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

struct SearchableView<Content: View, SearchContent: View>: View {
    @State var searchText: String = ""
    var prompt: String = ""
    @ViewBuilder var content: () -> Content
    @ViewBuilder var searchContent: (String) -> SearchContent
    var body: some View {
        InnerSearchableView(content: content, searchContent: {searchContent(searchText)})
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
